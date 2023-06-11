FROM node:14

WORKDIR /app

copy . .

RUN npm install

ENV NODE_ENV=production DB_HOST=item-db

RUN npm install --production --unsafe-perm && npm run build

EXPOSE 8080

CMD ["npm", "start"]