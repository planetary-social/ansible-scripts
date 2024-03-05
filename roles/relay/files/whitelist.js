#!/usr/bin/env node

const WHITELIST = {
  pubs: {
    add5190be4673768546c18b565da3a699241f0e06a75e2dbc03f18663d1b7b27: true, // Reportinator
  },
  eventKinds: [
    0, // Metadata
    3, // Contacts
    10002, // Relay list metadata
  ],
};

const rl = require("readline").createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false,
});

rl.on("line", (line) => {
  let req = JSON.parse(line);

  if (req.type === "lookback" || req.type !== "new") {
    return;
  }

  let res = { id: req.event.id }; // must echo the event's id

  const isWhitelistedPub = WHITELIST.pubs.hasOwnProperty(req.event.pubkey);
  const isWhitelistedEventKind = WHITELIST.eventKinds.includes(req.event.kind);

  if (isWhitelistedPub || isWhitelistedEventKind) {
    res.action = "accept";
  } else {
    res.action = "reject";
    res.msg = "blocked: pubkey not on white-list or event kind not allowed";
  }

  console.log(JSON.stringify(res));
});
