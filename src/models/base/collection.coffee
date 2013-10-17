define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'
  Model = require 'models/base/model'

  module.exports = class Collection extends Chaplin.Collection
    # Mixin SyncMachine
    _.extend @prototype, Chaplin.SyncMachine

    # Use the project base model per default, not Chaplin.Model
    model: Model

    initialize: (models, @options = {}) ->
      super
      @on
        'request': @beginSync
        'sync'   : @finishSync
        'error'  : @abortSync
