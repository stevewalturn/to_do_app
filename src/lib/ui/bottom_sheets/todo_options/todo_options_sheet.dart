import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:to_do_app/models/todo_item.dart';
import 'package:to_do_app/ui/bottom_sheets/todo_options/todo_options_sheet_model.dart';
import 'package:to_do_app/ui/common/app_colors.dart';

class TodoOptionsSheet extends StackedView<TodoOptionsSheetModel> {
  final Function(SheetResponse) completer;
  final SheetRequest request;

  const TodoOptionsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoOptionsSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            viewModel.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _OptionTile(
            icon: Icons.check_circle_outline,
            title: viewModel.isCompleted
                ? 'Mark as incomplete'
                : 'Mark as complete',
            onTap: () =>
                completer(SheetResponse(confirmed: true, data: 'toggle')),
          ),
          _OptionTile(
            icon: Icons.edit,
            title: 'Edit',
            onTap: () =>
                completer(SheetResponse(confirmed: true, data: 'edit')),
          ),
          _OptionTile(
            icon: Icons.delete,
            title: 'Delete',
            color: Colors.red,
            onTap: () =>
                completer(SheetResponse(confirmed: true, data: 'delete')),
          ),
        ],
      ),
    );
  }

  @override
  TodoOptionsSheetModel viewModelBuilder(BuildContext context) =>
      TodoOptionsSheetModel(todo: request.data as TodoItem);
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _OptionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? kcPrimaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? kcDarkGreyColor,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }
}
