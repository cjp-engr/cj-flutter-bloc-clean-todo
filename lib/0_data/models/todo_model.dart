import 'package:equatable/equatable.dart';
import 'package:frontend/1_domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity with EquatableMixin {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['is_completed'],
    );
  }
}
