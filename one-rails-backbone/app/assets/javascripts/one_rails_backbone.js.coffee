window.OneRailsBackbone =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    alert 'Hello from Backbone!'

$(document).ready ->
  # OneRailsBackbone.initialize()
  console.log($('#main'))
  new OneRailsBackbone.Routers.Todos
  Backbone.history.start()
