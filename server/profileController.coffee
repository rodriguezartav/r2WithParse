fs = require("fs");
walk    = require('walk');
grunt = require('grunt');
R2Builder = require("r2-builder")
path = require('path');

# Organization is an object with an id


class ProfileController

  constructor: () ->

  read: (req, res) ->
    profiles = fs.readFileSync req.query.pathToFile , "utf-8"
    response = JSON.parse(profiles);
    res.type 'application/json'
    res.send response


  update:  (req,res) ->
    file = fs.writeFileSync req.query.pathToFile , JSON.stringify(req.body)
    res.send req.body


module.exports = ProfileController