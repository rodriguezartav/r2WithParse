RSpine = require("rspine")     

class HtmlModel extends RSpine.Controller

  constructor: ->
    super
    @html require(@data.template)()

module.exports = HtmlModel