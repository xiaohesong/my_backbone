window.OneRailsBackbone =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  # initialize: -> alert 'Hello from Backbone!'

$(document).ready ->
  new OneRailsBackbone.Routers.Todos()
  Backbone.history.start()
