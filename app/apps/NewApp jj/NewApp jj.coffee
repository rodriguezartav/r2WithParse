RSpine = require("rspine")

class NewApp jj extends RSpine.Controller
  className: "app-canvas"
    
  constructor: ->
    super    
    @html require("/NewApp jj/NewApp jj_layout")() 

module.exports = NewApp jj