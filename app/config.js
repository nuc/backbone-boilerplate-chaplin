require.config({
  paths: {
    vendor: "../vendor",
    almond: "../vendor/bower/almond/almond",
    underscore: "../vendor/bower/lodash/dist/lodash.underscore",
    jquery: "../vendor/bower/jquery/jquery",
    backbone: "../vendor/bower/backbone/backbone",
    chaplin: "../vendor/bower/chaplin/chaplin"
  },
  shim: {
    backbone: {
      deps: ["jquery", "underscore"],
      exports: "Backbone"
    },
    chaplin: {
      deps: ["backbone"],
      exports: "Chaplin"
    }
  }
});
