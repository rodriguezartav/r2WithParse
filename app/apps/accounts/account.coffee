RSpine = require('rspine')

class Account extends RSpine.Model
  @configure "Account", "Name", "Description"

  @extend RSpine.Model.SalesforceAjax
  @extend RSpine.Model.SalesforceAjax.Auto
  @extend RSpine.Model.SalesforceModel
  
  

  constructor: -> 
    super 




module.exports = Account