var ProfileController = require("../../server/profileController");
var AppController = require("../../server/appController");
var mockReq, mockRes;
var fs = require("fs")
var should = require("should")

describe('ProfileController', function() {

  return describe('Methods', function() {

    before(function(done) {
     var mockReq = {
         body: {
           appPath: "./test/server/temp",
           name: "newApp"
         }
       };
       var mockRes = {
         status: function(status){},
         send: function(response){
           return done();
         }
       };

       var appController = new AppController();
       appController.create(mockReq, mockRes);
    });

    it('Should Read the Profiles', function(done) {
      var mockReq = {
        query: {
          pathToFile  : "./test/server/temp/apps.json"
        }
      };
      var mockRes = {
        status: function(status){},
        type: function(status){},
        send: function(response){
          response[0].name.should.equal("profile_desktop")
          return done()
        }
      };
      
      //using path as orgID
      var profileController = new ProfileController();
      profileController.read(mockReq, mockRes);
    });
 
 
    it('Should update the Profiles', function(done) {
      var component = require("./temp/apps.json")
      component[0].name = "profile_mobile";
     
       var mockReq = {
          query:{
            pathToFile: "./test/server/temp/appsTest.json"
          }
        };
        
        mockReq.body =  component;
        
        var mockRes = {
          status: function(status){},
          type: function(status){},
          send: function(response){
            var checkComponent = require("./temp/appsTest.json")
            checkComponent[0].name.should.equal("profile_mobile")
            //fs.unlinkSync("./test/server/temp/appsTest.json")
            return done()
          }
        };

        //using path as orgID
        var profileController = new ProfileController();
        profileController.update(mockReq, mockRes);
     
    });

    after(function(){
      
      var mockReq = { 
        query: {
          appPath: "./test/server/temp/newApp"
        } 
      }

      var mockRes = {
        status: function(status){},
        send: function(response){
        }
      };
      
      var appController = new AppController();
      appController.delete(mockReq, mockRes);
    });

  });
});

