RSpine = require("rspine")

class TestApp extends RSpine.Controller
  className: "app-canvas"
    
  constructor: ->
    super    
    @html require("app/testApp/testApp_layout")() 

module.exports = TestApp