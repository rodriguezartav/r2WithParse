RSpine = require("rspine")

class Recibos extends RSpine.Controller
  className: "app-canvas"
    
  constructor: ->
    super    
    @html require("/recibos/recibos_layout")() 

module.exports = Recibos