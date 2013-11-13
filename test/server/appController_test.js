var AppController = require("../../server/appController");
var mockReq, mockRes;
var fs = require("fs")
var should = require("should")

describe('AppController', function() {

  return describe('Methods', function() {

    it('Should Create an App', function() {
      mockReq = {
        body: {
          appPath: "./test/server/temp",
          name: "newApp"
        }
      };
      mockRes = {
        status: function(status){},
        send: function(response){
        }
      };
      
      var appController = new AppController();
      appController.create(mockReq, mockRes);
      fs.readFileSync("./test/server/temp/newApp/component.json","utf-8").should.not.equal(null)
    });
 
     it('Should Read the Apps', function(done) {
        var mockReq = {
          query: {
            appPath: "./test/server/temp",
          }
        };
        var mockRes = {
          status: function(status){},
          type: function(status){},
          send: function(response){
            response.length.should.equal(1);
            return done()
          }
        };

        var appController = new AppController();
        appController.read(mockReq, mockRes);
      });
 
 
    it('Should update an App', function() {
      var component = require("./temp/newApp/component.json")
      component.name = "newName";

      mockReq = { body: {} }
      mockReq.body.component = component;
      mockReq.body.appPath = "./test/server/temp/newApp/";
      
      mockRes = {
        status: function(status){},
        send: function(response){
        }
      };
      
      var appController = new AppController();
      appController.update(mockReq, mockRes);
      var file = fs.readFileSync("./test/server/temp/newApp/component.json","utf-8");
      var newComponent = JSON.parse(file);
      newComponent.name.should.equal("newName");
    });
 
    it('Should delete an App', function() {
      mockReq = { 
        query: {
          appPath: "./test/server/temp/newApp"
        } 
      }

      mockRes = {
        status: function(status){},
        send: function(response){
        }
      };
      
      var appController = new AppController();
      appController.delete(mockReq, mockRes);
      try{
        var file = fs.readdirSync("./test/server/temp/newApp","utf-8");
      }
      catch(error){
        error.code.should.equal("ENOENT");
      }
      
    });

  });
});

