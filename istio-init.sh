# Add environment variable path so we can access istioctl command.
export PATH=$PWD/bin:$PATH

# Install Istioctl with demo profile for basic functionality.
istioctl install --set profile=demo -y

# Set istio envo proxy injection to kubernetes with namespace default.
kubectl label namespace default istio-injection=enabled

# Deploy istio to kubernetes.
kubectl apply -f istio

# Check to make sure that Istio works well in our service.
istioctl analyze

# Make sure to access minikube tunnel. This is important, because we'll send traffic to Istio Inggress Gateway.
# This acts as external load balancer for kubernetes service.
# By default, the name of the tunnel is istio-ingressgateway.
minikube tunnel
