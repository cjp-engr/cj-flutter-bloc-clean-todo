// class TodoRouteName {
//   static const String login = 'login';
//   static const String register = 'register';
//   static const String allTodo = 'all-todo';
//   static const String activeTodo = 'active-todo';
//   static const String completedTodo = 'completed-todo';
//   static const String settings = 'settings';
//   static const String todoForm = 'todo-form';
// }

class TodoRouteName {
  static const login = _Route(name: 'login', path: '/login');
  static const register = _Route(name: 'register', path: '/register');
  static const allTodo = _Route(name: 'all-todo', path: '/all-todo');
  static const activeTodo = _Route(name: 'active-todo', path: '/active-todo');
  static const completedTodo =
      _Route(name: 'completed-todo', path: '/completed-todo');
  static const settings = _Route(name: 'settings', path: '/settings');
  static const todoForm = _Route(name: 'todo-form', path: '/todo-form');
}

class _Route {
  final String name;
  final String path;

  const _Route({required this.name, required this.path});
}
