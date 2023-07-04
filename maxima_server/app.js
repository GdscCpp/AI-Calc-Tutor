//docker cmd: docker run --rm -p 3000:3000 -it --security-opt seccomp=unconfined blbergo/maxima_server:v1.1

const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const { integrate, diff, limit } = require("./commands/maxima");
const port = 3000;

let jsonParser = bodyParser.json();

app.post("/v1/limit/", jsonParser, (req, res) => {
  limit(req, res);
});

//find derivatives
//req format: {function:'string',variable:'string',depth:'int'}
app.post("/v1/diff/", jsonParser, (req, res) => {
  diff(req, res);
});

//integrate
//req format: {function:'string',variable:'string'}
app.post("/v1/integrate/", jsonParser, (req, res) => {
  integrate(req, res);
});

app.listen(port, () => {
  console.log(`Maxima server listening on port ${port}`);
});
