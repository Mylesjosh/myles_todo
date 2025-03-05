import 'package:flutter/material.dart';

import 'package:myles_todo/models/task_controller.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ToDo List',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        //elevation: 50,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'addtask');
        },
        child: Icon(Icons.add),
      ),
      body: Consumer<SaveTask>(builder: (context, task, child) {
        if (task.tasks.isEmpty) {
          return ListTile(
            title: Text('Want to add a task?, Click the \'+\' button 😊'),
          );
        }

        return ListView.builder(
            itemCount: task.tasks.length,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.tasks[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        decoration: task.tasks[index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    if (task.tasks[index].description.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          task.tasks[index].description,
                          style: TextStyle(
                            color: Colors.white,
                            decoration: task.tasks[index].isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                  ],
                ),
                trailing: Wrap(
                  spacing: 2,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Checkbox(
                      value: task.tasks[index].isCompleted,
                      onChanged: (_) {
                        context.read<SaveTask>().checkTask(index);
                        task.updateTasks();
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        context.read<SaveTask>().removeTask(task.tasks[index]);
                        task.updateTasks();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
