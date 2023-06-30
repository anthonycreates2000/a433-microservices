# Use node version 18 for building docker container.
# Alpine is a lightweight version of the original image.
FROM node:18-alpine as base

# Make an app directory, then jump to that directory.
WORKDIR /producer

# Copy all of package files from current working directory (except in .dockerignore)
# To docker container's working directory.
COPY package*.json ./

# If NODE_ENV environment is running in production mode...
FROM base as production

# Recall, this is done to keep the logging at minimum level.
ENV NODE_ENV=production

# Perform clean installation of our dependencies. 
# Note that this throws an error if the dependencies between 2 files (package and package-lock) don't match.
RUN npm ci

# Copy all of JS files from current working directory
# To docker container's working directory.
COPY ./*.js ./

# Expose port 3000 in docker container.
EXPOSE 3000

# When we launch the built image, run index.js.
CMD ["node", "index.js"]

# If NODE_ENV environment is running in development mode...
FROM base as dev

# APK stands for Alpine Linux Package Keeper (manager). 
# Alpine is used to avoid security problems.
# This allows not cache the index locally.
# This is useful to keep the containers small.
# This command is the same as apk add && rm -rf /var/cache/apk/*.
RUN apk add --no-cache bash

# This code make sure that we run RabbitMQ first before the producer connects to it.
RUN wget -O /bin/wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /bin/wait-for-it.sh

# Recall, this is done if we're still not finished with the app, so logging is massive.
ENV NODE_ENV=development

# On image build step, install all dependencies made for development.
RUN npm install

# Copy all JS file in the current directory 
# To container's current working directory.
COPY ./*.js ./

# Expose port 3000 in docker container.
EXPOSE 3000

CMD ["node", "index.js"]