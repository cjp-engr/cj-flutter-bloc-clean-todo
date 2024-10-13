import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/0_data/exceptions/exceptions.dart';
import 'package:frontend/0_data/models/todo_model.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';

abstract class TodoRemoteDatasource {
  Future<List<TodoModel>> readTodosFromDatabase();
  Future<TodoModel> addTodoToDatabase(TodoEntity todo);
  Future<TodoModel> updateTodoToDatabase(TodoEntity todo);
  Future<void> deleteTodoToDatabase(String id);
}

class TodoRemoteDatasourceImpl implements TodoRemoteDatasource {
  final FirebaseAuth fbAuth;
  final FirebaseFirestore fbDatabase;

  TodoRemoteDatasourceImpl({
    required this.fbAuth,
    required this.fbDatabase,
  });

  String get _userId => fbAuth.currentUser!.uid;
  CollectionReference<Map<String, dynamic>> _todoCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_userId)
        .collection('todos');
  }

  @override
  Future<TodoModel> addTodoToDatabase(TodoEntity todo) async {
    String todoId = '';
    try {
      await _todoCollection().add({
        'userId': _userId,
        'title': todo.title,
        'description': todo.description,
        'is_completed': false,
      }).then((value) async {
        todoId = value.id;
      });
      return TodoModel(
        id: todoId,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      );
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<TodoModel>> readTodosFromDatabase() async {
    List<TodoModel> todos = [];
    try {
      QuerySnapshot query = await _todoCollection().get();
      for (var todo in query.docs) {
        Map<String, dynamic> data = todo.data() as Map<String, dynamic>;

        todos.add(
          TodoModel(
            id: todo.id,
            title: data['title'],
            description: data['description'],
            isCompleted: data['is_completed'],
          ),
        );
      }
      return todos;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteTodoToDatabase(String id) async {
    try {
      await _todoCollection().doc(id).delete();
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<TodoModel> updateTodoToDatabase(TodoEntity todo) async {
    try {
      await _todoCollection().doc(todo.id).update({
        'userId': _userId,
        'title': todo.title,
        'description': todo.description,
        'is_completed': todo.isCompleted,
      });
      return TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        isCompleted: todo.isCompleted,
      );
    } catch (_) {
      throw ServerException();
    }
  }
}
