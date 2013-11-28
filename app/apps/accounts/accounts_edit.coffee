RSpine = require "rspine"
Account = require("app/accounts/account")
 
class AccountsEdit extends RSpine.Controller
  className: "accountsEditAccount" 

  events:
    "submit .account-detail-form" : "save"

  constructor: ->
    super
    @render()

  bind: ->

  unbind: ->

  render: ->
    @html require("app/accounts/layout_edit")(@data)

  save: (e) ->
    e.preventDefault()
    target = $(e.target)
    account = Account.exists( target.data("account") )
    
    if !account then return @create( Account.fromForm(target) )

    @update(account.fromForm(target))

  update: (account) ->  
    account.save done: (data) ->
      RSpine.trigger "modal:hide"

  create: (account)  ->
    console.log account
    account.save 
      done: (data) ->
        RSpine.trigger "modal:hide"

      fail: (data) =>
        console.log data

module.exports = AccountsEdit