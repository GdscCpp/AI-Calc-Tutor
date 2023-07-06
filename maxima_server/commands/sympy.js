const { exec } = require("child_process");
const moment = require("moment");

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

    res.send({ response: response });
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

    //only care about the latex string
    let timestamp = moment().format("MM-DD-yyyy:hh:mm:ss");

    res.status(200);
    console.log(timestamp + "--" + cmd);

    res.send({ response: response });
  });
}

module.exports = { integrate_w_steps, diff_w_steps };
