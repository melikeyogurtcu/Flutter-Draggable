import 'package:flutter/material.dart';
import 'package:to_do_list_app/models/task.dart';
import 'package:to_do_list_app/views/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  List<Task> doneTasks = [];

  void addTask() {
    setState(() {
      tasks.add(Task(title: 'New Task', description: 'New Description'));
    });
  }

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.list_alt_rounded),
              SizedBox(width: 8),
              Text(
                'To-Do List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              Icon(Icons.list_alt_rounded),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 241, 234, 181)),
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 175, 233, 238),
              //color: const Color.fromARGB(255, 169, 242, 207),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'To-Do',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return TaskCard(task: tasks[index], onDelete: () {
                          setState(() {
                            tasks.remove(tasks[index]);
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: DragTarget<Task>(
              builder: (context, candidateData, rejectedData) {
                return Container(
                    color: const Color.fromARGB(255, 169, 242, 207),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Done',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: doneTasks.length,
                            itemBuilder: (context, index) {
                              return TaskCard(task: doneTasks[index], onDelete: () {
                                setState(() {
                                  doneTasks.remove(doneTasks[index]);
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ));
              },
              onWillAcceptWithDetails: (data) {
                return !doneTasks.contains(data.data);
              },
              onAcceptWithDetails: (data) {
                setState(() {
                  doneTasks.add(data.data);
                  tasks.remove(data.data);
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 0.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 241, 234, 181),
        onPressed: () {
          setState(() {
            tasks.add(Task(title: 'New Task', description: 'New Description'));
          });
        },
        tooltip: 'Add Task',
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
    );
  }
}
