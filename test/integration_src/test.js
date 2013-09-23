var request = require('supertest')


describe('pages', function() {
  before(function() {
  });

  describe('GET /', function(){
    it('responds', function(done){
      request()
        .get('/login.html')
        .expect(200, done);
    })
  })
  
  
 
  
  after(function(done) {
    //app.server.close(done)
    done()
  });
  
});