//docker cmd: docker run --rm -p 3000:3000 -it --security-opt seccomp=unconfined blbergo/maxima_server:v1

const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const { exec } = require("child_process");

const port = 3000;


let jsonParser = bodyParser.json();

//find derivatives
//req format: {function:'string',variable:'string',depth:'int'}
app.post("/v1/dif/", jsonParser, (req, res) => {
  let func = req.body.function;
  let variable = req.body.variable;
  let depth = req.body.depth;

  let cmd =
    //assuming maxima is in bin or is a non sudo command, -r means execute the command after iut
    "maxima -r " +
    //differentiate
    "'diff(" +
    func +
    "," +
    variable +
    "," +
    //this is what derivative number it is, ex 1st, 2nd, etc
    depth +
    //apply converts the output to latex
    //quit is required for all commands to end interactive mode
    //very-quiet removes almost all padding from the terminal
    ");apply(tex,[%i1]);quit();' -very-quiet";

  console.log(cmd);

  //execute the command on windows
  //NOTE: this needs a different module to run on linux (target os)
  exec(cmd, (err, stdout, stderr) => {
    //trim off unnecessary output
    let response = stdout.split("\n");

    //only care about the latex string
    res.send({ response: response[response.length - 4] });

  });
});

//integrate
//req format: {function:'string',variable:'string'}
app.post("/v1/integrate/", jsonParser, (req, res) => {
  let func = req.body.function;
  let variable = req.body.variable;

  let cmd =
    "maxima -r " +
    "'integrate(" +
    func +
    "," +
    variable +
    ");apply(tex,[%i1]);quit();' -very-quiet";

  console.log(cmd);
  exec(cmd, (err, stdout, stderr) => {
    let response = stdout.split("\n");

    console.log(err, stderr)

    res.send({ response: response[response.length - 4] });
  });
});

app.listen(port, () => {
  console.log(`Maxima app listening on port ${port}`);
});
