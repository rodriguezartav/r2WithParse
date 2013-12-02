RSpine = require "rspine"
Contact = require("app/accounts/contact")
 
class ContactsEdit extends RSpine.Controller
  className: "contactsEditContact" 

  events:
    "submit .contact-detail-form" : "save"

  constructor: ->
    super
    @render()

  bind: ->

  unbind: ->

  render: ->
    @html require("app/accounts/layout_edit_contact")(@data)

  save: (e) ->
    e.preventDefault()
    target = $(e.target)
    contact = Contact.exists( target.data("contact") )
    
    if !contact then return @create( Contact.fromForm(target) )

    @update(contact.fromForm(target))

  update: (contact) ->  
    contact.save done: (data) ->
      RSpine.trigger "modal:hide"

  create: (contact)  ->
    console.log contact
    contact.save 
      done: (data) ->
        RSpine.trigger "modal:hide"

      fail: (data) =>
        console.log data

module.exports = ContactsEdit