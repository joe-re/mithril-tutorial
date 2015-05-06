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
    m("input", {onchange: m.withAttr("value", todo.vm.description), value: todo.vm.description()}),
    m("button", {onclick: todo.vm.add}, "Add"),
    m("table", [
      todo.vm.list.map((task, index) ->
        m("tr", [
          m("td", [
            m("input[type=checkbox]", {onclick: m.withAttr("checked", task.done), checked: task.done()})
          ]),
          m("td", {style: {textDecoration: task.done() ? "line-through" : "none"}}, task.description()),
        ])
      )
    ])
  ])

# initialize the application
m.mount(document.getElementById('todo'), {controller: todo.controller, view: todo.view})
