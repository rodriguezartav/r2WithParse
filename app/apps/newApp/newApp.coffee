RSpine = require("rspine")

class NewApp extends RSpine.Controller
  className: "app-canvas"
    
  constructor: ->
    super    
    @html require("app/newApp/newApp_layout")() 

module.exports = NewApp