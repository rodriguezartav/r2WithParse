RSpine = require('rspine')

class Demo extends RSpine.Model
  @configure "Demo", "name"

  @extend RSpine.Model.ParseAjax
  @extend RSpine.Model.ParseAjax.Auto
  @extend RSpine.Model.ParseModel


  getProfile: ->
    profile = @Profile.Name.split(' ').join('_').toLowerCase()
    profile = "platform_system_admin" if profile == "administrador_del_sistema"
    return profile
    

  getLastUpdate: =>
    return new Date(Date.parse("1970-1-1")) if !@LastUpdate
    return @LastUpdate
 
module.exports = Demo