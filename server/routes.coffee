ProfileController = require("./profileController")
AppController  = require("./appController")

module.exports = (app) ->
  
  profileController = new ProfileController(app.organization)
  appController = new AppController(app.organization)

  app.get '/appPermissions', profileController.read
  app.post '/appPermissions', profileController.update

  app.get "/apps" , appController.read
  app.post "/apps" , appController.create
  app.put "/apps" , appController.update
  app.del "/apps" , appController.delete