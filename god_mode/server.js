'use strict';

var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');
var app = require(path.resolve('./helpers/exports/app')).app;
var log = require(path.resolve('./helpers/exports/logger')).createLogger;
require('app-module-path').addPath(__dirname + '/');
var http = require('http');
var https = require('https');
http.globalAgent.maxSockets = https.globalAgent.maxSockets = 25;

var config = require(path.resolve('./helpers/exports/export_config')).config;

app.setup(__dirname);

process.on('uncaughtException', function (err) {
    log.fatal({part: 'uncaughtException', data: err}, 'uncaughtException ');
});

var httpServer = http.createServer(app);
var httpsServer = https.createServer(config.server.ssl, app);

httpServer.listen(config.server.port, function() {
    log.info({part: 'http'}, 'listening instance on port ' + config.server.port);
});
httpsServer.listen(config.server.secure_port, function() {
    log.info({part: 'https'}, 'listening secure instance on port ' + config.server.secure_port);
});
