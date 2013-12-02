# Modules
express = require 'express'
app = express()

app.use express.bodyParser()
app.use app.router

app.organization = organization = require("../config/organization.json")

# Routes
routes = require("./routes")
routes(app)


app.get "/" , (req,res) =>
  res.redirect "/#{app.organization.id}/index.html"

app.use (req, res) ->
  res.send "<h1>Welcome to R2</h1> <p>Edit the file located in config/organization.json to add your organizationId, then restart grunt server to get the Platform running</p>"

module.exports = app;