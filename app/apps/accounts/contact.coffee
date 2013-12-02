RSpine = require('rspine')

class Contact extends RSpine.Model
  @configure "Contact", "FirstName", "LastName", "AccountId", "Name", "Email","Phone","Title"

  @extend RSpine.Model.SalesforceAjax
  @extend RSpine.Model.SalesforceAjax.Auto
  @extend RSpine.Model.SalesforceModel

  @avoidInsertList: ["Name"]

  constructor: -> 
    super 

module.exports = Contact