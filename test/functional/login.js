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
    return before(function(done) {
      this.app = express();
      this.app.use(express.bodyParser());
      this.server = this.app.listen(3001);
      this.app.get("/salesforce/login", function(req, res) {
        return res.send("ok");
      });
      return done();
    });
  });

}).call(this);
