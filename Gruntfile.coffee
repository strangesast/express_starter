module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  grunt.initConfig
    coffee:
      binapp:
        files:
          'bin/www' : 'bin/www.coffee'
          'app.js' : 'app.coffee'
      routes:
        expand: true
        cwd: 'routes/'
        src: '*.coffee'
        dest: 'routes/'
        ext: '.js'
      public:
        expand: true
        cwd: 'public/coffee/'
        src: '*.coffee'
        dest: 'public/js/'
        ext: '.js'
    less:
      dev:
        expand: true
        cwd: 'public/less/'
        src: '*.less'
        dest: 'public/css/'
        ext: '.css'
    watch:
      coffee:
        files: '**/*.coffee'
        tasks: ['coffee:src', 'coffee:assets']
        options:
          livereload: true
      less:
        files: 'public/less/*.less'
        tasks: ['less:dev']
        options:
          livereload: true
    nodemon:
      dev:
        script: 'bin/www'
        options:
          ignore: ['public']
          delay: 800
    concurrent:
      dev:
        tasks: ['watch:coffee', 'watch:less']#, 'nodemon:dev']
        options:
          logConcurrentOutput: true

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  #grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-nodemon'

  grunt.registerTask('default', ['coffee', 'less:dev']);
  grunt.registerTask('w', ['concurrent:dev']);
