RSpine = require "rspine"

class DragDropFramework
  
  constructor: ->
    require("library/dragdropFramework/dragdrop")
    RSpine.trigger "platform:library-loaded-dragdrop"

    RSpine.libraries["DragDropFramework"] =  DragDropFramework
  
module.exports = new DragDropFramework()