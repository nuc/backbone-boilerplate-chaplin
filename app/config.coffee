# This is the runtime configuration file.  It complements the Gruntfile.js by
# supplementing shared properties.

# WARNING!
# No weird shit here, or retarded requirejs will fail to compile.
# E.g. no variables (lol)

require.config
  paths:
    # Almond is used to lighten the output filesize.
    almond: '../vendor/bower/almond/almond'

    jquery: '../vendor/bower/jquery/jquery'

    # Opt for Lo-Dash Underscore compatibility build over Underscore.
    underscore: '../vendor/bower/lodash/dist/lodash.underscore'

    # Map remaining vendor dependencies.
    backbone: '../vendor/bower/backbone/backbone'
    chaplin: '../vendor/bower/chaplin/chaplin'
    moment: '../vendor/bower/moment/moment'
    d3: '../vendor/bower/d3/d3'
    #handlebars: '../vendor/bower/handlebars/handlebars'
    handlebars: '../vendor/bower/handlebars/handlebars.runtime'
    'handlebars-helpers': '../vendor/javascripts/handlebars-helpers'
    'underscore.string': '../vendor/bower/underscore.string/lib/underscore.string'

  shim:
    # This is required to ensure Backbone works as expected within the AMD
    # environment.
    backbone:
      # These are the two hard dependencies that will be loaded first.
      deps: ['jquery', 'underscore']
      # This maps the global `Backbone` object to `require('backbone')`.
      exports: 'Backbone'

    chaplin:
      deps: ['backbone']
      exports: 'Chaplin'

    d3:
      exports: 'd3'

    handlebars:
      exports: 'Handlebars'
    'handlebars-helpers':
      deps: ['handlebars']

    templates:
      deps: ['handlebars']
    moment:
      exports: 'moment'
    'underscore.string':
      deps: ['underscore']
      exports: '_s'
