RSpine = require "rspine"

class TouchFramework

  constructor: ->
    window.Hammer = require("library/touchFramework/hammer");
    require("library/touchFramework/jquery-hammer")
    
    RSpine.trigger "platform:library-loaded-touch"
  
    RSpine.libraries["TouchFramework"] =  TouchFramework
  
  
module.exports = new TouchFramework()