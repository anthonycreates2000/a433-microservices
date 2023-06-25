# Build a docker image from dockerfile in this directory.
docker build -t anthony_max/karsajobs:latest  .

# Rename docker image's tag, so it can be compatible with github packages' tag.
# The format for github docker image tag is: ghcr.io/<username>/<docker_image_name>:<docker_image_tag>.
docker tag anthony_max/karsajobs:latest ghcr.io/maxzx3000/anthony_max/karsajobs:latest

# Get the password from environment variable and login to the github package account.
echo $PASSWORD_GITHUB_PACKAGES | docker login ghcr.io -u maxzx3000 --password-stdin

# Push built image to github package.
docker push ghcr.io/maxzx3000/anthony_max/karsajobs:latest