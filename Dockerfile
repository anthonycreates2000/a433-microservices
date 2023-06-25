# Use node version 1.15 alpine (lightweight and secure) for building docker container.
FROM golang:1.15-alpine

# Make a new karsajobs directory, then jump to that directory.
WORKDIR /go/src/github.com/dicodingacademy/karsajobs

# Set GO111MODULE to change how Go import/ manage packages. This is done to keep the logging at minimum level.
ENV GO111MODULE=on

# Set the APP_PORT to 8080 (this app's open port in backend).
ENV APP_PORT=8080

# Copy go.mod and go.sum file to docker container's working directory.
COPY go.mod .
COPY go.sum .

# Download all dependencies by using go mod.
RUN go mod download

# Copy all of the files from current working directory (except in .dockerignore)
# To docker container's working directory.
COPY . .

# Make a new directory with name "build".
# Build files and third party libraries for running a web app.
RUN mkdir /build; \
    go build -o /build/ ./...

# Expose port 8000 in docker container
EXPOSE 8080

# Launch the backend server by navigating to /build/web
CMD ["/build/web"]
