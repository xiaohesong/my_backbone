class OneRailsBackbone.Views.App extends Backbone.View
    # el: $('#todoapp')
    el: '#todoapp'

    template: JST["todos/stats"]

    events:
      "keypress #new-todo":  "createOnEnter"
      "keyup #new-todo":     "showTooltip"
      "click .todo-clear a": "clearCompleted"

    initialize: ->
      @collection = new OneRailsBackbone.Collections.Todos
      # @view_todo = new OneRailsBackbone.Views.Todo collection: @collection
      @input    = @$("#new-todo")
      @listenTo(@collection, 'add', @addOne)
      @listenTo(@collection, 'reset', @addAll)
      @listenTo(@collection, 'all', @render)
      # console.log("Views App -- initialize");
      @collection.fetch()



    # Re-rendering the App just means refreshing the statistics -- the rest
    # of the app doesn't change.
    render: ->
      # console.log(@view_todo)
      done = @collection.done().length
      # console.log("View App Render")
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

    newAttributes: ->
      content: @input.val()
      order:   @collection.nextOrder()
      done:    false

    createOnEnter: (e) ->
      return if e.keyCode != 13
      @collection.create @newAttributes()
      @input.val('')
      # console.log("View App createOnEnter");

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
