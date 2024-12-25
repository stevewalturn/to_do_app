import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/app/app.locator.dart';
import 'package:to_do_app/models/todo_item.dart';
import 'package:to_do_app/services/todo_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:to_do_app/enums/dialog_type.dart';
import 'package:to_do_app/enums/bottom_sheet_type.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _logger = Logger();

  List<TodoItem> get todos => _todoService.todos;

  Future<void> addTodo() async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: DialogType.addTodo,
      );

      if (response?.confirmed == true &&
          response?.data != null &&
          response?.data is Map) {
        final data = response!.data as Map;
        _todoService.addTodo(
          data['title'] as String,
          data['description'] as String,
        );
        notifyListeners();
      }
    } catch (e) {
      _logger.e('Error adding todo: $e');
      setError('Unable to add todo. Please try again.');
    }
  }

  Future<void> showTodoOptions(TodoItem todo) async {
    try {
      final response = await _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.todoOptions,
        data: todo,
      );

      if (response?.confirmed == true) {
        switch (response?.data) {
          case 'delete':
            _todoService.deleteTodo(todo.id);
            break;
          case 'toggle':
            _todoService.toggleTodoCompletion(todo.id);
            break;
          case 'edit':
            await _editTodo(todo);
            break;
          default:
            break;
        }
        notifyListeners();
      }
    } catch (e) {
      _logger.e('Error handling todo options: $e');
      setError('Unable to perform the requested action. Please try again.');
    }
  }

  Future<void> _editTodo(TodoItem todo) async {
    try {
      final response = await _dialogService.showCustomDialog(
        variant: DialogType.addTodo,
        data: todo,
      );

      if (response?.confirmed == true &&
          response?.data != null &&
          response?.data is Map) {
        final data = response!.data as Map;
        _todoService.editTodo(
          todo.id,
          data['title'] as String,
          data['description'] as String,
        );
        notifyListeners();
      }
    } catch (e) {
      _logger.e('Error editing todo: $e');
      setError('Unable to edit todo. Please try again.');
    }
  }
}