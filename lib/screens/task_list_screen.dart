import 'package:flutter/material.dart';
import 'package:taskmanager/models/todos_model.dart';


import '../services/local_storage_service.dart';
import '../services/todo_api_service.dart';
import '../widgets/task_item.dart';
import '../widgets/filter_bar.dart';
import 'add_task_screen.dart';
import 'task_details_screen.dart';

enum TodoFilter {
  all,
  completed,
  pending,
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TextEditingController searchController =
      TextEditingController();

  List<Todo> allTodos = [];
  List<Todo> filteredTodos = [];

  bool isLoading = true;
  String? errorMessage;

  TodoFilter selectedFilter = TodoFilter.all;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadTodos() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final apiTodos =
          await TodoApiService().getTodos();

      final localTodos =
          await LocalStorageService.loadTasks();

      allTodos = [
        ...localTodos,
        ...apiTodos,
      ];

      applyFilters();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  void applyFilters() {
    filteredTodos = allTodos.where((todo) {
      final matchesSearch = todo.title
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      bool matchesFilter = true;

      switch (selectedFilter) {
        case TodoFilter.completed:
          matchesFilter = todo.completed;
          break;

        case TodoFilter.pending:
          matchesFilter = !todo.completed;
          break;

        case TodoFilter.all:
          matchesFilter = true;
          break;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  Future<void> addTask(Todo todo) async {
    setState(() {
      allTodos.insert(0, todo);
      applyFilters();
    });

    final localTasks =
        allTodos.where((e) => e.id > 200).toList();

    await LocalStorageService.saveTasks(
      localTasks,
    );
  }

  Future<void> updateLocalStorage() async {
    final localTasks =
        allTodos.where((e) => e.id > 200).toList();

    await LocalStorageService.saveTasks(
      localTasks,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final Todo? newTask = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddTaskScreen(),
                ),
              );

              if (newTask != null) {
                await addTask(newTask);
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage!),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loadTodos,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  applyFilters();
                });
              },
            ),
          ),
        ),

        FilterBarWidget(
          selectedFilter: selectedFilter,
          onFilterChanged: (filter) {
            setState(() {
              selectedFilter = filter;
              applyFilters();
            });
          },
        ),

        const SizedBox(height: 10),

        Expanded(
          child: RefreshIndicator(
            onRefresh: loadTodos,
            child: filteredTodos.isEmpty
                ? CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.task_outlined,
                                size: 80,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No tasks found',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'You are all caught up!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];

                      return TodoItemWidget(
                        todo: todo,
                        onChanged: (value) async {
                          setState(() {
                            todo.completed = value ?? false;
                          });
                          await updateLocalStorage();
                        },
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskDetailsScreen(todo: todo),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}