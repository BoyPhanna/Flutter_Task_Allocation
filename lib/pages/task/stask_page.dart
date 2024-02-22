// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, avoid_unnecessary_containers, unused_local_variable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_event.dart';
import 'package:task_alowcation_app/pages/newTask/newTask_page.dart';
import 'package:task_alowcation_app/pages/updateTask/updateTask_page.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    String staffName = "Phanna";
    String deadLine = "2024-12-12";
    String skillName = "Network";
    String projectName = "C++";

    double persin = 60;
    bool workload = true;
    Color color = Colors.red;
    final width = MediaQuery.of(context).size.width * 0.9;
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskInitial) {
          context.read<TaskBloc>().add(FetchTasks());
        }
        if (state is DisplayTasks) {
          return Scaffold(
            backgroundColor: Color.fromARGB(255, 93, 106, 243),
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Color.fromARGB(255, 29, 2, 136),
              title: Text("ទំព័រការងារ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "KhmerOSMoul",
                  )),
            ),
            body: Center(
              child: Column(children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  width: width,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 29, 2, 164),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BarChartWiget(persin: persin, color: color),
                            BarChartWiget(persin: 100.0, color: Colors.green),
                            BarChartWiget(persin: 70.2, color: Colors.yellow),
                          ],
                        ),
                        Column(
                          children: [
                            WorkLoadAndSkillWiget(
                                color: color,
                                persin: persin,
                                skillName: skillName),
                            WorkLoadAndSkillWiget(
                                color: Colors.green,
                                persin: 100,
                                skillName: "Front End"),
                            WorkLoadAndSkillWiget(
                                color: Colors.yellow,
                                persin: 70.2,
                                skillName: "Back End"),
                          ],
                        )
                      ]),
                ),
                Container(
                  margin: EdgeInsets.all(8),
                  width: width,
                  height: 380,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 253, 255)
                        .withOpacity(0.5),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      return FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 2),
                          margin: EdgeInsets.only(left: 8, right: 8, top: 5),
                          width: width,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color.fromARGB(255, 1, 1, 152),
                          ),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  state.tasks[index].taname,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "KhmerOS",
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      FadeInRight(
                                        duration: Duration(milliseconds: 1000),
                                        child: IconButton(
                                            onPressed: () {
                                              print("Finish");
                                            },
                                            icon: Text(
                                              "${state.tasks[index].availability} %",
                                              style: TextStyle(
                                                  color: state.tasks[index]
                                                              .availability >
                                                          99
                                                      ? Color.fromARGB(
                                                          255, 1, 255, 77)
                                                      : state.tasks[index]
                                                                  .availability >
                                                              70
                                                          ? Color.fromARGB(
                                                              255, 169, 240, 39)
                                                          : state.tasks[index]
                                                                      .availability >
                                                                  40
                                                              ? Color.fromARGB(
                                                                  255,
                                                                  236,
                                                                  188,
                                                                  15)
                                                              : Color.fromARGB(
                                                                  255,
                                                                  255,
                                                                  1,
                                                                  1),
                                                  fontSize: 20),
                                            )),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateTaskPage(
                                                          task: state
                                                              .tasks[index])));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context.read<TaskBloc>().add(
                                              DeleteTask(
                                                  taid: state
                                                      .tasks[index].taid!));
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  state.tasks[index].deadline
                                      .toString()
                                      .substring(0, 19),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.staffs[index].stname,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "KhmerOS",
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    state.skills[index].skname,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewTaskPage()));
                  },
                  child: Text(
                    "ថែមការងារថ្មី",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "KhmerOS",
                      fontSize: 16,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Color.fromARGB(
                              255, 6, 127, 234); // Pressed state color
                        }
                        return Color.fromARGB(
                            255, 21, 0, 154); // Default state color
                      },
                    ),
                  ),
                )
              ]),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class WorkLoadAndSkillWiget extends StatelessWidget {
  const WorkLoadAndSkillWiget({
    super.key,
    required this.color,
    required this.persin,
    required this.skillName,
  });

  final Color color;
  final double persin;
  final String skillName;

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: Duration(milliseconds: 1000),
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color),
            ),
            Text(
              "${persin}%",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "${skillName}",
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BarChartWiget extends StatelessWidget {
  const BarChartWiget({
    super.key,
    required this.persin,
    required this.color,
  });

  final double persin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 1000),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 8),
              width: 10,
              height: persin,
              decoration: BoxDecoration(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
