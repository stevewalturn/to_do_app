import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/models/todo_item.dart';

class AddTodoDialogModel extends BaseViewModel {
  final Logger _logger = Logger();
  final TodoItem? existingTodo;

  AddTodoDialogModel({this.existingTodo});

  String get dialogTitle => existingTodo != null ? 'Edit Task' : 'Add New Task';

  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a title';
    }
    if (value.length > 50) {
      return 'Title must be less than 50 characters';
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value != null && value.length > 200) {
      return 'Description must be less than 200 characters';
    }
    return null;
  }
}
