module.exports = (grunt)->
  'use strict'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')


    # Wipe out previous builds and test reporting.
    clean:
      dev:
        src: 'tmp/'
      build:
        src: ['dist/', 'test/reports']


    handlebars:
      compile:
        options:
          amd: true
          namespace: 'templates'
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
        dest: 'tmp/app/'
        ext: '.js'


    processhtml:
      compile:
        files:
          'dist/index.html': ['index.html']


    # This task uses James Burke's excellent r.js AMD builder to take all
    # modules and concatenate them into a single file.
    requirejs:
      compile:
        options:
          baseUrl: 'tmp/app'
          mainConfigFile: 'tmp/app/config.js'
          moduleDirs: ["tmp/app"]

          out: 'tmp/application.js'
          optimize: ''

          generateSourceMaps: false
          preserveLicenseComments: true


    copy:
      assets:
        src: 'assets/**'
        dest: 'dist/'
      compile:
        src: 'vendor/**'
        dest: 'dist/'


    uglify:
      compile:
        src: 'tmp/application.js'
        dest: 'dist/application.min.js'


    cssmin:
      compile:
        src: 'tmp/application.css'
        dest: 'dist/application.min.css'


    compress:
      gzip:
        options:
          mode: 'gzip'
        expand: true
        src: ['dist/*.min.*']
        dest: './'


    # Unit testing is provided by Karma.  Change the two commented locations
    # below to either: mocha, jasmine, or qunit.
    # karma: {
    #   options: {
    #     basePath: process.cwd(),
    #     singleRun: true,
    #     captureTimeout: 7000,
    #     autoWatch: true,

    #     reporters: ['progress', 'coverage'],
    #     browsers: ['PhantomJS'],

    #     # Change this to the framework you want to use.
    #     frameworks: ['mocha'],

    #     plugins: [
    #       'karma-jasmine',
    #       'karma-mocha',
    #       'karma-qunit',
    #       'karma-phantomjs-launcher',
    #       'karma-coverage'
    #     ],

    #     preprocessors: {
    #       'app/**/*.js': 'coverage'
    #     },

    #     coverageReporter: {
    #       type: 'lcov',
    #       dir: 'test/coverage'
    #     },

    #     files: [
    #       # You can optionally remove this or swap out for a different expect.
    #       'vendor/bower/chai/chai.js',
    #       'vendor/bower/requirejs/require.js',
    #       'test/runner.js',

    #       { pattern: 'app/**/*.*', included: false },
    #       # Derives test framework from Karma configuration.
    #       {
    #         pattern: 'test/<%= karma.options.frameworks[0] %>/**/*.spec.js',
    #         included: false
    #       },
    #       { pattern: 'vendor/**/*.js', included: false }
    #     ]
    #   },

    #   # This creates a server that will automatically run your tests when you
    #   # save a file and display results in the terminal.
    #   daemon: {
    #     options: {
    #       singleRun: false
    #     }
    #   },

    #   # This is useful for running the tests just once.
    #   run: {
    #     options: {
    #       singleRun: true
    #     }
    #   }
    # },

    # coveralls: {
    #   options: {
    #     coverage_dir: 'test/coverage/PhantomJS 1.9.2 (Linux)/'
    #   }
    # },

    concurrent:
      pipe:
        tasks: ['server', 'watch']
        options:
            logConcurrentOutput: true

    server:
      options:
        host: '127.0.0.1'
        port: 8000

      compile:
        options:
          prefix: 'dist'

      test:
        options:
          forever: false
          port: 8001


    watch:
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
  grunt.loadNpmTasks('grunt-bbb-requirejs')

  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-cssmin')

  grunt.loadNpmTasks('grunt-contrib-compress')

  # Third-party tasks.
  # grunt.loadNpmTasks('grunt-karma')
  # grunt.loadNpmTasks('grunt-karma-coveralls')

  # Grunt BBB tasks.
  grunt.loadNpmTasks('grunt-concurrent')
  grunt.loadNpmTasks('grunt-bbb-server')
  grunt.loadNpmTasks('grunt-contrib-watch')

  # Create an aliased test task.
  # grunt.registerTask('test', ['karma:run'])

  grunt.registerTask('dev', [
    'clean:dev'

    'handlebars'
    'stylus'
    'coffee'

    'concurrent'
  ])

  grunt.registerTask('default', [
    'clean'

    'handlebars'
    'stylus'
    'coffee'

    'processhtml'
    'requirejs'

    'copy'
    'uglify'
    'cssmin'

    'compress'
  ])

