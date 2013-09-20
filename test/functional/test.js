
// force the test environment to 'test'
process.env.NODE_ENV = 'test';
// get the application server module
var app = require('../../app');
var assert = require('assert');
var Browser = require('zombie');

describe('pages', function() {
  before(function() {
    this.browser = new Browser({ site: 'http://localhost:3000' });
  });

  beforeEach(function(done) {
    this.browser.visit('/p/gettingstarted', done);
  });

  it('should show contact a form', function() {
    assert.ok(this.browser.success);
    assert.equal(this.browser.text('h1'), 'Welcome');
  });

  after(function(done) {
    app.server.close(done)
  });
  
});