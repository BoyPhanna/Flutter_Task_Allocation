import 'package:equatable/equatable.dart';
import 'package:task_alowcation_app/models/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();
}

class AddTask extends TaskEvent {
  final String taname;
  final DateTime deadline;
  final int skid;
  const AddTask({
    required this.taname,
    required this.deadline,
    required this.skid,
  });
  @override
  List<Object?> get props => [taname, deadline, skid];
}

class UpdateTask extends TaskEvent {
  final Task task;

  const UpdateTask({required this.task});
  @override
  List<Object?> get props => [task];
}

class FetchTasks extends TaskEvent {
  const FetchTasks();
  @override
  List<Object?> get props => [];
}

class DeleteTask extends TaskEvent {
  final int taid;
  const DeleteTask({required this.taid});
  @override
  List<Object?> get props => [taid];
}

class FetchSpecificTask extends TaskEvent {
  final int taid;
  const FetchSpecificTask({required this.taid});
  @override
  List<Object?> get props => [taid];
}
