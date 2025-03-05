import 'package:flutter/material.dart';

import 'package:myles_todo/models/task_controller.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _taskController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text('Add Task'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Enter task',
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter description',
              ),
            ),
            TextButton(
                onPressed: () {
                  Task task = Task(
                      title: _taskController.text,
                      isCompleted: false,
                      description: _descriptionController.text);
                  context.read<SaveTask>().addTask(task);
                  context.read<SaveTask>().updateTasks();
                  Navigator.pop(context);
                  _taskController.clear();
                  _descriptionController.clear();
                },
                child: Text('Add'))
          ],
        ));
  }
}
