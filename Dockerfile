FROM --platform=linux/amd64 node:20

ENV PORT=80

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 80

ENTRYPOINT [ "npm", "run", "start" ]
