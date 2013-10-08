RSpine = require("rspine")

class CreateApp extends RSpine.Controller
  className: "sub-app-canvas"

  constructor: ->
    super    
    @html require("app/pedidos/createApp_layout")() 

module.exports = CreateApp