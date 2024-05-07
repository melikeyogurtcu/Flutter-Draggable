import 'package:to_do_list_app/models/task.dart';

class TaskController {
  static List<Task> tasks = [];
  static void updateTask(Task task, String newTitle, String newDescription) {
    task.title = newTitle;
    task.description = newDescription;

  }
  static void deleteTask(Task task) {
   
    tasks.remove(task);
  }
  
} 
