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
      tests: ['public/style','public/script','test/unit/*.js']

    copy: 
      main: 
        files: []

    less:
      development:
        files:
          "./public/devBuild/application.css" : "./css/index.less"



    grunt_appbot_compiler: {
      oneApp: {
        appPaths: ['./app/web'],
        dependencyPaths: ["jqueryify","spine"],
        destination: "./public/devBuild/web.js"
      },      
      contentBox:{
        appPaths: ['./app/components/contentBox','./app/components/newsFeed'],
        lessVariables: "./css/base/variables.css",
        destination: "./public/devBuild/contentBox.js"
      }
    },

    coffee:
      testFiles:
        expand: true,
        flatten: true,
        cwd: './test/unit/src',
        src: ['*.coffee'],
        dest: './test/unit/',
        ext: '.js'        

    mochaTest:
      test:
        options:
          reporter: 'spec'
        src: ['test/unit/*.js']
        
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
          "./public/gettingstarted.html": ["./views/gettingstarted.jade"]
          "./public/frontend.html": ["./views/frontend.jade"]
          "./public/standards.html": ["./views/standards.jade"]
        options: 
          data: 
            build: build
            path: ""

      dev: 
        files:
          "./public/index.html": ["./views/index.jade"]
          "./public/gettingstarted.html": ["./views/gettingstarted.jade"]
          "./public/frontend.html": ["./views/frontend.jade"]
          "./public/standards.html": ["./views/standards.jade"]
          "./public/tasks.html": ["./views/tasks.jade"]
          "./public/api.html": ["./views/api.jade"]

        options:
          data:
            build: "devBuild"
            path: ""

    express:
      all: 
        options:
          port: '7770',
          hostname: "0.0.0.0",
          bases: ['./public'],
          livereload: true


    s3:
      options: 
        bucket: "r2.rodcocr.com",
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

  grunt.registerTask('test', ["clean",'coffee',"grunt_appbot_compiler","mochaTest"]);   

  grunt.registerTask('build', ['coffee' , "test" , "grunt_appbot_compiler" , "jade:production","s3"]);   

  grunt.registerTask('server', ["jade:dev" , 'express','watch']);
  
  grunt.registerTask('default', ['clean','coffee', "copy" , 'mochaTest']);   
