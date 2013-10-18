# This is the runtime configuration file.  It complements the Gruntfile.js by
# supplementing shared properties.

# WARNING!
# No weird shit here, or retarded requirejs will fail to compile.
# E.g. no variables (lol)

require.config
  paths:
    # Almond is used to lighten the output filesize.
    almond: '../../vendor/bower/almond/almond'

    # Opt for Lo-Dash Underscore compatibility build over Underscore.
    underscore: '../../vendor/bower/lodash/dist/lodash.underscore'

    # Map remaining vendor dependencies.
    jquery: '../../vendor/bower/jquery/jquery'
    backbone: '../../vendor/bower/backbone/backbone'
    chaplin: '../../vendor/bower/chaplin/chaplin'
    handlebars: '../../vendor/bower/handlebars/handlebars'

    templates: '../templates'

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

    handlebars:
      exports: 'Handlebars'

    templates:
      deps: ['handlebars']
