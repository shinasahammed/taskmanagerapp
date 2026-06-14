import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

import 'package:taskmanager/services/todo_api_service.dart';

void main() {
  group('TodoApiService', () {
    test(
      'returns list of todos when API call succeeds',
      () async {
        final mockClient = MockClient(
          (request) async {
            return Response(
              '''
              [
                {
                  "userId": 1,
                  "id": 1,
                  "title": "Test Todo",
                  "completed": false
                }
              ]
              ''',
              200,
            );
          },
        );

        final service = TodoApiService(
          client: mockClient,
        );

        final todos =
            await service.getTodos();

        expect(todos.length, 1);
        expect(todos.first.id, 1);
        expect(
          todos.first.title,
          'Test Todo',
        );
        expect(
          todos.first.completed,
          false,
        );
      },
    );

    test(
      'throws exception when API fails',
      () async {
        final mockClient = MockClient(
          (request) async {
            return Response(
              'Server Error',
              500,
            );
          },
        );

        final service = TodoApiService(
          client: mockClient,
        );

        expect(
          service.getTodos(),
          throwsException,
        );
      },
    );
  });
}
