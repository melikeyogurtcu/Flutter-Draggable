import 'package:to_do_list_app/models/task.dart';

class TaskController {
  static List<Task> tasks = [];
  static void updateTask(Task task, String newTitle, String newDescription) {
    task.title = newTitle;
    task.description = newDescription;

    

    // TODO: Here you should add the code to update the task in your database or memory.
    // This depends on how you are storing your tasks.
  }
  static void deleteTask(Task task) {
   
    tasks.remove(task);
  }
  
} 
