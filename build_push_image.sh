docker build -t item-app:v1 .

docker images

docker tag item-app:v1 ghcr.io/maxzx3000/item-app:v1

echo $PASSWORD_GITHUB_PACKAGES | docker login ghcr.io -u maxzx3000 --password-stdin

docker push ghcr.io/maxzx3000/item-app:v1