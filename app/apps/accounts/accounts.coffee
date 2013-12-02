RSpine = require("rspine")
Account = require("app/accounts/account")
Contact = require("app/accounts/contact")
EditAccount = require("app/accounts/accounts_edit")
EditContact = require("app/accounts/accounts_edit_contact")

class Accounts extends RSpine.Controller
  className: "app-canvas accounts"
    
  elements:
    ".account-list" : "accountList"
    ".contact-list" : "contactList"
    ".lbl-contacts-title" : "lblContactsTitle"
    ".account-item" : "allAccountItems"
    ".btn-edit-app" : "accountEditButtons"

  events:
    "click .btn-create-account" : "onCreateAccount"
    "click .btn-create-contact" : "onCreateContact"
    "click .account-item" :  "onShowContacts"
    "click .contact-item" :  "onEditContact"
    "click .btn-edit-app" : "onEditAccount"

  constructor: ->
    super    
    @bind()
    @render()
    Account.query({});
    Contact.query({});
  
  render: ->
    @html require("app/accounts/layout")() 
    
  renderAccounts: =>
    @accountList.html require("app/accounts/layout_item_account")(Account.all()) 

  bind: ->
    Account.bind "refresh update create" , @renderAccounts
    Contact.bind "refresh update create" , @renderContacts

#Accounts
#

  onCreateAccount: ->
    RSpine.trigger "modal:show", EditAccount , data: { isNewApp: true }

  onEditAccount:  (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "account-item"
    account = Account.find target.data "account"
    RSpine.trigger "modal:show", EditAccount , { data: account }

#
# CONTACTS

  onCreateContact: =>
    return false if !@currentAccountId
    RSpine.trigger "modal:show", EditContact , data: { isNewApp: true, AccountId: @currentAccountId }

  onShowContacts: (e) =>
    target = $(e.target)
    target = target.parent() until target.hasClass "account-item"
    @el.find(".btn-edit-app").hide();
    if target.hasClass "active"
      target.removeClass "active"
      @currentAccountId = null
      @renderContacts()
    else
      @el.find(".account-item").removeClass("active")
      target.addClass "active"
      target.find(".btn-edit-app").show()
      accountId = target.data "account"
      @currentAccountId = accountId
      @renderContacts()
  
  renderContacts: (unassigned=true) =>
    if !@currentAccountId
      contacts = Contact.findAllByAttribute "AccountId", null
    else
      contacts = Contact.findAllByAttribute "AccountId", @currentAccountId
      contacts = [{FirstName: "No Contacts where found"}] if contacts.length == 0
    @contactList.html require("app/accounts/layout_item_contact")(contacts)

  onEditContact:  (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "contact-item"
    contact = Contact.find target.data "contact"
    RSpine.trigger "modal:show", EditContact , { data: contact }

#
#
  shutdown: ->
    Account.unbind "refresh update create" , @renderAccounts
    Contact.unbind "refresh update create" , @renderContacts
    
    @release()

module.exports = Accounts