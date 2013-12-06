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

    # Courtesy of https://github.com/opyh/
    #
    # This method is overridden to allow transforming data on attribute instantiation.
    #
    # If you set a dataMapping-mapped attribute to a plain JS value, this setter can
    # transform it into a complex model object for you, e.g. a Backbone collection.
    #
    # To use this feature, put e.g. this in your model class:
    #
    #   dataMapping:
    #     'foo': (attrs, jsonValue) -> new MyFooModel(jsonValue)
    #
    # This will automatically make your model's foo attribute an instance of MyFooModel
    # when calling `myModelInstance.set('foo', someJson)`.
    #
    # If you want to customize the update of a transformed attribute after its first
    # transform, use the `oldValue` parameter in your transform function, e.g. like
    # this:
    #
    #   dataMapping:
    #     'foo': (attrs, jsonValue, oldValue) ->
    #        oldValue.updateWithNewData(jsonValue) if oldValue?
    #        return oldValue || new MyFooModel(jsonValue)
    #
    # Data mapping functions are bound to the model object on calling so you can use
    # `this` like inside your model's instance methods.
  
    set: (key, value, options) ->
      return if @disposed
  
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
            value = mappingFn.call(@, attrs, value, @get(key))
        super key, value, options


