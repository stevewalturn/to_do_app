import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/models/todo_item.dart';

class TodoService {
  final _logger = Logger();
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => List.unmodifiable(_todos);

  Future<void> addTodo(String title, String description) async {
    try {
      final newTodo = TodoItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );
      _todos.add(newTodo);
      _logger.i('Added new todo: ${newTodo.title}');
    } catch (e) {
      _logger.e('Error adding todo: $e');
      throw Exception('Unable to add todo. Please try again.');
    }
  }

  Future<void> toggleTodoCompletion(String todoId) async {
    try {
      final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
      if (todoIndex == -1) {
        throw Exception('Todo not found');
      }

      final todo = _todos[todoIndex];
      _todos[todoIndex] = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      _logger.i('Toggled todo completion: ${todo.title}');
    } catch (e) {
      _logger.e('Error toggling todo completion: $e');
      throw Exception('Unable to update todo status. Please try again.');
    }
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      final removed = _todos.removeWhere((todo) => todo.id == todoId);
      if (!removed) {
        throw Exception('Todo not found');
      }
      _logger.i('Deleted todo with ID: $todoId');
    } catch (e) {
      _logger.e('Error deleting todo: $e');
      throw Exception('Unable to delete todo. Please try again.');
    }
  }

  Future<void> editTodo(
      String todoId, String newTitle, String newDescription) async {
    try {
      final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
      if (todoIndex == -1) {
        throw Exception('Todo not found');
      }

      final todo = _todos[todoIndex];
      _todos[todoIndex] = todo.copyWith(
        title: newTitle,
        description: newDescription,
      );
      _logger.i('Edited todo: ${todo.title}');
    } catch (e) {
      _logger.e('Error editing todo: $e');
      throw Exception('Unable to edit todo. Please try again.');
    }
  }
}
