module.exports = (grunt)->
  'use strict'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # Wipe out previous builds and test reporting.
    clean:
      dev:
        src: 'tmp/'
      build:
        src: ['dist/', 'test/reports', 'tmp/']


    # This task uses James Burke's excellent r.js AMD builder to take all
    # modules and concatenate them into a single file.
    requirejs:
      release:
        options:
          mainConfigFile: 'tmp/app/config.js'
          generateSourceMaps: true
          include: ['main']
          insertRequire: ['main']
          out: 'dist/source.min.js'
          optimize: 'uglify2'

          # Since we bootstrap with nested `require` calls this option allows
          # R.js to find them.
          findNestedDependencies: true

          # Include a minimal AMD implementation shim.
          name: 'almond'

          # Setting the base url to the distribution directory allows the
          # Uglify minification process to correctly map paths for Source
          # Maps.
          baseUrl: 'dist/app'

          # Wrap everything in an IIFE.
          wrap: true

          # Do not preserve any license comments when working with source
          # maps.  These options are incompatible.
          preserveLicenseComments: false


    # Minfiy the distribution CSS.
    cssmin:
      release:
        files:
          'dist/styles.min.css': ['dist/styles.css']


    handlebars:
      compile:
        options:
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
        dest: 'tmp/app/'
        ext: '.js'


    server:
      options:
        host: '127.0.0.1'
        port: 8000

      development: {}

      release:
        options:
          prefix: 'dist'

      test:
        options:
          forever: false
          port: 8001



    processhtml:
      release:
        files:
          'dist/index.html': ['index.html']



    # Move vendor and app logic during a build.
    copy:
      # images:
      #   expand: true
      #   cwd: 'assets/images/'
      #   src: '**'
      #   dest: 'dist/assets/images/'
      #   flatten: true
      #   filter: 'isFile'

      release:
        files: [
          { src: ['tmp/app/**'], dest: 'dist/' }
          { src: ['tmp/styles/**'], dest: 'dist/' }
          { src: ['tmp/templates/**'], dest: 'dist/' }
          { src: 'vendor/**', dest: 'dist/' }
        ]



    compress:
      release:
        options:
          archive: 'dist/source.min.js.gz'

        files: ['dist/source.min.js']



    watch:
      sass:
        files: [
          'styles/**/*.sass'
        ]
        tasks: ['sass']

      coffee:
        files: [
          'app/**/*.coffee'
        ]
        tasks: ['coffee']

      handlebars:
        files: [
          'templates/**/*.hbs'
        ]
        tasks: ['handlebars']



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
      target:
        tasks: ['server', 'watch']
        options:
            logConcurrentOutput: true


  # Grunt contribution tasks.
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-compress')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-stylus')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-handlebars')

  # Third-party tasks.
  # grunt.loadNpmTasks('grunt-karma')
  # grunt.loadNpmTasks('grunt-karma-coveralls')
  grunt.loadNpmTasks('grunt-processhtml')

  # Grunt BBB tasks.
  grunt.loadNpmTasks('grunt-bbb-server')
  grunt.loadNpmTasks('grunt-bbb-requirejs')
  grunt.loadNpmTasks('grunt-bbb-styles')

  # Create an aliased test task.
  # grunt.registerTask('test', ['karma:run'])

  grunt.registerTask('dev', ['handlebars', 'stylus', 'coffee', 'concurrent:target'])

  grunt.loadNpmTasks('grunt-concurrent')

  # When running the default Grunt command, just lint the code.
  grunt.registerTask('default', [
    'sass'
    'coffee'
    'clean'
    'processhtml'
    'copy'
    'requirejs'
    'styles'
    'cssmin'
  ])

