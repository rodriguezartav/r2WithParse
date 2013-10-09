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

    grunt_appbot_compiler: {

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
        appPaths: ['./app/web_components/appHighlight','./app/web_components/appMetrics','./app/web_components/breadcrum','./app/web_components/liveAppMenu'],
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
        tasks: ["grunt_appbot_compiler"]

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

      dev:
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/login.html": ["./views/login.jade"]
          "./public/temp.html": ["./views/temp.jade"]
          "./public/entregas.html": ["./views/entregas.jade"]

        options:
          data:
            path: ""
            apiServer: apiServer

      test: 
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/login.html": ["./views/login.jade"]

        options:
          data:
            path: ""
            apiServer: apiServer

    express:
      all: 
        options:
          port: '7770',
          hostname: "0.0.0.0",
          bases: ['./public'],
          livereload: true

    s3:
      options: 
        bucket: "r2.stage.rodcocr.com",
        access: 'public-read',
        key: 'AKIAI6YXGEM6SDQPO3XQ',
        secret: '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'

      test:
        options:
          encodePaths: true,
          maxOperations: 20

        upload: 
          [
             { src: './public/r2.css', dest: "/", gzip: true, access: 'public-read', headers: "Cache-Control": "max-age=300" }
             { src: './public/r2.js', dest: "/", gzip: true, access: 'public-read', headers: "Cache-Control": "max-age=300" }
             { src: './public/*.html', dest: "/", gzip: true, access: 'public-read', headers: "Cache-Control": "max-age=300" }
             { src: "./public/images/*.*", dest: "images/", gzip: true, access: 'public-read', headers: "Cache-Control": "max-age=300" }
             { src: "./public/#{orgId}/*.js", dest: "#{orgId}/", gzip: true, access: 'public-read', headers: "Cache-Control": "max-age=300" }
          ]

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-express');

  grunt.loadNpmTasks('grunt-appbot-compiler');
  grunt.loadNpmTasks('grunt-r2-cli');

  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-s3');  

  grunt.registerTask('test', ["copy","clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest"]);   

  grunt.registerTask('test_unit', ["copy","clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest:unit"]); 

  grunt.registerTask('test_functional', ["copy","clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest:functional"]); 

  grunt.registerTask('test_integration', ["copy","clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest:integration"]); 

  grunt.registerTask('build', ["copy",'coffee' , "test" , "grunt_appbot_compiler" , "jade:production","s3"]);   

  grunt.registerTask('server', ["copy","grunt_appbot_compiler","less","jade:dev" , 'express','watch']);

  grunt.registerTask('app', ["r2cli:app"]);

  grunt.registerTask('model', ["r2cli:model"]);
  
  grunt.registerTask('default', ["copy",'clean','coffee' , 'mochaTest']);