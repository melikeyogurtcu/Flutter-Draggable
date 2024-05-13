import 'package:flutter/material.dart';
import 'package:to_do_list_app/views/task_cards/widgets/congrats_show_dialog.dart';
import 'package:to_do_list_app/views/task_cards/widgets/custom_icon_button.dart';
import 'package:to_do_list_app/views/task_cards/widgets/task_details_alert_dialog.dart';
import '../../models/task.dart';
import 'package:to_do_list_app/controllers/task_controller.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final Function() onDelete;

  const TaskCard({super.key, required this.task, required this.onDelete});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.task,
      feedback: SizedBox(
        width: 200,
        child: Card(
          child: ListTile(
            title: Text(widget.task.title),
            subtitle: Text(widget.task.description, maxLines: 1),
          ),
        ),
      ),
      childWhenDragging: const SizedBox(),
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Card(
          child: ListTile(
            title: Text(
              widget.task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              widget.task.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(34),
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(Icons.cancel,
                                    color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Task Details',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomIconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return TaskDetailsDialog(
                                            task: widget.task,
                                            setState: () {
                                              setState(() {
                                                _titleController.text =
                                                    widget.task.title;
                                                _descriptionController.text =
                                                    widget.task.description;
                                              });
                                            },
                                            titleController: _titleController,
                                            descriptionController:
                                                _descriptionController);
                                      });
                                },
                                icon: Icons.edit,
                                label: 'Edit Task',
                              ),
                            ),
                            const SizedBox(width: 5),
                            CustomIconButton(
                              onPressed: () {
                                TaskController.deleteTask(widget.task);
                                widget.onDelete();
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                              icon: Icons.delete,
                              label: 'Delete Task',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      onDragCompleted: () => congratsShowDialog(context),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
