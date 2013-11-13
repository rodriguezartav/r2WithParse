RSpine = require "rspine"

class BootstrapFramework
  
  constructor: ->
    require("library/bootstrapFramework/tooltip")
    require("library/bootstrapFramework/popover")
    
    RSpine.trigger "platform:library-loaded-bootstrap"
  
    RSpine.libraries["BootstrapFramework"] =  BootstrapFramework
  
  
module.exports = new BootstrapFramework()