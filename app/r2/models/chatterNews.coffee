RSpine = require('rspine')

class ChatterNews extends RSpine.Model
  @configure "ChatterNews", "actor" , "body" ,  "comments" , "likes"  ,"url" , "photoUrl"
  

 
module.exports = ChatterNews