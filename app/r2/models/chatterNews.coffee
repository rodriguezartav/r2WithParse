RSpine = require('rspine')

class ChatterNews extends RSpine.Model
  @configure "ChatterNews", "actor" , "body" ,  "comments" , "likes"  ,"url" , "photoUrl"
  
  @extend RSpine.Model.SalesforceModel
  @extend RSpine.Model.SalesforceAjax
 
module.exports = ChatterNews