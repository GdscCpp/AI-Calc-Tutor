//docker cmd: docker run --rm -p 3000:3000 -it --security-opt seccomp=unconfined blbergo/maxima_server:v1.1

const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const {integrate, diff, limit } = require("./commands/maxima");
const {integrate_w_steps, diff_w_steps } = require("./commands/sympy");
const port = 3000;

let jsonParser = bodyParser.json();

app.post("/v1/limit/", jsonParser, (req, res) => {
  limit(req, res);
});

//find derivatives
//req format: {function:'string',variable:'string',depth:'int'}
app.post("/v1/diff/", jsonParser, (req, res) => {
  if (req.body.steps == true) {
    diff_w_steps(req, res);
  } else {
    diff(req, res);
  }
});

//integrate
//req format: {function:'string',variable:'string', steps:'bool'}
app.post("/v1/integrate/", jsonParser, (req, res) => {
  if(req.body.steps == true) 
  {
    integrate_w_steps(req,res)
  } else 
  {
    integrate(req, res);
  }
});

app.listen(port, () => {
  console.log(`Maxima server listening on port ${port}`);
});
