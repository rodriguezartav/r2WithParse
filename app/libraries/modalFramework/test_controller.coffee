RSpine = require("rspine")

class TestController extends RSpine.Controller
  @className: ""

  events:
    "click .btn" : "onBtnClick"

  constructor: -> 
    super
    @html '<div class=""><a class="btn">This is a button</a></div>'

  onBtnClick: ->
    @append '<div class="afterClick">This happend on click</div>'
      
module.exports = TestController