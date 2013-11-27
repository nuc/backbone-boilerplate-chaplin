define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'

  # Application-specific utilities
  # ------------------------------

  # Delegate to Chaplin’s utils module.
  utils = Chaplin.utils.beget Chaplin.utils

  _(utils).extend
    capitalize: (string) ->
      return unless string?
      string.charAt(0).toUpperCase() + string.slice(1)

  # Prevent creating new properties and stuff.
  Object.seal? utils

  module.exports = utils
