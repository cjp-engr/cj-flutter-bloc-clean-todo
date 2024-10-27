class TodoRouteName {
  static const login = _Route(name: 'login', path: '/login');
  static const register = _Route(name: 'register', path: '/register');
  static const allTodo = _Route(name: 'all-todo', path: '/all-todo');
  static const activeTodo = _Route(name: 'active-todo', path: '/active-todo');
  static const completedTodo =
      _Route(name: 'completed-todo', path: '/completed-todo');
  static const settings = _Route(name: 'settings', path: '/settings');
  static const todoDetails =
      _Route(name: 'todo-details', path: '/todo-details');
  static const todoForm = _Route(name: 'todo-form', path: '/todo-form');
}

class _Route {
  final String name;
  final String path;

  const _Route({required this.name, required this.path});
}
