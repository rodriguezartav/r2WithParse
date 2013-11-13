fs = require("fs");
walk    = require('walk');
grunt = require('grunt');
R2Builder = require("r2-builder")
path = require('path');

class AppController

  constructor: () ->

  read: (req, res) ->
    files   = [];
    walker  = walk.walk req.query.appPath, { followLinks: true }

    walker.on 'file', (root, stat, next) ->      
      if stat.name == "component.json"
        filePath = root + '/' + stat.name;
        fileContents = JSON.parse fs.readFileSync(filePath)
        fileContents.path = root;
        delete fileContents.id;
        files.push fileContents

      next();

    walker.on 'end', ->
      res.type 'application/json'
      res.send files
    

  create: (req, res) ->
    try
      results = R2Builder.build { "app": req.body , "component": req.body , "style": req.body , "layout": req.body } 
      grunt.file.write req.body.appPath + "/" + req.body.name + "/" + req.body.name + ".coffee" , results["app"]  
      grunt.file.write req.body.appPath + "/" + req.body.name + "/component.json" , results["component"]  
      grunt.file.write req.body.appPath + "/" + req.body.name + "/style.less" , results["style"]  
      grunt.file.write req.body.appPath + "/" + req.body.name + "/layout.eco" , results["layout"]
    catch error
      res.status 501
      res.send "Error creating App Folder and Files " + JSON.stringify error
    
    res.send(req.body);

  update: (req,res) ->
    path = req.query.appPath
    
    parts = path.split("/")
    parts.pop()
    path = parts.join("/")

    fs.writeFileSync path + "/" + req.body.name + "/component.json", JSON.stringify(req.body)
    res.send(200);

  delete: (req,res) ->
    appPath = req.query.appPath
    try
      grunt.file.delete appPath
      res.send 200
    catch error
      res.status 501
      res.send "Error deleting path " + path


module.exports = AppController