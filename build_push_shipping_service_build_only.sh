# Build a docker image from dockerfile in this directory.
# Note that we only targetting dev build, since this is used for messaging service in RabbitMQ.
docker build --target dev -t shipping_build-service:v1 .

# List all images that are installed in docker.
docker images

# Rename docker image's tag, so it can be compatible with github packages' tag.
# The format for github docker image tag is: ghcr.io/<username>/<docker_image_name>:<docker_image_tag>.
docker tag shipping_build-service:v1 ghcr.io/anthonycreates2000/shipping_build-service:v1

# Get the password from environment variable and login to the github package account.
echo $PASSWORD_GITHUB_PACKAGES | docker login ghcr.io -u anthonycreates2000 --password-stdin

# Push built image to github package.
docker push ghcr.io/anthonycreates2000/shipping_build-service:v1