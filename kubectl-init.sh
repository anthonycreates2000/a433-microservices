kubectl delete all --all
# kubectl delete pv consumer-pv-volume
# kubectl delete pv producer-pv-volume
# kubectl delete pvc consumer-pv-claim
# kubectl delete pvc producer-pv-claim


kubectl apply -f order
kubectl apply -f shipping