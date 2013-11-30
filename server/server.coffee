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

module.exports = app;