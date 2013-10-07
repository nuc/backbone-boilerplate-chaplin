define (require, exports, module) ->
  'use strict'

  _ = require('underscore')
  $ = require('jquery')
  Backbone = require('backbone')
  Chaplin = require('chaplin')

  app = module.exports

  app.root = "/"

  @
