import 'package:to_do_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:to_do_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:to_do_app/ui/dialogs/add_todo/add_todo_dialog.dart';
import 'package:to_do_app/ui/bottom_sheets/todo_options/todo_options_sheet.dart';
import 'package:to_do_app/features/home/home_view.dart';
import 'package:to_do_app/features/startup/startup_view.dart';
import 'package:to_do_app/services/todo_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: TodoService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: TodoOptionsSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: AddTodoDialog),
  ],
)
class App {}
