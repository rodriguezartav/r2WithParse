RSpine = require("rspine")
CreateApp = require("app/pedidos/createApp")

class Name extends RSpine.Controller
  className: "app-canvas"

  elements:
    ".create-placeholder" : "createPlaceholder"
   
  events:
    "click .js-create-pedido" : "onCreatePedido"
   
  constructor: ->
    super    
    @html require("app/pedidos/pedidosApp_layout")() 
    @createPlaceholder.hide()


  onShutdownPedido: ->
    @createPlaceholder.hide()
    @createApp = null

  onCreatePedido: (e) =>
    if @createApp 
      @createPlaceholder.hide()
      @createApp = null
    else
      @createPlaceholder.show()
      @createApp = new CreateApp(el: @createPlaceholder)

module.exports = Name