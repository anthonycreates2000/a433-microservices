#!/bin/bash

kubectl create namespace monitoring

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm upgrade -i prometheus prometheus-community/prometheus --namespace monitoring

kubectl get pods -n monitoring

helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-ext --namespace monitoring

helm install grafana grafana/grafana  --namespace monitoring
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-ext --namespace monitoring