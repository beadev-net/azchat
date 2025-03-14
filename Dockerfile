#FROM node:20-alpine
FROM mcr.microsoft.com/azure-functions/node:4-node20

ARG BUILD_PORT=80
ENV PORT=$BUILD_PORT

ARG GIT_HASH
ENV GIT_HASH=$GIT_HASH

WORKDIR /app

COPY ./src/package*.json ./

RUN npm install

COPY ./src .
COPY ./src/.env.example .env

EXPOSE $PORT

ENTRYPOINT [ "npm", "run", "start" ]
