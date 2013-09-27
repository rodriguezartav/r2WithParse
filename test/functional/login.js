(function() {
  var Browser, assert, express;

  assert = require('assert');

  Browser = require('zombie');

  express = require("express");

  describe('pages', function() {
    after(function(done) {
      this.server.close();
      return done();
    });
    before(function(done) {
      this.app = express();
      this.app.use(express.bodyParser());
      this.server = this.app.listen(3001);
      this.app.get("/salesforce/login", function(req, res) {
        return res.send("ok");
      });
      return done();
    });
    return it('should show contact a form', function(done) {
      var browser;
      browser = new Browser();
      return browser.visit('http://localhost:7770/login.html', function() {
        return browser.clickLink(".btn-salesforce", function() {
          assert.ok(browser.success);
          return done();
        });
      });
    });
  });

}).call(this);
