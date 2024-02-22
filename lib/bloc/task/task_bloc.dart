import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_alowcation_app/bloc/task/task_event.dart';
import 'package:task_alowcation_app/models/skill.dart';
import 'package:task_alowcation_app/models/staff.dart';
import 'package:task_alowcation_app/models/task.dart';
import 'package:task_alowcation_app/services/database_service.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTask>((event, emit) async {
      List<int> stids =
          await DatabaseServices.instance.findStaff(event.deadline, event.skid);

      if (stids.isNotEmpty) {
        await DatabaseServices.instance.createTask(Task(
            taname: event.taname,
            deadline: event.deadline,
            stid: stids[0],
            availability: 0));
      }

      add(const FetchTasks());
    });

    on<UpdateTask>((event, emit) async {
      await DatabaseServices.instance.updateTask(task: event.task);
      add(const FetchTasks());
    });

    on<FetchTasks>((event, emit) async {
      List<Staff> staffs = [];
      List<Skill> skills = [];
      List<Task> tasks = await DatabaseServices.instance.readAllTasks();

      for (int i = 0; i < tasks.length; i++) {
        if (tasks.isNotEmpty) {
          staffs.add(
              await DatabaseServices.instance.readStaff(stid: tasks[i].stid));
          skills.add(
              await DatabaseServices.instance.readSkill(skid: staffs[i].skid));
        }
      }

      emit(DisplayTasks(staffs: staffs, skills: skills, tasks: tasks));
    });

    on<DeleteTask>((event, emit) async {
      await DatabaseServices.instance.deleteTask(taid: event.taid);

      add(const FetchTasks());
    });
  }
}
