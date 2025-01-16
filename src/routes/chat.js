/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License.
 */

var express = require("express");
var router = express.Router();

router.get("/", function (req, res, next) {
  res.render("chat", {
    isAuthenticated: req.session.isAuthenticated,
    username: req.session.account?.username,
    stack: process.env.STACK.split(","),
    websocket_url: process.env.WEBSOCKET_URL,
  });
});

module.exports = router;
