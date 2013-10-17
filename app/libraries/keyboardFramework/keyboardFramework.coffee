RSpine = require "rspine"

class KeyboardFramework
  
  constructor: ->
    require("library/keyboardFramework/mousetrap")
    RSpine.trigger "platform:library-loaded-keyboard"
  
    RSpine.libraries["KeyboardFramework"] =  KeyboardFramework
  
  
module.exports = new KeyboardFramework()