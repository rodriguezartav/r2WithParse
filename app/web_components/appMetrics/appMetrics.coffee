RSpine = require("rspine")
$ = window.$ if !$

class AppMetrics extends RSpine.Controller
  @className: ""

   
  constructor: ->
    super    
    @html require("components/appMetrics/appMetrics_layout")()

module.exports = AppMetrics