# Delete all resources in kubectl.
kubectl delete all --all

# Use this code to remove if we have a modification on PV and PVCs
# kubectl delete pv consumer-pv-volume
# kubectl delete pv producer-pv-volume
# kubectl delete pvc consumer-pv-claim
# kubectl delete pvc producer-pv-claim

# Deploy order and shipping service.
kubectl apply -f order
kubectl apply -f shipping