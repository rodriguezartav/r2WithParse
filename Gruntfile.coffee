class Helper
   
  @randomChars: (len) ->
    chars = '';

    while (chars.length < len) 
      chars += Math.random().toString(36).substring(2);

    return chars.substring(0, len);

module.exports = (grunt) ->

  orgId = "00DZ0000000orOaMAI"

  apiServer = "http://quiet-atoll-3343.herokuapp.com"

  grunt.initConfig
    
    clean:
      app: ['public/style','public/script']
      test: ['test/unit/*.js','test/functional/*.js','test/integration/*.js']

    copy: 
      main: 
        files:
           [ {expand: true, src: ['./images/**'], dest: './public'} ]

    less:
      development:
        files:
          "./public/r2.css" : "./css/index.less"


    grunt_r2_compiler: {
      r2: {
        appPaths: ['./app/r2'],
        lessVariables: "./css/base/variables.less",
        dependencyPaths: ["jqueryify","rspine","rspine/lib/salesforceAjax","rspine/lib/salesforceModel","rspine/lib/offlineModel"],
        destination: "./public/r2.js"
      },      

      initApp: {
        appPaths: ['./app/initApp', './app/web_components/menu', './app/web_components/newsFeed','./app/web_components/appMenu'],
        lessVariables: "./css/base/variables.less",
        dependencyPaths: [],
        destination: "./public/#{orgId}/initApp.js"
      },

      launchStage:{
        appPaths: ['./app/web_components/appMetrics','./app/web_components/breadcrum','./app/web_components/liveAppMenu'],
        lessVariables: "./css/base/variables.less",
        destination: "./public/#{orgId}/launch-components.js"
      },

      orbitStage:{
        appPaths: ['./app/libraries/keyboardFramework'],
        destination: "./public/#{orgId}/orbit-components.js"        
      }

      vendedores:{
        appPaths: ["./app/apps/pedidos","./app/apps/logistica","./app/apps/newApp" ]
        lessVariables: "./css/base/variables.less",
        destination: "./public/#{orgId}/apps_vendedores.js"
      }
    },

    r2cli:
      app:
        destination: "./app/apps"
        type: "app"
      
      model:
        destination: "./app/initApp/models"
        type: "model"

    coffee:
      unit:
        expand: true,
        flatten: true,
        cwd: './test/unit_src/',
        src: ['**/*.coffee'],
        dest: './test/unit/',
        ext: '.js'        

      functional:
        expand: true,
        flatten: true,
        cwd: './test/functional_src/',
        src: ['**/*.coffee'],
        dest: './test/functional/',
        ext: '.js'

      integration:
        expand: true,
        flatten: true,
        cwd: './test/integration_src/',
        src: ['**/*.coffee'],
        dest: './test/integration/',
        ext: '.js'

    mochaTest:
      unit:
        options:
          reporter: 'spec'
        src: ['test/unit/*.js']
        
      functional:
        options:
          reporter: 'spec'
        src: ['test/functional/*.js']

      integration:
        options:
          reporter: 'spec'
        src: ['test/integration/*.js']

    watch:
      css:
        files: ["./css/*.less","./css/**/*.less"]
        tasks: ["less"]

      apps:
        files: ["./app/**/*.coffee" ,"./app/**/*.eco","./app/**/*.jeco","./app/**/*.less"]
        tasks: ["grunt_r2_compiler"]

      views:
        files: ["./views/*.jade","./views/**/*.jade"]
        tasks: ["jade"]

    jade:
      production:
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/login.html": ["./views/login.jade"]
        options: 
          data: 
            path: ""
            apiServer: apiServer
            app_url: "http://edge.3vot.com"

      dev:
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/login.html": ["./views/login.jade"]

        options:
          data:
            path: ""
            apiServer: apiServer
            app_url: "http://localhost:7770"

      test: 
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/login.html": ["./views/login.jade"]

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
          livereload: true

    s3:
      options: 
        bucket: "edge.3vot.com",
        access: 'public-read',
        key: 'AKIAIHNBUFKPBA2LINFQ',
        secret: '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'

      test:
        options:
          encodePaths: true,
          maxOperations: 20

        upload: 
          [
             { src: './public/*.*', dest: "", gzip: true, access: 'public-read', headers: "Cache-Control": "max-age=0" }
             { src: './public/images/*.*', dest: "images", gzip: false, access: 'public-read', headers: "Cache-Control": "max-age=500" }
             { src: './public/' + orgId  + '/*.*', dest: orgId , gzip: false, access: 'public-read', headers: "Cache-Control": "max-age=0" }
          ]

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-express');

  grunt.loadNpmTasks('grunt-r2-compiler');
  grunt.loadNpmTasks('grunt-r2-cli');

  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-s3');  

  grunt.registerTask('test', ["copy","clean:test",'coffee',"jade:test","grunt_r2_compiler","mochaTest"]);   

  grunt.registerTask('test_unit', ["copy","clean:test",'coffee',"jade:test","grunt_r2_compiler","mochaTest:unit"]); 

  grunt.registerTask('test_functional', ["copy","clean:test",'coffee',"jade:test","grunt_r2_compiler","mochaTest:functional"]); 

  grunt.registerTask('test_integration', ["copy","clean:test",'coffee',"jade:test","grunt_r2_compiler","mochaTest:integration"]); 

  grunt.registerTask('build', ["copy",'coffee' , "test" , "grunt_r2_compiler" , "jade:production","s3"]);   

  grunt.registerTask('server', ["copy","grunt_r2_compiler","less","jade:dev" , 'express','watch']);

  grunt.registerTask('app', ["r2cli:app"]);

  grunt.registerTask('model', ["r2cli:model"]);
  
  grunt.registerTask('default', ["copy",'clean','coffee' , 'mochaTest']);