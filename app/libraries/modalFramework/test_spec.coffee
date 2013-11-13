jQuery  = require("jqueryify")
require("rspine")
exports = @;

describe 'modalFramework', ->
  
  before ->
    @modalFramework = require("library/modalFramework/modalFramework")

  after -> 

  describe "Constructor", ->
    
    it "should show the layout", ->
      $(".modal").should.not.equal null
      $(".modal").css("display").should.equal "none"
      
    it "should insert a controller", ->
      Controller = require("library/modalFramework/test_controller")
      RSpine.trigger "modal:show", Controller
      $(".modal").css("display").should.not.equal "none"

    it "should bind controller events", ->
      $(".modal-body").click()
      $(".afterClick").should.not.equal null
    
    it "should hide modal", ->
      RSpine.trigger "modal:hide"
      $(".modal-content").html().should.equal ""
      $(".modal").css("display").should.equal "none"
    
    it "should close modal on click", ->
      Controller = require("library/modalFramework/test_controller")
      RSpine.trigger "modal:show", Controller
      $('.close').click()
      $(".modal").css("display").should.equal "none"