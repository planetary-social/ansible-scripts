#!/usr/bin/env node

const allowlist = require('./peers.json');

const rl = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

rl.on('line', (line) => {
    let req = JSON.parse(line);

    if (req.type === 'lookback') {
        return; // do nothing
    }

    if (req.type !== 'new') {
        console.error("unexpected request type"); // will appear in strfry logs
        return;
    }

    let res = { id: req.event.id }; // must echo the event's id

    if (allowlist[req.event.pubkey]) {
        res.action = 'accept';
    } else {
        res.action = 'reject';
        res.msg = 'blocked: not on allowlist';
    }

    console.log(JSON.stringify(res));
});
