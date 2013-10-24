RSpine = require("rspine")

class NuevaApp extends RSpine.Controller
  className: "app-canvas"
    
  constructor: ->
    super    
    @html require("/nuevaApp/nuevaApp_layout")() 

module.exports = NuevaApp