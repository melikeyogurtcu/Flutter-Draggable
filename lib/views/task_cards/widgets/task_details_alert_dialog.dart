import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:to_do_list_app/controllers/task_controller.dart';

class TaskDetailsDialog extends StatelessWidget {
  final Task task;
  final Function() setState;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const TaskDetailsDialog({super.key, 
    required this.task,
    required this.setState,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.edit),
          SizedBox(width: 5),
          Text('Edit Task',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(width: 5),
          Icon(Icons.edit),
        ],
      ),
      content: Expanded(
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: "Task Title"),
            ),
            Expanded(
              child: SizedBox(
                child: TextField(
                  maxLines: 39,
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: "Task Description"),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        updateTaskButton(context),
      ],
    );
  }
  Widget updateTaskButton (BuildContext context)=> TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 241, 234, 181)),
          ),
          child: const Text('Update',
              style: TextStyle(color: Colors.black)),
          onPressed: () {
            TaskController.updateTask(
              task,
              titleController.text,
              descriptionController.text,
            );
            setState();
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
}