import 'package:flutter/material.dart';
import 'package:taskmanager/helpers/validation_helper.dart';

import '../models/todos_model.dart';


class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() =>
      _AddTaskScreenState();
}

class _AddTaskScreenState
    extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController =
      TextEditingController();

  bool completed = false;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void saveTask() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final todo = Todo(
      userId: 1,
      id: DateTime.now()
          .millisecondsSinceEpoch,
      title: _titleController.text.trim(),
      completed: completed,
    );

    Navigator.pop(context, todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Write a new task',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  hintText: 'Task Title',
                  hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                validator: ValidatorHelper.validateTaskTitle,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Mark as completed',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Switch(
                    value: completed,
                    onChanged: (value) {
                      setState(() {
                        completed = value;
                      });
                    },
                    activeTrackColor: Colors.black,
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}