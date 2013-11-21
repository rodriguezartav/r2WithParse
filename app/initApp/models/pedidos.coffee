RSpine = require('rspine')

class Account extends RSpine.Model
  @configure 'Oportunidad', 'Estado', 'Cliente' 

  @extend RSpine.Model.SalesforceModel
  @extend RSpine.Model.SalesforceAjax

  @custumObject= true;

module.exports = Oportunidad