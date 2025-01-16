const express = require("express");
const http = require("http");
const WebSocket = require("ws");
const Redis = require("ioredis");

const redisPublisher = new Redis({
  host: "azchat.redis.cache.windows.net",
  port: 6380,
  password: "G2Kgx3pJRkG7LOYGm4T3E0ouWquMfmEvVAzCaPz7x0M=",
  tls: {},
});

const redisSubscriber = new Redis({
  host: "azchat.redis.cache.windows.net",
  port: 6380,
  password: "G2Kgx3pJRkG7LOYGm4T3E0ouWquMfmEvVAzCaPz7x0M=",
  tls: {},
});

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

// app.get("/", (req, res) => {
//   res.sendFile("index.html", { root: __dirname });
// });

wss.on("connection", (ws) => {
  console.log("Client Connected");
  redisSubscriber.on("message", (channel, message) => {
    ws.send(message);
  });
  redisSubscriber.subscribe("chat");

  ws.on("message", (data) => {
    const parsed = JSON.parse(data);
    const color =
      parsed.email == "viniciusmd@education.taking.com" ? "#0fffc1" : "#ff0080";
    const chatMessage = `<span style="color: ${color}">${parsed.email}:</span> ${parsed.message}`;

    redisPublisher.publish("chat", chatMessage);
  });

  ws.on("close", () => {
    console.log("Client Disconnected");
  });
});

// Iniciar servidor
const PORT = process.env.PORT ?? 3000;
server.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
