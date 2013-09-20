(function() {
  var grunt, jsdom, sandboxedModule, should;

  jsdom = require("jsdom").jsdom;

  sandboxedModule = require("sandboxed-module");

  should = require("should");

  grunt = require('grunt');

  describe("Selecting the actual Page in Header", function() {
    var $, document;
    document = null;
    $ = null;
    beforeEach(function() {
      var ContentBox, Spine, globals, requires, window;
      window = jsdom(null, null, {
        features: {
          QuerySelector: true
        }
      }).createWindow();
      document = window.document;
      globals = {
        window: window,
        document: document
      };
      document.body.innerHTML = grunt.file.read('./test/unit/fixtures/contentBox.html');
      $ = sandboxedModule.require("jquery-browserify", {
        globals: globals
      });
      Spine = sandboxedModule.require("spine", {
        globals: globals
      });
      requires = {
        "jquery-browserify": $,
        "spine": Spine
      };
      ContentBox = sandboxedModule.require("../../app/components/contentBox/contentBox", {
        globals: globals,
        requires: requires
      });
      return new ContentBox({
        el: $("aside"),
        tagSelectors: "h2,h3",
        sourceSelector: "article"
      });
    });
    return it("it set active class to current link", function() {
      return document.body.innerHTML.indexOf('<div class="item">').should.be.above(-1);
    });
  });

}).call(this);
