RSpine = require('rspine')

class User extends RSpine.Model
  @configure "User", "Name" , "SmallPhotoUrl" ,  "FirstName" , "Online"  , "Status" , "LastUpdate","Perfil__c"
  @extend RSpine.Model.Ajax
  @extend RSpine.Model.SalesforceModel
  
  @avoidQueryList= ["Online","Status","LastUpdate"]
  
  @standardObject = true

  @filters:
    "" : "IsActive = true"
    "id" : "id = '?' "
    "vendedor" : "Profile = 'Cobrador' or Profile = 'Vendedor'"

  getLastUpdate: =>
    return new Date(Date.parse("1970-1-1")) if !@LastUpdate
    return @LastUpdate
 
module.exports = User