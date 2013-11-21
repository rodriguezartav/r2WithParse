RSpine = require("rspine")

class Name extends RSpine.Controller
  className: "app-canvas"

  elements:
    ".proformas-list" : "proformasList"
    ".guardados-list" : "guardadosList"
    ".pendientes-list" : "pendientesList"
    ".aprobados-list" : "aprobadosList"
    ".facturados-list" : "facturadosList"
      
  constructor: ->
    super
    @html require("app/pedidos/pedidosApp_layout")()
    @proformasList.html require ("app/pedidos/proformasItem")
    @guardadosList.html require ("app/pedidos/guardadosItem")
    @pendientesList.html require ("app/pedidos/pendientesItem")
    @aprobadosList.html require ("app/pedidos/aprobadosItem")
    @facturadosList.html require ("app/pedidos/facturadosItem")

module.exports = Name