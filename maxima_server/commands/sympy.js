const { exec } = require("child_process");
const moment = require("moment");
const unified = require("@unified-latex/unified-latex-util-to-string")

function integrate_w_steps(req, res) {
  if (req.body && req.body.function) {
    func = req.body.function;
  } else {
    res.status(400).send("Invalid Request Format");
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    console.error(timestamp + "--Error 400 Bad Request--");
    return 400;
  }

  let cmd = 'python ./commands/steps.py int "' + func + '"';

  exec(cmd, (err, data, stderr) => {
    //trim off unnecessary output
    let response = data.split("\n");

    if (err || stderr) {
      res.status(500).send(err || stderr);
      return 500;
    }

    //only care about the latex string
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");

    res.status(200);
    console.log(timestamp + "--" + cmd);

    res.send({ result: response });
  });
}

//only take first deriv for now
function diff_w_steps(req, res) {
  if (req.body && req.body.function) {
    func = req.body.function;
  } else {
    res.status(400).send("Invalid Request Format");
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    console.error(timestamp + "--Error 400 Bad Request--");
    return 400;
  }

  let cmd = 'python ./commands/steps.py diff "' + func + '"';

  exec(cmd, (err, data, stderr) => {
    //trim off unnecessary output
    let response = data.split("\n");

    if (err || stderr) {
      res.status(500).send(err || stderr);
      return 500;
    }
    
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");

    res.status(200);
    console.log(timestamp + "--" + cmd);

    res.send({ response: response });
  });
}

//req format: {"expression":string, "latex":bool}
function simplify(req, res) {
  latex = "false"
  if (req.body && req.body.expression && req.body.latex) {
    func = req.body.expression;

    if(req.body.latex == true) 
    {
      latex = "true"
    }

  } else {
    res.status(400).send("Invalid Request Format");
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");
    console.error(timestamp + "--Error 400 Bad Request--");
    return 400;
  }

  let cmd = 'python ./commands/steps.py simplify "' + func + '" ' + latex;

  exec(cmd, (err, data, stderr) => {
    //trim off unnecessary output
    let response = data.split("\n");

    if (err || stderr) {
      res.status(500).send(err || stderr);
      return 500;
    }

    //only care about the latex string
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");

    res.status(200);
    console.log(timestamp + "--" + cmd);

    res.send({ result: response });
  });
}

module.exports = { integrate_w_steps, diff_w_steps, simplify };
