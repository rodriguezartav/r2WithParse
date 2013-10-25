RSpine = require("rspine")

class Test-Carlos extends RSpine.Controller
  className: "app-canvas"
    
  constructor: ->
    super    
    @html require("/Test-Carlos/Test-Carlos_layout")() 

module.exports = Test-Carlos