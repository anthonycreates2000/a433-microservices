# Use node version 14 alpine (lightweight and secure) for building docker container.
FROM node:14.21-alpine as builder

# Make an app directory, then jump to that directory.
WORKDIR /app

# Copy all package.json related files, then copy to docker container's working directory.
COPY package*.json ./

# On image build step, install all dependencies.
RUN npm install

# Copy all of the files from current working directory (except in .dockerignore)
# To docker container's working directory.
COPY . .

# Build files and third party libraries for running a web app.
RUN npm run build

# Expose port 8000 in docker container.
EXPOSE 8000

# When we launch the built image, run npm run serve to launch the app. 
CMD [ "npm", "run", "serve" ]
