class OneRailsBackbone.Routers.Todos extends Backbone.Router

  routes:
    '': 'showTodoCollectionView'

  showTodoCollectionView: ->
    new OneRailsBackbone.Views.App
    console.log("Router --1");
