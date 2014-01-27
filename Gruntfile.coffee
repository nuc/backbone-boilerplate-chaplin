module.exports = (grunt)->
  'use strict'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')


    clean:
      dev:
        src: 'tmp/'
      build:
        src: ['dist/', 'test/reports']


    handlebars:
      compile:
        options:
          amd: true
          namespace: 'app.templates'
          processName: (file)-> file.replace('templates/', '').replace('.hbs', '')
        files:
          'tmp/templates.js': 'templates/*.hbs'


    stylus:
      compile:
        options:
          compress: false
          'include css': true
          urlfunc: 'embedurl'
          linenos: true
          define:
            '$version': '<%= pkg.version %>'
        src: 'styles/application.styl'
        dest: 'tmp/application.css'


    coffee:
      compile:
        expand: true
        cwd: 'app/'
        src: ['*.coffee', '**/*.coffee']
        dest: 'tmp/'
        ext: '.js'


    processhtml:
      compile:
        src: 'index.html'
        dest: 'dist/index.html'


    # Inspirational reading: https://github.com/jrburke/r.js/blob/master/build/example.build.js
    requirejs:
      compile:
        options:
          baseUrl: 'dist/tmp'
          mainConfigFile: 'tmp/config.js'

          include: ["main"]
          findNestedDependencies: true
          name: "almond"

          # Handlebars templates won't load correctly with this enabled.
          wrap: false

          out: 'dist/application.min.js'
          optimize: 'uglify2'

          generateSourceMaps: true
          # Do not preserve any license comments when working with source
          # maps.  These options are incompatible.
          preserveLicenseComments: false
          waitSeconds: 7


    copy:
      assets:
        src: 'assets/**'
        dest: 'tmp/'
      compile:
        files: [
          expand: true
          # This should only exclude the application.css.
          # There shouldn't be any other CSS files within tmp/.
          src: ['tmp/**/*.!(css)']
          dest: 'dist/'
          rename: (dest, src) ->
            # Make assets sibling to index.html as well as app JS+CSS.
            if src.indexOf('tmp/assets') is 0
              dest + src.slice 3
            else
              dest + src
        ,
          src: ['vendor/**']
          dest: 'dist/'
        ]


    cssmin:
      compile:
        src: 'tmp/application.css'
        dest: 'dist/application.min.css'


    compress:
      compile:
        options:
          mode: 'gzip'
        expand: true
        src: ['dist/*.min.*']
        dest: './'


    # Unit testing is provided by Karma.  Change the two commented locations
    # below to either: mocha, jasmine, or qunit.
    karma: {
      options: {
        basePath: process.cwd()
        singleRun: true
        captureTimeout: 7000
        autoWatch: true

        reporters: ['progress', 'coverage']
        browsers: ['PhantomJS']

        # Change this to the framework you want to use.
        frameworks: ['mocha']

        preprocessors: {
          'app/**/*.coffee': ['coverage']
          'test/**/*.spec.coffee': ['coffee']
          'templates/**/*.hbs': ['handlebars']
        }

        handlebarsPreprocessor: {
          templates: 'window.Handlebars.templates'
        }

        coverageReporter: {
          type: 'lcov',
          dir: 'test/coverage'
        }

        files: [
          # You can optionally remove this or swap out for a different expect.
          'vendor/bower/chai/chai.js'
          'vendor/bower/requirejs/require.js'

          'vendor/bower/handlebars/handlebars.runtime.js'
          'templates/**/*.hbs'

          'test/runner.js'

          { pattern: 'app/**/*.*', included: false }
          # Derives test framework from Karma configuration.
          {
            pattern: 'test/<%= karma.options.frameworks[0] %>/**/*.spec.*'
            included: false
          }
          { pattern: 'vendor/**/*.js', included: false }
        ]
      }

      # This creates a server that will automatically run your tests when you
      # save a file and display results in the terminal.
      daemon: {
        options: {
          singleRun: false
        }
      }

      # This is useful for running the tests just once.
      run: {
        options: {
          singleRun: true
        }
      }
    }

    coveralls: {
      options: {
        coverage_dir: 'test/coverage/PhantomJS 1.9.2 (Linux)/'
      }
    }


    concurrent:
      pipe:
        tasks: ['server', 'watch']
        options:
            logConcurrentOutput: true


    server:
      options:
        host: '127.0.0.1'
        port: 8000

      development: {}

      compile:
        options:
          prefix: 'dist'

      test:
        options:
          forever: false
          port: 8001


    watch:
      options:
        spawn: false
        interrupt: true
        dateFormat: (time) ->
          grunt.log.writeln("Compiled in #{time}ms @ #{(new Date).toString()} 💪\n")

      handlebars:
        files: [
          'templates/**/*.hbs'
        ]
        tasks: ['handlebars']

      stylus:
        files: [
          'styles/**/*.styl'
        ]
        tasks: ['stylus']

      coffee:
        files: [
          'app/**/*.coffee'
        ]
        tasks: ['coffee']


  # Grunt contribution tasks.
  grunt.loadNpmTasks('grunt-contrib-clean')

  grunt.loadNpmTasks('grunt-contrib-handlebars')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-coffee')

  grunt.loadNpmTasks('grunt-processhtml')
  # grunt.loadNpmTasks("grunt-bbb-requirejs")
  grunt.loadNpmTasks('grunt-contrib-requirejs')

  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-cssmin')

  grunt.loadNpmTasks('grunt-contrib-compress')


  # Third-party tasks.
  grunt.loadNpmTasks('grunt-karma')
  grunt.loadNpmTasks('grunt-karma-coveralls')


  grunt.loadNpmTasks('grunt-concurrent')
  grunt.loadNpmTasks('grunt-bbb-server')
  grunt.loadNpmTasks('grunt-contrib-watch')

  # Create an aliased test task.
  grunt.registerTask('test', ['karma:run'])


  grunt.registerTask('default', [
    'clean'

    'handlebars'
    'stylus'
    'coffee'

    'copy:assets'
    'concurrent'
  ])

  grunt.registerTask('build', [
    'clean'

    'handlebars'
    'stylus'
    'coffee'

    'processhtml'
    'copy'
    'requirejs'

    'cssmin'
    'compress'
  ])
