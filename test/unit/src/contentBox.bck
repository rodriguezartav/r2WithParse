jsdom = require("jsdom").jsdom
sandboxedModule = require("sandboxed-module")
should = require("should")
grunt = require('grunt');

describe "Selecting the actual Page in Header", ->
    document = null
    $ = null

    beforeEach ->
        window = jsdom(null, null, features: QuerySelector: true).createWindow()
        document = window.document
        globals = { window, document }

        document.body.innerHTML = grunt.file.read('./test/unit/fixtures/contentBox.html');

        $ = sandboxedModule.require("jquery-browserify" ,globals: globals)
        Spine = sandboxedModule.require("spine" ,globals: globals)
        requires = { "jquery-browserify": $, "spine" : Spine }

        ContentBox = sandboxedModule.require("../../app/components/contentBox/contentBox",globals: globals,requires: requires)

        new ContentBox( el: $("aside") , tagSelectors: "h2,h3" , sourceSelector: "article")

    it "it set active class to current link", ->
      document.body.innerHTML.indexOf('<div class="item">').should.be.above(-1)
