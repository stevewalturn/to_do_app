import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:to_do_app/ui/common/app_colors.dart';
import 'package:to_do_app/ui/common/ui_helpers.dart';
import 'package:to_do_app/ui/widgets/todo_item_card.dart';
import 'package:to_do_app/ui/views/home/home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Daily Tasks',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
      ),
      body: Column(
        children: [
          if (viewModel.modelError != null)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red[100],
              child: Text(
                viewModel.modelError.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: viewModel.todos.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet.\nTap + to add a new task!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kcMediumGrey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: viewModel.todos.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final todo = viewModel.todos[index];
                      return TodoItemCard(
                        todo: todo,
                        onTap: () => viewModel.showTodoOptions(todo),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kcPrimaryColor,
        onPressed: viewModel.addTodo,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
