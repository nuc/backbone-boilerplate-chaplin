# Break out the application running from the configuration definition to
# assist with testing.
require ["config"], ->

  # Kick off the application.
  require ["application", "routes", "handlebars", "templates", "handlebars-helpers", "moment", "controllers/thing_controller"], (Application, routes) ->

    # Initialize the application on DOM ready event.
    $ ->
      new Application
        controllerSuffix: '_controller', pushState: true, routes: routes

