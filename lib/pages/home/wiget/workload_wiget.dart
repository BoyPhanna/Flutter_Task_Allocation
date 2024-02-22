// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_event.dart';
import 'package:task_alowcation_app/pages/updateTask/updateTask_page.dart';

class WorkloadWiget extends StatelessWidget {
  const WorkloadWiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            context.read<TaskBloc>().add(FetchTasks());
          }
          if (state is DisplayTasks) {
            return FadeInUp(
              duration: Duration(milliseconds: 1000),
              child: ListView.builder(
                itemCount: state.tasks.length > 5 ? 5 : state.tasks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateTaskPage(task: state.tasks[index])));
                    },
                    child: WorloadWiget(
                        projecName: state.tasks[index].taname,
                        deadLine: state.tasks[index].deadline
                            .toString()
                            .substring(0, 10),
                        persin: state.tasks[index].availability),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

class WorloadWiget extends StatelessWidget {
  const WorloadWiget({
    super.key,
    required this.projecName,
    required this.deadLine,
    required this.persin,
  });

  final String projecName;
  final String deadLine;
  final int persin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      height: 90,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        color: Color.fromARGB(255, 33, 2, 158).withOpacity(0.7),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  projecName,
                  style: TextStyle(
                      color: Colors.white, fontSize: 19, fontFamily: "KhmerOS"),
                ),
                Text(deadLine,
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ],
            ),
            Text("${persin} %",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18)),
                  height: 10,
                  width: 300,
                ),
                FadeInLeft(
                  duration: Duration(milliseconds: 1000),
                  child: Container(
                    decoration: BoxDecoration(
                        color: persin < 30
                            ? Color.fromARGB(255, 162, 112, 2)
                            : persin < 60
                                ? Color.fromARGB(255, 152, 172, 2)
                                : Color.fromARGB(255, 3, 114, 66),
                        borderRadius: BorderRadius.circular(18)),
                    height: 10,
                    width: 300 * persin / 100,
                  ),
                ),
              ],
            )
          ]),
    );
  }
}
