import 'package:flutter/material.dart';
import '../models/todos_model.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onTap;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onChanged,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: todo.completed ? Colors.green.shade400 : Colors.orange.shade400,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: todo.completed,
                    onChanged: onChanged,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(
                      color: todo.completed ? Colors.green.shade500 : Colors.orange.shade400,
                      width: 1.5,
                    ),
                    activeColor: Colors.green.shade500,
                  ),
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
                          fontWeight: FontWeight.w500,
                          decoration: todo.completed
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: todo.completed
                              ? Colors.grey.shade500
                              : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        todo.completed ? 'Completed' : 'Pending',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: todo.completed ? Colors.green.shade600 : Colors.orange.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
