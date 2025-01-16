const Redis = require("ioredis");
const redisHost = process.env.REDIS_HOST;
const redisPort = process.env.REDIS_PORT;
const redisPassword = process.env.REDIS_PASSWORD;

if (!redisHost || !redisPort) {
  throw new Error("Missing Redis configuration");
}

const redisPublisher = new Redis({
  host: redisHost,
  port: redisPort,
  password: redisPassword,
});

const redisSubscriber = new Redis({
  host: redisHost,
  port: redisPort,
  password: redisPassword,
});

module.exports = { redisPublisher, redisSubscriber };
