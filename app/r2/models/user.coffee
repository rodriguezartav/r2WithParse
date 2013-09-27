RSpine = require('rspine')

class User extends RSpine.Model
  @configure "User", "Name" , "SmallPhotoUrl" ,  "FirstName" , "Online"  , "Status" , "LastUpdate"
  @extend RSpine.Model.Ajax
  @extend RSpine.Model.SalesforceModel
  
  @avoidQueryList= ["Online","Status","LastUpdate"]
  
  @standardObject = true

  @queryFilter: (options) =>
    filter = ""
    filter = @queryFilterAddCondition(" IsActive = true " , filter)
    filter = @queryFilterAddCondition(" Profile = 'Cobrador' or Profile = 'Vendedor' " , filter) if options.cobrador
    filter

  getLastUpdate: =>
    return new Date(Date.parse("1970-1-1")) if !@LastUpdate
    return @LastUpdate
 
module.exports = User