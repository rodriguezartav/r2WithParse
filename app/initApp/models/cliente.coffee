RSpine = require('rspine') 

class Cliente extends RSpine.Model
  @configure 'Cliente', 'Name', 'CodigoExterno' , "Activo" , "Saldo" , "DiasCredito" , "CreditoAsignado" , "Rating_Crediticio",
  "Negociacion" , "LastModifiedDate" , "Ruta" , "Transporte" , "Direccion" , "Telefono"  , "RutaTransporte" 

  @extend RSpine.Model.SalesforceModel
  @extend RSpine.Model.Ajax 

  @querySinceLastUpdate = true

  @avoidInsertList = ["Name","Rating_Crediticio","CodigoExterno","Activo","Saldo","DiasCredito" , "LastModifiedDate" , "Meta" , "Ventas" , "PlazoRecompra","PlazoPago"]

  @filters:
    "" : " Activo__c = true"
    "conSaldo" : " Saldo__c != 0"
    "credito":" CreditoAsignado__c > 0 and DiasCredito__c > 0"
    "contado":" CreditoAsignado__c = 0 and DiasCredito__c = 0"

  @to_name_array: ->
    clientes = Cliente.all()
    names = []
    for cliente in clientes
      names.push cliente.Name
    return names

  validate: ->
    unless @Name
      "El nombre del cliente es obligatorio"

  willOverDraft: (monto) ->
    od = false
    od = true if monto + @Saldo > @CreditoAsignado
    return od

  filterByName: (query,item) =>
    return false if item.Activo == false
    return false if item.DiasCredito  > 0  and  @contado == true
    return false if item.DiasCredito == 0  and  @contado == false
    return false if !item.Name
    myRegExp =new RegExp( Cliente.queryToRegex(query),'gi')
    result = item.Name.search(myRegExp) > -1 or String(item.CodigoExterno).indexOf(query) == 0
    return result
    
  @typeAheadMatcher: (item) ->
    return false if !item
    return true if (item.toLowerCase().indexOf(this.query.trim().toLowerCase()) != -1)

  @typeAheadSorter: (items) ->
      return items.sort()
  
  @typeAheadHighlighter: (item) ->
    regex = new RegExp( '(' + this.query + ')', 'gi' );
    return item.replace( regex, "<strong>$1</strong>" );

  @typeAheadSource:  (query, process) ->
    clientes = [];
    map = {};

    for cliente in Cliente.all()
      map[cliente.Name] = cliente
      clientes.push cliente.Name

    console.log clientes
    process(clientes);


module.exports = Cliente