RSpine = require('rspine')


class Account extends RSpine.Model
  @configure 'Account', 'Name' 

  @extend RSpine.Model.SalesforceModel
  @extend RSpine.Model.SalesforceAjax

  @custumObject= true;

module.exports = Account