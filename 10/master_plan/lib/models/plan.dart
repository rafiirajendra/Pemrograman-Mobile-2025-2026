import './task.dart';

class Plan {
  final String name;
  final List<Task> tasks;
  
  const Plan({this.name = '', this.tasks = const []});

  int get completedCount => tasks
    .where((task) => task.complete)
    .length;

  String get completenessMessage =>
    '$completedCount out of ${tasks.length} tasks';

  double get progress => tasks.isEmpty ? 0 : completedCount / tasks.length;

  String get progressText {
    final percentage = (progress * 100).toStringAsFixed(0);
    return '$percentage%';
  }
}