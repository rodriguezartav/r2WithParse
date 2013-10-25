RSpine = require('rspine')


class Account extends RSpine.Model
  @configure 'Account', 'Name' 

  @extend RSpine.Model.SalesforceModel
  @extend RSpine.Model.Ajax

  @custumObject= true;

module.exports = Account