require(["config"], function() {
  return require(["application", "routes", "templates"], function(Application, routes) {
    return $(function() {
      return new Application({
        controllerSuffix: '_controller',
        pushState: true,
        routes: routes
      });
    });
  });
});
