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

module.exports = app;