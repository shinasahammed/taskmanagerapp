import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/models/todos_model.dart';



class LocalStorageService {
  static const String key = 'local_tasks';

  static Future<void> saveTasks(
    List<Todo> tasks,
  ) async {
    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      key,
      Todo.encode(tasks),
    );
  }

  static Future<List<Todo>> loadTasks() async {
    final prefs =
        await SharedPreferences.getInstance();

    final data = prefs.getString(key);

    if (data == null) {
      return [];
    }

    return Todo.decode(data);
  }
}