# Build a docker image from dockerfile in this directory.
docker build -t item-app:v1 .

# List all images that are installed in docker.
docker images

# Rename docker image's tag, so it can be compatible with github packages' tag.
# The format for github docker image tag is: ghcr.io/<username>/<docker_image_name>:<docker_image_tag>.
docker tag item-app:v1 ghcr.io/maxzx3000/item-app:v1

# Get the password from environment variable and login to the github package account.
echo $PASSWORD_GITHUB_PACKAGES | docker login ghcr.io -u maxzx3000 --password-stdin

# Push built image to github package.
docker push ghcr.io/maxzx3000/item-app:v1