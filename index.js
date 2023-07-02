// Dotenv is a dependency for loading environment variables from a .env file into process.env
require('dotenv').config()

// Set express as the server for the app. 
const express = require("express");
const app = express();

// Body-parser module parses the JSON, buffer, string and URL encoded data submitted using HTTP POST request.
const bp = require("body-parser");
app.use(bp.json());

// Initialize amqplib for initializing RabbitMQ.
// Then, we define the URL from kubernetes' environment variable.
const amqp = require("amqplib");
const amqpServer = process.env.AMQP_URL;
var channel, connection;

// After the app is initialized, try connecting to RabbitMQ's messaging queue.
connectToQueue();

// Set the function to connect to RabbitMQ's messaging queue.
// If I can connect, then we print the message "Connected to the queue!".
async function connectToQueue() {
    connection = await amqp.connect(amqpServer);
    channel = await connection.createChannel();
    try {
        const queue = "order";
        await channel.assertQueue(queue);
        console.log("Connected to the queue!")
    } catch (ex) {
        console.error(ex);
    }
}

// If the URL path is "/order"...
// Begin creating the order message to RabbitMQ's message queue.
app.post("/order", (req, res) => {
    const { order } = req.body;
    createOrder(order);
    res.send(order);
});

// Set the function for init message to RabbitMQ's message queue.
const createOrder = async order => {
    const queue = "order";
    await channel.sendToQueue(queue, Buffer.from(JSON.stringify(order)));
    console.log("Order succesfully created!")
    process.once('SIGINT', async () => { 
        console.log('got sigint, closing connection');
        await channel.close();
        await connection.close(); 
        process.exit(0);
    });
};

// Make this app available to be accessed within the specified port in environment variable
// in kubernetes.
app.listen(process.env.PORT, () => {
    console.log(`Server running at ${process.env.PORT}`);
});

