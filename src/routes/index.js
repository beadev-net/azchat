/*
 * Copyright (c) Microsoft Corporation. All rights reserved.
 * Licensed under the MIT License.
 */

var express = require("express");
var router = express.Router();

router.get("/", function (req, res, next) {
  res.render("index", {
    title: "MSAL Node & Express Web App",
    isAuthenticated: req.session.isAuthenticated,
    username: req.session.account?.username,
    git_hash: process.env.GIT_HASH ?? "0000000",
  });
});

module.exports = router;
