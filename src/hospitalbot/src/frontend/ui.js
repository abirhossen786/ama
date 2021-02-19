#!/usr/bin/env node

'use strict';

const uiServerPort = 3000;

const rosnodejs = require('rosnodejs');
const express = require('express');
const std_msgs = rosnodejs.require('std_msgs').msg;
const path = require('path');
const app = express();
const http = require('http').Server(app);
const io = require('socket.io')(http);

app.use(express.static(path.join(__dirname, 'public')));

rosnodejs.initNode('/ui_node')
  .then((rosNode) => {
    let batterySub = rosNode.subscribe('/battery', std_msgs.String,
      data => {
        io.emit('battery', data.data);
      }
    );
  });

http.listen(uiServerPort, () => {
  console.log('UI server started on port ' + uiServerPort);
});