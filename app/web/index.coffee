Spine = require("spine")
HeaderLink = require("headerLink")
require("lib/setup")

class App extends Spine.Controller


  elements:
    ".after_send" : "after_send"
    ".email_input" : "email_input"
    ".sendEmail" : 'sendEmail'

  events:
    "click .sendEmail" : "onSendEmailClick"

  constructor: ->
    super 
    @after_send.hide();
    
    LazyLoad.js "#{window.src.path}/#{window.src.build}/contentBox.js", ->
      require("lib/setup")
      ContentBox = require("components/contentBox/contentBox")
      new ContentBox( el: $("aside") , tagSelectors: "h2,h3" , sourceSelector: "article")
      #new HeaderLink window.location.pathname, $(".header a")
  
  onSendEmailClick: =>
    @after_send.show();
    @sendEmail.hide()
    $.post("http://vot3-server.herokuapp.com/email" , user_email: @email_input.val() );
    @email_input.val ""  
  
module.exports = App    