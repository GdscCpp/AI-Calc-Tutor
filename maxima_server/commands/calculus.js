const { exec } = require("child_process");
const moment = require("moment");

function limit(req, res) {
  let func,
    variable,
    at,
    dir = "";
  //check req format
  if (req.body && req.body.function && req.body.variable && req.body.at) {
    func = req.body.function;
    variable = req.body.variable;
    at = req.body.at;

    if (req.body.dir) {
      dir = "," + req.body.dir;
    }
  } else {
    res.status(400).send("Invalid Request Format");
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    console.error(timestamp + "--Error 400 Bad Request--");
    return 400;
  }

  let cmd =
    "maxima -r " +
    '"limit(' +
    func +
    "," +
    variable +
    "," +
    at +
    dir +
    ');apply(tex,[%i1]);quit();" -very-quiet';

  exec(cmd, (err, data, stderr) => {
    //trim off unnecessary output
    let response = data.split("\n");
    response = response[response.length - 4];

    if (err || stderr) {
      res.status(500).send(err || stderr);
      return 500;
    }

    //only care about the latex string
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    if (response.includes("incorrect syntax")) {
      res.status(400);
      console.error(timestamp + "--Invalid Syntax--" + cmd);
    } else {
      res.status(200);
      console.log(timestamp + "--" + cmd);
    }

    res.send({ response: response });
  });
}

function diff(req, res) {
  let func,
    variable,
    depth = "";
  //check req format
  if (req.body && req.body.function && req.body.variable && req.body.depth) {
    func = req.body.function;
    variable = req.body.variable;
    depth = req.body.depth;
  } else {
    res.status(400).send("Invalid Request Format");
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    console.error(timestamp + "--Error 400 Bad Request--");
    return 400;
  }

  let cmd =
    //assuming maxima is in bin or is a non sudo command, -r means execute the command after iut
    "maxima -r " +
    //differentiate
    '"diff(' +
    func +
    "," +
    variable +
    "," +
    //this is what derivative number it is, ex 1st, 2nd, etc
    depth +
    //apply converts the output to latex
    //quit is required for all commands to end interactive mode
    //very-quiet removes almost all padding from the terminal
    ');apply(tex,[%i1]);quit();" -very-quiet';

  //execute the command on windows
  //NOTE: this needs a different module to run on linux (target os)
  exec(cmd, (err, data, stderr) => {
    //trim off unnecessary output
    let response = data.split("\n");
    response = response[response.length - 4];

    if (err || stderr) {
      res.status(500).send(err || stderr);
      return 500;
    }

    //only care about the latex string
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    if (response.includes("incorrect syntax")) {
      res.status(400);
      console.error(timestamp + "--Invalid Syntax--" + cmd);
    } else {
      res.status(200);
      console.log(timestamp + "--" + cmd);
    }

    res.send({ response: response });
  });
}

function integrate(req, res) {
  let func,
    variable,
    a,
    b = "";

  if (req.body && req.body.function && req.body.variable) {
    func = req.body.function;
    variable = req.body.variable;

    if (req.body.a) {
      a = "," + req.body.a;
    }

    if (req.body.b) {
      b = "," + req.body.b;
    }
  } else {
    res.status(400).send("Invalid Request Format");
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    console.error(timestamp + "--Error 400 Bad Request");
    return 400;
  }

  let cmd =
    "maxima -r " +
    '"integrate(' +
    func +
    "," +
    variable +
    a +
    b +
    ');apply(tex,[%i1]);quit();" -very-quiet';

  exec(cmd, (err, data, stderr) => {
    let response = data.split("\n");
    response = response[response.length - 4];

    if (err || stderr) {
      res.status(500).send(err || stderr);
      return 500;
    }

    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    if (response.includes("incorrect syntax")) {
      res.status(400);
      console.error(timestamp + "--Invalid Syntax--" + cmd);
    } else {
      res.status(200);
      console.log(timestamp + "--" + cmd);
    }

    res.send({ response: response });
  });
}

module.exports = { diff, integrate, limit };
