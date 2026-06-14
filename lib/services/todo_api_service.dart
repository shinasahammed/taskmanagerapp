import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taskmanager/models/todos_model.dart';
import '../helpers/api_helper.dart';



class TodoApiService {
  final http.Client client;

  TodoApiService({http.Client? client})
      : client = client ?? http.Client();

  Future<List<Todo>> getTodos() async {
    final response = await client.get(
      Uri.parse(ApiHelper.todosUrl),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data
          .map((e) => Todo.fromJson(e))
          .toList();
    }

    throw Exception('Failed to load tasks.');
  }
}