import 'package:flutter/material.dart';
import '../screens/task_list_screen.dart';

class FilterBarWidget extends StatelessWidget {
  final TodoFilter selectedFilter;
  final ValueChanged<TodoFilter> onFilterChanged;

  const FilterBarWidget({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildFilterChip('All', TodoFilter.all),
          const SizedBox(width: 8),
          _buildFilterChip('Pending', TodoFilter.pending),
          const SizedBox(width: 8),
          _buildFilterChip('Completed', TodoFilter.completed),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, TodoFilter filter) {
    final isSelected = selectedFilter == filter;
    
    return GestureDetector(
      onTap: () => onFilterChanged(filter),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
