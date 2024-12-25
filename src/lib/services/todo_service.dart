import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/models/todo_item.dart';

class TodoService with ListenableServiceMixin {
  final _logger = Logger();
  final List<TodoItem> _todos = [];

  List<TodoItem> get todos => List.unmodifiable(_todos);

  TodoItem addTodo(String title, String description) {
    try {
      final newTodo = TodoItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        createdAt: DateTime.now(),
      );
      _todos.add(newTodo);
      _logger.i('Added new todo: ${newTodo.title}');
      notifyListeners();
      return newTodo;
    } catch (e) {
      _logger.e('Error adding todo: $e');
      throw Exception('Unable to add todo. Please try again.');
    }
  }

  TodoItem toggleTodoCompletion(String todoId) {
    try {
      final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
      if (todoIndex == -1) {
        throw Exception('Todo not found');
      }

      final todo = _todos[todoIndex];
      final updatedTodo = todo.copyWith(
        isCompleted: !todo.isCompleted,
        completedAt: !todo.isCompleted ? DateTime.now() : null,
      );
      
      _todos[todoIndex] = updatedTodo;
      _logger.i('Toggled todo completion: ${todo.title}');
      notifyListeners();
      return updatedTodo;
    } catch (e) {
      _logger.e('Error toggling todo completion: $e');
      throw Exception('Unable to update todo status. Please try again.');
    }
  }

  TodoItem deleteTodo(String todoId) {
    try {
      final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
      if (todoIndex == -1) {
        throw Exception('Todo not found');
      }
      final deletedTodo = _todos.removeAt(todoIndex);
      _logger.i('Deleted todo with ID: $todoId');
      notifyListeners();
      return deletedTodo;
    } catch (e) {
      _logger.e('Error deleting todo: $e');
      throw Exception('Unable to delete todo. Please try again.');
    }
  }

  TodoItem editTodo(String todoId, String newTitle, String newDescription) {
    try {
      final todoIndex = _todos.indexWhere((todo) => todo.id == todoId);
      if (todoIndex == -1) {
        throw Exception('Todo not found');
      }

      final todo = _todos[todoIndex];
      final updatedTodo = todo.copyWith(
        title: newTitle,
        description: newDescription,
      );
      _todos[todoIndex] = updatedTodo;
      _logger.i('Edited todo: ${todo.title}');
      notifyListeners();
      return updatedTodo;
    } catch (e) {
      _logger.e('Error editing todo: $e');
      throw Exception('Unable to edit todo. Please try again.');
    }
  }
}