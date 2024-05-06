import 'package:flutter/material.dart';
import '../models/task.dart';
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
            subtitle: Text(widget.task.description),
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
                              child: TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Row(
                                            children: [
                                              Icon(Icons.edit),
                                              SizedBox(width: 5),
                                              Text('Edit Task',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              SizedBox(width: 5),
                                              Icon(Icons.edit),
                                            ],
                                          ),
                                          content: Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                TextField(
                                                  controller: _titleController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Task Title"),
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    maxLines: 39,
                                                    controller:
                                                        _descriptionController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Task Description"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.yellow.shade200),
                                              ),
                                              child: const Text('Update',
                                                  style: TextStyle(
                                                      color: Colors.black)),
                                              onPressed: () {
                                                TaskController.updateTask(
                                                  widget.task,
                                                  _titleController.text,
                                                  _descriptionController.text,
                                                );
                                                setState(() {});
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.yellow.shade200),
                                ),
                                icon:
                                    const Icon(Icons.edit, color: Colors.black),
                                label: const Text('Edit Task',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  TaskController.deleteTask(widget.task);
                                  widget.onDelete();
                                  setState(() {});
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.yellow.shade200),
                                ),
                                icon: const Icon(Icons.delete,
                                    color: Colors.black),
                                label: const Text('Delete Task',
                                    style: TextStyle(color: Colors.black)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  // return AlertDialog(
                  //   title: const Row(
                  //     children: [
                  //       Icon(Icons.edit),
                  //       SizedBox(width: 5),
                  //       Text('Edit Task',
                  //           style: TextStyle(
                  //               color: Colors.black,
                  //               fontWeight: FontWeight.bold)),
                  //       SizedBox(width: 5),
                  //       Icon(Icons.edit),
                  //     ],
                  //   ),
                  //   content: Expanded(
                  //     child: Column(
                  //       children: <Widget>[
                  //         TextField(
                  //           controller: _titleController,
                  //           decoration:
                  //               const InputDecoration(hintText: "Task Title"),
                  //         ),
                  //         Expanded(
                  //           child: TextField(
                  //             maxLines: 39,
                  //             controller: _descriptionController,
                  //             decoration: const InputDecoration(
                  //                 hintText: "Task Description"),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   actions: <Widget>[
                  //     TextButton(
                  //       style: ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStateProperty.all(Colors.yellow.shade200),
                  //       ),
                  //       child: const Text('Update',
                  //           style: TextStyle(color: Colors.black)),
                  //       onPressed: () {
                  //         TaskController.updateTask(
                  //           widget.task,
                  //           _titleController.text,
                  //           _descriptionController.text,
                  //         );
                  //         setState(() {});
                  //         Navigator.of(context).pop();
                  //       },
                  //     ),
                  //   ],
                  // );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
