var app = require("../../server/server")
var mockReq, mockRes;
var fs = require("fs")
var should = require("should")

var request = require('supertest')

describe('Express Server', function() {

  return describe('Methods', function() {
   
    it('Should create an App', function(done) {
      var body = { 
        appPath: "./test/server/temp",
        name: "newApp2",
        type: "app"
      };

      request(app)
      .put("/apps")
      .send( body )
      .expect(200)
      .end(function(err, res){
          if (err) throw err;
          fs.readFileSync("./test/server/temp/newApp2/component.json","utf-8").should.not.equal(null)
          done()
        });
    });

   it('Should Read the Apps', function(done) {
     request(app)
     .get("/apps?appPath=./test/server/temp")
     .send( {} )
     .expect(200)
     .end(function(err, res){
         if (err) throw err;
         res.body[0].namespace.should.equal("app")
         done()
       });
   });      
      
    it('Should update an App', function(done) {
      
      var component = require("./temp/newApp2/component.json")
      component.label = "newApp2Test"
      
      var body = { 
        component: component,
        appPath: "./test/server/temp/newApp2/"
      };

      request(app)
      .post("/apps")
      .send( body )
      .expect(200)
      .end(function(err, res){
        if (err) throw err;
        var file = fs.readFileSync("./test/server/temp/newApp2/component.json","utf-8");
        var newComponent = JSON.parse(file);
        newComponent.label.should.equal("newApp2Test");  
        done()
        });
    });
    
    it('Should delete an App', function(done) {

      request(app)
      .del("/apps?appPath=./test/server/temp/newApp2/")
      .send( {} )
      .expect(200)
      .end(function(err, res){
        if (err) throw err;
        try{
          var file = fs.readdirSync("./test/server/temp/newApp2","utf-8");
        }
        catch(error){
          error.code.should.equal("ENOENT");
          done()
        }
      });
    });    

    it('Should Read the Profiles', function(done) {
      request(app)
      .get("/appPermissions?pathToFile=./test/server/temp/apps.json")
      .send( {} )
      .expect(200)
      .end(function(err, res){
          if (err) throw err;
          res.body[0].name.should.equal("profile_desktop")
          done()
        });
    });
 
    it('Should update Profiles', function(done) {
      var component = require("./temp/apps.json")
      component[0].name = "profile_tablet";

      request(app)
      .post("/appPermissions?pathToFile=./test/server/temp/appsTest.json")
      .send( component )
      .expect(200)
      .end(function(err, res){
        if (err) throw err;
        var componentTest = require("./temp/appsTest.json")
        component[0].name.should.equal("profile_tablet");
        done()
      });
    });
  });
});