# the Todo class has two properties
class Todo
  constructor: (description) ->
    @description = m.prop(description)
    @done = m.prop(false)

todo = {}

# for simplicity, we use this component to namespace the model classes
# the TodoList class is a list of Todo's
todo.TodoList = Array

# define the view-model
todo.vm =
  init: ->
    # a running list of todos
    todo.vm.list = new todo.TodoList()

    # a slot to store the name of a new todo before it is created
    todo.vm.description = m.prop('')

    # adds a todo to the list, and clears the description field for user convenience
    todo.vm.add = (description) ->
      if todo.vm.description()
        todo.vm.list.push(new Todo(todo.vm.description()))
        todo.vm.description('')

# controller
todo.controller = -> todo.vm.init()


# view
todo.view = ->
  m("div", [
    m("input"),
    m("button", "Add"),
    m("table", [
      m("tr", [
        m("td", [
          m("input[type=checkbox]")
        ]),
        m("td", todo.vm.description()),
      ])
    ])
  ])

# initialize the application
m.mount(document.getElementById('todo'), {controller: todo.controller, view: todo.view})
