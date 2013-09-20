// force the test environment to 'test'
process.env.NODE_ENV = 'test';
// get the application server module
var app = require('../../app');

var request = require('supertest')


describe('pages', function() {
  before(function() {
  });

  describe('GET /', function(){
    it('responds', function(done){
      request(app)
        .get('/')
        .expect(200, done);
    })
  })
  
  
  describe('GET /gettingstarted', function(){
    it('responds', function(done){
      request(app)
        .get('/p/gettingstarted')
        .expect(200, done);
    })
  })
  
  
  describe('GET /frontend', function(){
    it('responds', function(done){
      request(app)
        .get('/p/frontend')
        .expect(200, done);
    })
  })
  
  after(function(done) {
    //app.server.close(done)
    done()
  });
  
});