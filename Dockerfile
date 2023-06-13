# Use node version 14 for building docker container.
FROM node:14

# Make an app directory, then jump to that directory.
WORKDIR /app

# Copy all of the files from current working directory (except in .dockerignore)
# To docker container's working directory.
COPY . .

# Set NODE_ENV environment to production mode. This is done to keep the logging at minimum level.
# Set DB_HOST environment to item-db for representing the name of the database.
ENV NODE_ENV=production DB_HOST=item-db

# On image build step, install all dependencies made for production.
# Then, build files and third party libraries for running a web app.
RUN npm install --production --unsafe-perm && npm run build

# Expose port 8080 in docker container.
EXPOSE 8080

# When we launch the built image, run npm start.
CMD ["npm", "start"]