define (require, exports, module) ->
  'use strict'

  Chaplin = require 'chaplin'

  module.exports = class Model extends Chaplin.Model
    # Mixin Sync Machine
    _.extend @prototype, Chaplin.SyncMachine

    initialize: ->
      super
      @on
        'request': @beginSync
        'sync'   : @finishSync
        'error'  : @abortSync

    # Extends your model with a mixin and calls the 'included' method if it exists
    @include: (obj) ->
      _(@prototype).extend obj
      obj.included.apply(this) if obj.included
      @

    # This method is overridden to support dataMapping for attribute instantiation.
    # If you set a dataMapping-mapped attribute to a plain JSON value, this setter
    # transforms it into a model object for you.
    #
    # To use this feature, put e.g. this in your model class:
    #
    #   dataMapping:
    #     'foo': (attrs, jsonValue) -> new MyFooModel(jsonValue)
    #
    # This will automatically make your model's foo attribute an instance of MyFooModel
    # when calling `myModelInstance.set('foo', someJson)`.
    set: (key, value, options) ->
      return if @disposed

      super key, value, options

      if _.isObject(key) or not key?
        attrs = key
        options = value
      else
        attrs = {}
        attrs[key] = value

      for key of attrs
        value = attrs[key]
        if @dataMapping?[key] and value?
          mappingFn = @dataMapping[key]
          if typeof mappingFn == 'function'
            oldValue = value
            value = mappingFn.call(@, attrs, value)
        super key, value, options

