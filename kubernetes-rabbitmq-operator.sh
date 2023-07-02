#!/bin/bash

# Get helm package.
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 ./get_helm.sh
./get_helm.sh

# Create namespace as rabbit.
kubectl create namespace rabbit

# Install rabbitmq to rabbit namespace, with username and password from environment variables.
helm install mu-rabbit stable/rabbitmq --set rabbitmq.username=$RABBITMQ_USERNAME,rabbitmq.password=$RABBITMQ_PASSWORD --namespace rabbit

# Expose mu-rabbit-rabbitmq to access RabbitMQ Management UI.
kubectl expose service mu-rabbit-rabbitmq --type=NodePort --target-port=15672 --name=mu-rabbit-rabbitmq-ext --namespace rabbit
# kubectl expose service mu-rabbit-rabbitmq-headless --type=NodePort --target-port=15672 --name=mu-rabbit-mq-headless-ext --namespace rabbit

# Expose mu-rabbit-rabbitmq to access queuing service.
kubectl expose service mu-rabbit-rabbitmq --type=NodePort --target-port=5672 --name=mu-rabbit-rabbitmq-amqp-ext --namespace rabbit
# kubectl expose service mu-rabbit-rabbitmq-headless --type=NodePort --target-port=5672 --name=mu-rabbit-mq-headless-queue-ext --namespace rabbit
