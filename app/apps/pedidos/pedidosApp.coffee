RSpine = require("rspine")
$ = window.$ if !$

class Name extends RSpine.Controller
  @className: ""

   
  constructor: ->
    super    
    @html require("app/pedidos/pedidosApp_layout")() 

module.exports = Name