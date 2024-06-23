// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;

  const TodoEntity({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
      ];

  TodoEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
