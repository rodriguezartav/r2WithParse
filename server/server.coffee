# Modules
express = require 'express'
fs = require("fs")
grunt = require('grunt')


app = express()

app.use express.bodyParser()
app.use app.router


app.organization = organization = require("../config/organization.json")

# Routes
routes = require("./routes")
routes(app)

app.get "/" , (req,res) =>
  res.redirect "/#{app.organization.id}/index.html"

app.get "/:orgId/index.html", (req, res) ->
  grunt.file.write "./config/organization.json" , '{"name": "", "id": "' + req.params.orgId + '" }'
  res.send "<h1>Welcome to R2</h1> <p>Development Enviroment is ready to be used. Please restart the development server: $ grunt server</p>"

module.exports = app;