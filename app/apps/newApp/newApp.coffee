RSpine = require("rspine")
Account =require("models/account")


class NewApp extends RSpine.Controller
  className: "app-canvas"
    
  elements:
    ".js-list" : "jsList"
    
  constructor: ->
    super    
    @html require("app/newApp/newApp_layout")() 

    Account.fetch({},query:true)

    Account.bind "refresh" , =>
      @jsList.html require("app/newApp/newApp_item")(Account.all())    

module.exports = NewApp