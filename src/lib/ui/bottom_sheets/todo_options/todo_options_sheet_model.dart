import 'package:stacked/stacked.dart';
import 'package:to_do_app/models/todo_item.dart';

class TodoOptionsSheetModel extends BaseViewModel {
  final TodoItem todo;

  TodoOptionsSheetModel({required this.todo});

  bool get isCompleted => todo.isCompleted;
  String get title => todo.title;
}
