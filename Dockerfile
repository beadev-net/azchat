FROM node:20-alpine

ENV PORT=80

ARG GIT_HASH
ENV GIT_HASH=$GIT_HASH

WORKDIR /app

COPY ./src/package*.json ./

RUN npm install

COPY ./src .

EXPOSE $PORT

ENTRYPOINT [ "npm", "run", "start" ]
