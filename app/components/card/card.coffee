RSpine = require("rspine")

class Card extends RSpine.Controller
  className: "card-body" 

  constructor: ->
    super    

    @html require("components/card/card_layout")()   

 
  test: ->
    "ok"


module.exports = Card