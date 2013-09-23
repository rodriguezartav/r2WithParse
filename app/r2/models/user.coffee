RSpine = require('rspine')

class User extends RSpine.Model
  @configure "User" , "name" , "profile"
  User.extend(RSpine.Model.Ajax);
    
    
  constructor: ->
    super

module.exports = User