define (require) ->
  "use strict"

  controller = require "controllers/thing_controller"

  describe "ThingController", ->
    it "should exist", ->
      expect(controller).to.exist
