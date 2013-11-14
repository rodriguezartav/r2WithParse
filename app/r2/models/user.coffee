RSpine = require('rspine')

class User extends RSpine.Model
  @configure "User", "Name" , "SmallPhotoUrl" ,  "FirstName" , "Online"  , "Status" , "LastUpdate", "Profile.Name"

  @extend RSpine.Model.SalesforceAjax
  @extend RSpine.Model.SalesforceModel
  
  @avoidQueryList= ["Online","Status","LastUpdate"]
  
  @standardObject = true

  @filters:
    "" : "IsActive = true"
    "id" : "id = '?' "
    "vendedor" : "Profile = 'Cobrador' or Profile = 'Vendedor'"

  getProfile: ->
    @Profile.Name.split(' ').join('_').toLowerCase()

  getLastUpdate: =>
    return new Date(Date.parse("1970-1-1")) if !@LastUpdate
    return @LastUpdate
 
module.exports = User