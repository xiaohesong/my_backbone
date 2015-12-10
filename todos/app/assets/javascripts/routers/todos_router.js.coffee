class Todo.Routers.Todos extends Backbone.Router

  routes :
    '' :  "showCollectionInApp"

  showCollectionInApp : ->
    new Todo.Collections.Todos
