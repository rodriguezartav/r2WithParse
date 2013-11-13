RSpine = require("rspine")

class TestController extends RSpine.Controller
  @className: ""

  events:
    "click .modal-body" : "onClick"

  constructor: -> 
    super
    @html require("library/modalFramework/test_controller_layout")()

  onClick: ->
    @append '<div class="afterClick">This happend on click</div>'
      
module.exports = TestController