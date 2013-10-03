RSpine = require("rspine")
$ = window.$ if !$

class Name extends RSpine.Controller
  @className: ""

   
  constructor: ->
    super    
    @html require("apps/pedidos/name_layout")()

module.exports = Name