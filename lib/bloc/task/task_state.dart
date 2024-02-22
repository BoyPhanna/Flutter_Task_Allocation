part of 'task_bloc.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {
  @override
  List<Object> get props => [];
}

class DisplayTasks extends TaskState {
  final List<Task> tasks;
  final List<Staff> staffs;
  final List<Skill> skills;

  const DisplayTasks(
      {required this.tasks, required this.staffs, required this.skills});
  DisplayTasks copyWith(
      {List<Task>? tasks, List<Staff>? staffs, List<Skill>? skills}) {
    return DisplayTasks(
        tasks: tasks ?? this.tasks,
        staffs: staffs ?? this.staffs,
        skills: skills ?? this.skills);
  }

  @override
  List<Object> get props => [tasks, staffs, skills];
}

class DisplaySpecificTask extends TaskState {
  final Task task;
  const DisplaySpecificTask({required this.task});
  @override
  List<Object> get props => [task];
}
