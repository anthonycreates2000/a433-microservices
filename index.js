// Dotenv is a dependency for loading environment variables from a .env file into process.env
require('dotenv').config()

// Set express as the server for the app. 
const express = require("express");
const app = express();

// Body-parser module parses the JSON, buffer, string and URL encoded data submitted using HTTP POST request.
const bp = require("body-parser");

// Initialize amqplib for initializing RabbitMQ.
// Then, we define the URL from kubernetes' environment variable.
const amqp = require("amqplib");
const amqpServer = process.env.AMQP_URL;
var channel, connection;

// After the app is initialized, try connecting to RabbitMQ's messaging queue.
connectToQueue();

// Set the function to connect to RabbitMQ's messaging queue.
// Let's connect to RabbitMQ's messaging service, so we can consume the message.
// Then, print the output of the message if we're able to access the queue from "order".
async function connectToQueue() {
    try {
        connection = await amqp.connect(amqpServer);
        channel = await connection.createChannel();
        await channel.assertQueue("order");
        channel.consume("order", data => {
            console.log(`Order received: ${Buffer.from(data.content)}`);
            console.log("** Will be shipped soon! **\n")
            channel.ack(data);
        });
    } catch (ex) {
        console.error(ex);
    }
}

// Make this app available to be accessed within the specified port in environment variable
// in kubernetes.
app.listen(process.env.PORT, () => {
    console.log(`Server running at ${process.env.PORT}`);
});
