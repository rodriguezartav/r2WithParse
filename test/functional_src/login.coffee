assert = require('assert');
Browser = require('zombie');
express = require("express")

describe 'pages', ->

  after (done) ->
    @server.close()
    done()

  before (done) ->

    @app = express()
    @app.use express.bodyParser()
    @server = @app.listen 3001

    @app.get "/salesforce/login" , (req,res) ->
      res.redirect "http://localhost:7770/login.html"

    done()


  it 'should show contact a form', (done) ->

    browser = new Browser();

    browser.visit 'http://localhost:7770/login.html' , ->
      browser.clickLink ".btn-salesforce", ->
        assert.ok(browser.success);
        done()
