class Helper
   
  @randomChars: (len) ->
    chars = '';

    while (chars.length < len) 
      chars += Math.random().toString(36).substring(2);

    return chars.substring(0, len);


module.exports = (grunt) ->

  build = Helper.randomChars(5)

  grunt.initConfig
    
    clean:
      app: ['public/style','public/script']
      test: ['test/unit/*.js','test/functional/*.js','test/integration/*.js']

    copy: 
      main: 
        files: []

    less:
      development:
        files:
          "./public/devBuild/application.css" : "./css/index.less"

    grunt_appbot_compiler: {
      r2: {
        appPaths: ['./app/r2','./app/web_components/menu','./app/web_components/newsFeed'],
        lessVariables: "./css/base/variables.less",
        dependencyPaths: ["jqueryify","rspine","rspine/lib/ajax"],
        destination: "./public/devBuild/r2.js"
      },      
      contentBox:{
        appPaths: ['./app/web_components/appHighlight','./app/web_components/appMenu','./app/web_components/appMetrics','./app/web_components/breadcrum'],
        lessVariables: "./css/base/variables.less",
        destination: "./public/devBuild/launch-components.js"
      }
    },

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
            build: build
            path: ""
            apiServer: ""

      dev: 
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/login.html": ["./views/login.jade"]

        options:
          data:
            build: "devBuild"
            path: ""
            apiServer: "http://localhost:3000"

      test: 
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/login.html": ["./views/login.jade"]

        options:
          data:
            build: "devBuild"
            path: ""
            apiServer: "http://localhost:3001"

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
             { src: './public/devBuild/*.*', dest: "#{build}/", gzip: true ,access: 'public-read' , headers: "Cache-Control": "max-age=30000000" }
             { src: './public/images/*.*', dest: "images/", gzip: true , access: 'public-read', headers: "Cache-Control": "max-age=30000000" }
             { src: './public/*.html', dest: "", gzip: true , access: 'public-read' , headers: "Cache-Control": "max-age=300" }
          ]

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-less');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-express');

  grunt.loadNpmTasks('grunt-appbot-compiler');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jade');
  grunt.loadNpmTasks('grunt-s3');  

  grunt.registerTask('test', ["clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest"]);   

  grunt.registerTask('test_unit', ["clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest:unit"]); 

  grunt.registerTask('test_functional', ["clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest:functional"]); 

  grunt.registerTask('test_integration', ["clean:test",'coffee',"jade:test","grunt_appbot_compiler","mochaTest:integration"]); 

  grunt.registerTask('build', ['coffee' , "test" , "grunt_appbot_compiler" , "jade:production","s3"]);   

  grunt.registerTask('server', ["jade:dev" , 'express','watch']);
  
  grunt.registerTask('default', ['clean','coffee', "copy" , 'mochaTest']);   
