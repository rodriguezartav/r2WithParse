RSpine   = require('rspine')

# Modal receves a Controller
# Options include title, data and isWrapper
# withWrapper means that the whole dialog is rendered by the controller.
 
class ModalFramework extends RSpine.Controller

  elements:
    ".modal" : "modal"
    ".modal-content" : "modalContent"

  constructor: ->
    super
    @el = $("body")
    @prepend require("library/modalFramework/layout")()

    RSpine.bind "modal:show", @show
    RSpine.bind "modal:hide", @hide
    @modal.hide()

    RSpine.trigger "platform:library-loaded-modal"
    

  show: (Controller, options = {data: {}}) =>
    @hide()
    @controller = new Controller(el: @modalContent, data: options.data)
    $('button[data-dismiss="modal"]').on "click", @hide
    @modal.show()
    @modal.addClass "in"
  
  hide: (delay=false) =>
    return false if !@controller
    @controller= null
    $('button[data-dismiss="modal"]').off "click", @hide
    @modalContent.empty()
    @modal.removeClass "in"
    return @modal.hide()
    if delay
      @el.fadeOut(1800,@doHide)
    else
      @doHide()
 
  doHide: =>
    @current?.release?()
    @current = null
    @el.empty()
    @el.hide()

module.exports = new ModalFramework()