RSpine = require "rspine"

class KeyboardFramework
  
  constructor: ->
    require("library/keyboardFramework/mousetrap")
    RSpine.trigger "platform:library-loaded-keyboard"
  
module.exports = new KeyboardFramework()