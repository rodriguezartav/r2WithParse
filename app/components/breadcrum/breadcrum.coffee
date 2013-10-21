RSpine = require("rspine")


class Breadcrum extends RSpine.Controller
  @className: ""

   
  constructor: ->
    super    

    @html '<p><a class="the-link" href="https://github.com/tmpvar/jsdom">jsdoms Homepage</a></p>'
  
module.exports = Breadcrum