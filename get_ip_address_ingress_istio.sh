# ==================================
# IMPORTANT NOTE: Make sure to run minikube tunnel first, before running this shell code.
# ==================================
# Get all inggress IP address parts to access istio external IP address.
export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

# Get the Address and Port from Ingress to access Istio.
echo "$INGRESS_HOST" "$INGRESS_PORT" "$SECURE_INGRESS_PORT"

# Make a full IP Address for accessing our application.
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT
echo "$GATEWAY_URL"
