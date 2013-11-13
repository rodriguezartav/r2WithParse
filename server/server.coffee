# Modules
express = require 'express'
app = express()

app.use express.bodyParser()
app.use app.router

app.organization = organization = require("../organization.json")

# Routes
routes = require("./routes")
routes(app)


module.exports = app;