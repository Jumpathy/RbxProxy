// Something you should know is I'm not proficient in nodejs so this is horrible but it works

const axios = require("axios");
const http = require("http");
const base64 = require("base-64");
const fastify = require("fastify")({
  logger: false
});

function token(cookie, handle) {
  var config = {
    method: "POST",
    url: "https://auth.roblox.com/v2/logout",
    headers: {
      "Content-Length": 0,
      "X-CSRF-TOKEN": null,
      Cookie: ".ROBLOSECURITY=" + cookie
    }
  };

  axios(config)
    .then(function(response) {})
    .catch(function(error) {
      if (error.response) {
        if (error.response.status == 403) {
          handle(error.response.headers["x-csrf-token"]);
        } else {
          handle();
        }
      }
    });
}

function run(error) {}

function handle(config, callback) {
  axios(config)
    .then(function(response) {
      callback(response);
    })
    .catch(function(error) {
      callback(error, error.response.status);
    });
}

var count = 0;
function apiRequest(url, request, reply) {
  var method = request.query.method;
  var config = {
    method: method,
    url: url,
    headers: request.body || {}
  };
  
  if (config.headers.body) {
    config.body = config.headers.body;
    delete config.headers["body"];
  }
  
  if (config.headers.urlExtension !== undefined) {
    config.url = config.url + config.headers.urlExtension;
    delete config.headers.urlExtension;
  }

  if (config.headers.External) {
    for (var k in config.headers.External) {
      config[k] = config.headers.External[k];
      delete config.headers.External[k];
    }
    delete config.headers.External;
  }

  var doYield = false;
  if (config.headers.authenticate == "true") {
    doYield = true;
    token(config.headers.authentication, function(token) {
      if (token !== undefined) {
        config.headers["X-CSRF-TOKEN"] = token;
        config.headers["Cookie"] =
          ".ROBLOSECURITY=" + config.headers.authentication;
        delete config.headers["authentication"];
        delete config.headers["authenticate"];
        handle(config, function(re, isErr) {
          var code = isErr || re.status || 400;
          reply.code(code).send(re.data);
        });
      } else {
        reply.code(400).send({
          failed: true
        });
      }
    });
  }
  if (doYield == false) {
    handle(config, function(re) {
      reply.code(re.status || 400).send(re.data);
    });
  }
}

function decode(encoded) {
  return base64.decode(encoded);
}

// im not even good at js how in the hell did I write this and have it work

const delay = ms => new Promise(resolve => setTimeout(resolve, ms)); // may have stolen this from stackoverflow hehe
const last = [];
const pending = [];
const full = [];

const getShout = async function(groupId,res,rej) { // bad caching system LOL
    // this makes it so you could make a large amnt of getShout requests and if one hasn't finished before you send the next it'll cache together
    if(pending[groupId] !== false && pending[groupId] !== undefined) {
        return pending[groupId][2];
    }
    const groupShoutPromise = new Promise((resolve, reject) => {res = resolve;rej = reject;});
    pending[groupId] = [res,rej,groupShoutPromise];
    var errored = false;
    var url = "https://groups.roblox.com/v1/groups/" + groupId + "/";
    var handle = function(err) {errored = true};
    var response = await axios.get(url).catch(handle);
    pending[groupId] = false;
    if(errored == false) {
        res(response.data["shout"]);
        return response.data["shout"];
    } else {
        res(null);
        return null;
    }
}

fastify.get("/shoutchanged/:groupId", function(request, reply) { // longpolling thing with somewhat caching
    var groupId = request.params.groupId;
    var run = async function(gid) {
        var doBreak = false;
        for (var i = 0; i < 22; i++) {
            if(doBreak) {
                break;
            }
            getShout(gid).then(function(resp){
                if(last[gid] == undefined && resp !== null){
                    last[gid] = resp["body"];
                }
                if(resp !== null) {
                    full[gid] = resp;
                    if(resp["body"] !== last[gid]) {
                      doBreak = true;
                      reply.code(200).send({"currentshout":resp["body"],"success":true,"fullshout":resp});
                    }
                    last[gid] = resp["body"];
                }
            })
            await delay(1000);
        }
        if(doBreak == false) {
            reply.code(400).send({"body":null,"error":"timeout","success":false,"fullshout":full[gid],"currentshout":last[gid]});
        }
    }
    run(groupId);
});

fastify.post("/request", function(request, reply) {
  if (request.query.method == undefined) {
    reply.code(400).send({ error: "no method provided" });
  } else {
    if (request.query.url !== undefined) {
      apiRequest("https://" + decode(request.query.url), request, reply);
    } else {
      reply.code(400).send({ error: "no url provided" });
    }
  }
});

fastify.get("/", function(req, rep) {
  rep.send("ping recieved");
});

fastify.listen(process.env.PORT, function(err, address) {
  if (err) {
    fastify.log.error(err);
    process.exit(1);
  }
  console.log(`Your app is listening on ${address}`);
  fastify.log.info(`server listening on ${address}`);
});

var projectName = process.env.PROJECT_DOMAIN;
if (projectName !== undefined) {
  var url = "https://" + projectName + ".glitch.me/";
  setInterval(() => {
    axios.get(url);
  }, 250000);
}