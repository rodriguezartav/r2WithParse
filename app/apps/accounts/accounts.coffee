RSpine = require("rspine")
Account = require("app/accounts/account")
EditAccount = require("app/accounts/accounts_edit")
          
                 
class Accounts extends RSpine.Controller
  className: "app-canvas accounts"
    
  elements:
    ".account-list" : "accountList"

  events:
    "click .btn-create-account" : "onCreateAccount"
    "click .account-item" :  "onEditApp"
  
  constructor: ->
    super    
    @bind()
    @render()
    Account.query({});
  
  render: ->
    @html require("app/accounts/layout")() 
    
  renderAccounts: =>
    @accountList.html require("app/accounts/layout_item_account")(Account.all()) 

  bind: ->
    Account.bind "refresh update create" , @renderAccounts

  onCreateAccount: ->
    RSpine.trigger "modal:show", EditAccount , data: { isNewApp: true }


  onEditApp:  (e) ->
    target = $(e.target)
    target = target.parent() until target.hasClass "account-item"
    account = Account.find target.data "account"
    RSpine.trigger "modal:show", EditAccount , { data: account    }

  
  shutdown: ->
    Account.unbind "refresh update create" , @renderAccounts
    @release()

module.exports = Accounts