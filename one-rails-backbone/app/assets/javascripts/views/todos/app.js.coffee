class OneRailsBackbone.Views.App extends Backbone.View

    # Instead of generating a new element, bind to the existing skeleton of
    # the App already present in the HTML.
    el: $('#todoapp')

    # Our template for the line of statistics at the bottom of the app.
    template: JST["todos/todos"]

    # collection: new OneRailsBackbone.Collections.Todos
    # Delegated events for creating new items, and clearing completed ones.
    events:
      "keypress #new-todo":  "createOnEnter"
      "keyup #new-todo":     "showTooltip"
      "click .todo-clear a": "clearCompleted"

    initialize: ->
      @collection = new OneRailsBackbone.Collections.Todos
      @input    = @$("#new-todo")
      @listenTo(@collection, 'add', @addOne)
      @listenTo(@collection, 'reset', @addAll)
      @listenTo(@collection, 'all', @render)
      # console.log("Views App -- initialize");
      @collection.fetch()

    render: ->
      done = @collection.done().length
      # console.log("View App Render");
      @$('#todo-stats').html(@template(
        total:      @collection.length
        done:       @collection.done().length
        remaining:  @collection.remaining().length
      ))

    addOne: (todo) ->
      view = new OneRailsBackbone.Views.Todo(model: todo)
      console.log("Views App --addOne (el)");
      @$('#todo-list').append view.render().el

    addAll: ->
      @collection.each @addOne
      console.log("Views App --addAll");

    newAttributes: ->
      content: @input.val()
      order:   @collection.nextOrder()
      done:    false
      console.log("Views Todos --newAttributes");

    createOnEnter: (e) ->
      return if e.keyCode != 13
      @collection.create @newAttributes()
      @input.val('')
      # console.log("View App createOnEnter");

    # Clear all done todo items, destroying their models.
    clearCompleted: ->
      _.each(@collection.done(), (todo) -> todo.clear() )
      false

    showTooltip: ->
      tooltip = @$('.ui-tooltip-top')
      val = @input.val()
      tooltip.fadeOut()
      clearTimeout(@tooltipTimeout) if @tooltipTimeout
      return if (val == '' || val == @input.attr('placeholder'))
      show = () -> tooltip.show().fadeIn()
      @tooltipTimeout = _.delay(show, 1000)
      console.log("View App showTooltip")


      # new OneRailsBackbone.Views.App
