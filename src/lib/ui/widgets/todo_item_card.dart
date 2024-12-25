import 'package:flutter/material.dart';
import 'package:to_do_app/models/todo_item.dart';
import 'package:to_do_app/ui/common/app_colors.dart';

class TodoItemCard extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onTap;

  const TodoItemCard({
    Key? key,
    required this.todo,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                todo.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: todo.isCompleted ? kcPrimaryColor : kcMediumGrey,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color:
                            todo.isCompleted ? kcMediumGrey : kcDarkGreyColor,
                      ),
                    ),
                    if (todo.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        todo.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: todo.isCompleted
                              ? kcMediumGrey
                              : kcDarkGreyColor.withOpacity(0.7),
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.more_vert,
                color: kcMediumGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
