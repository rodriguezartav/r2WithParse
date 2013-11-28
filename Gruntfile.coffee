fs = require('fs');
path = require("path")
walk = require("walk")

class Helper
   
  @randomChars: (len) ->
    chars = '';

    while (chars.length < len) 
      chars += Math.random().toString(36).substring(2);

    return chars.substring(0, len);


  @onlyNew: (target) ->
    return (filepath) ->  
      #filepath is JSON file
      dir = path.dirname(filepath)
      changedRecently = false
      files = fs.readdirSync dir
      for file in files
        srcTime = fs.statSync(dir + "/" + file).mtime.getTime();
        now = new Date()
        changedRecently = true if now.getTime() - srcTime < 200000
      return changedRecently

module.exports = (grunt) ->

  org = grunt.file.readJSON("./config/organization.json")

  apiServer = "http://quiet-atoll-3343.herokuapp.com"

  grunt.initConfig
    
    clean:
      r2: ["public/**/*.js"]
      testUnit: ['./test/unit/*.html']

    copy:
      config: 
        files:
          [ {expand: true, src: ['./config/*.*'], dest: "./public/#{org.id}"} ]

    less:
      development:
        files:
          "./public/r2.css" : "./css/index.less"


    threevot_compiler: {
      apps:{
        parts: "./config/apps.json",
        lessVariables: "./css/base/variables.less",
        organizationId: org.id,
        destination: "./public"
      }
      
      components:{
        parts: "./config/components.json",
        lessVariables: "./css/base/variables.less",
        organizationId: org.id,
        destination: "./public"
      }
    },

    mochaTest: 
      test: 
        options: 
          reporter: 'spec'
        src: ['test/server/**/*.js']

    mocha:       
      test:
        src: ['./test/unit/*.html']
        options:
          log: true
          run: true
          reporter: "Spec"
          mocha:
            globals: ["jQuery*","RSpine","exports"]
            ignoreLeaks: false

    threevot_tester: 
      allTest: 
        options:
          testScripts: ["./node_modules/chai/chai.js", "./node_modules/mocha/mocha.js","./node_modules/sinon/pkg/sinon.js" ]
          testStyles: ["./node_modules/mocha/mocha.css"]
          init: "chai.should();"
          lessVariables: "./css/base/variables.less"
          destination: "./test/unit"
          template: "./test/unit/template.eco"

      newTest: 
        options:
          testScripts: ["./node_modules/chai/chai.js", "./node_modules/mocha/mocha.js","./node_modules/sinon/pkg/sinon.js" ]
          testStyles: ["./node_modules/mocha/mocha.css"]
          init: "chai.should();"
          lessVariables: "./css/base/variables.less"
          destination: "./test/unit"
          template: "./test/unit/template.eco"
        src: ['**/test.json'],
        cwd: './app/',
        expand: true,
        filter: Helper.onlyNew(['copy', 'newTest'])

    watch:
      css:
        files: ["./css/**/*.less"]
        tasks: ["less"]
        livereload: true

      apps:
        files: ["./app/**/*.coffee", "./app/**/*.eco", "./app/**/*.jeco", "./app/**/*.less"]
        tasks: ["clean:r2", "threevot_compiler"]
        livereload: true

      views:
        files: ["./views/*.jade","./views/**/*.jade"]
        tasks: ["jade"]
        livereload: true
        
      r2apps:
        files: ["./public/**/*.json"]
        tasks: ["clean:r2", "threevot_compiler"]
        livereload: true
        
      images:
        files: ["./images/*.*"]
        tasks: ["copy:images"]
        livereload: true

    jade:
      production:
        files:
          "./public/index.html": ["./views/index.jade"]
          
        options: 
          data: 
            path: ""
            apiServer: apiServer
            app_url: "http://r2.3vot.com"

      dev:
        files:
          "./public/index.html": ["./views/index.jade"]
          
        options:
          data:
            path: ""
            apiServer: apiServer
            app_url: "http://localhost:7770"


    express:
      all: 
        options:
          port: '7770',
          hostname: "0.0.0.0",
          bases: ['./public'],
          server: './server',
          livereload: true
    s3:
      options: 
        bucket: "r2.3vot.com",
        access: 'public-read',
        key: 'AKIAIHNBUFKPBA2LINFQ',
        secret: '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'

      r2:
        options:
          bucket: "r2.3vot.com",
          encodePaths: true,
          maxOperations: 20

        upload: 
          [
             { src: './public/*.*', dest: "", gzip: true, access: 'public-read', headers: "Cache-Control": "max-age=1" }
             { src: './public/' + org.id  + '/*.*', dest: org.id , gzip: false, access: 'public-read', headers: "Cache-Control": "max-age=1" }
          ]

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-express');

  grunt.loadNpmTasks('grunt-threevot-compiler');
  grunt.loadNpmTasks('grunt-threevot-tester');

  grunt.loadNpmTasks('grunt-mocha-test');

  grunt.loadNpmTasks('grunt-mocha');
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-s3');  

  grunt.registerTask("default" , ['clean:testUnit', 'threevot_tester:newTest', 'mocha'] )

  grunt.registerTask("auto_test" , ['watch:tests'] )

  grunt.registerTask("test" , ['clean:testUnit', 'threevot_tester:allTest', 'mocha'] )

  grunt.registerTask("server_test" , ['mochaTest'] )

  grunt.registerTask('build', ["threevot_compiler" , "jade:production", "copy" ,"s3"]);   

  grunt.registerTask('server', ["copy:images" , "clean:r2", "threevot_compiler", "less", "jade:dev" ,'express', 'watch']);
