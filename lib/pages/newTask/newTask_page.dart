// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:task_alowcation_app/bloc/skill/skill_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_event.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  DateTime _dateTime = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController _tanameControler = TextEditingController();
  bool b = true;
  String dropdownValue = "";
  int skid = 0;
  @override
  Widget build(BuildContext context) {
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
        title: Text("ថែមការងារថ្មី",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 2),
          width: MediaQuery.of(context).size.width * 0.99,
          height: 400,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 29, 2, 136).withOpacity(0.8),
              borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            FadeInRight(
              duration: Duration(seconds: 1),
              child: TextField(
                controller: _tanameControler,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: "ឈ្មោះគម្រោង",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FadeInLeft(
              duration: Duration(seconds: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("កាលបរិច្ឆេទយក",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
            FadeInRight(
              duration: Duration(seconds: 1),
              child: Container(
                margin: EdgeInsets.only(top: 8),
                padding: EdgeInsets.only(bottom: 1, right: 8),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 1, 27, 48),
                  borderRadius: BorderRadius.circular(18),
                ),
                width: 410,
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        firstDate: DateTime(2015),
                                        lastDate: DateTime(2025),
                                        initialDate: _dateTime)
                                    .then((value) {
                                  setState(() {
                                    _dateTime = value!;
                                    _dateTime = DateTime(
                                        _dateTime.year,
                                        _dateTime.month,
                                        _dateTime.day,
                                        _time.hour,
                                        _time.minute);
                                  });
                                });
                              },
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                            hour: _dateTime.hour,
                                            minute: _dateTime.minute))
                                    .then((value) {
                                  _time = value!;
                                  _dateTime = DateTime(
                                      _dateTime.year,
                                      _dateTime.month,
                                      _dateTime.day,
                                      value.hour,
                                      value.minute);
                                  setState(() {});
                                });
                              },
                              icon: Icon(
                                Icons.timer_sharp,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      Text(
                          "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}  ${_dateTime.hour} : ${_dateTime.minute}",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                    ]),
              ),
            ),
            FadeInRight(
              duration: Duration(seconds: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ជំនាញ",
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16)),
                  BlocBuilder<SkillBloc, SkillState>(
                    builder: (context, state) {
                      if (state is SkillInitial) {
                        context.read<SkillBloc>().add(const FetchSkills());
                      }

                      if (state is DisplaySkills) {
                        List<String> dropdownValues = [];
                        for (int i = 0; i < state.skills.length; i++) {
                          dropdownValues.add(state.skills[i].skname);
                        }
                        if (b) {
                          dropdownValue = dropdownValues.first;
                          skid = state.skills[0].skid!;
                        }

                        return DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                          ),
                          elevation: 16,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 232, 233, 233)),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          dropdownColor: const Color.fromARGB(255, 13, 14, 16),
                          onChanged: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              b = false;
                              dropdownValue = value.toString();
                              for (int i = 0; i < state.skills.length; i++) {
                                if (value.toString() ==
                                    state.skills[i].skname) {
                                  skid = state.skills[i].skid!;

                                  break;
                                }
                              }
                            });
                          },
                          items: dropdownValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        );
                      }

                      return Container(
                        color: Colors.white,
                        child: const CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is DisplayTasks) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<TaskBloc>().add(AddTask(
                            taname: _tanameControler.text,
                            deadline: _dateTime,
                            skid: skid,
                          ));
                      Navigator.pop(context);

                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'ថែមការងារជោគជ័យ',
                      );
                    },
                    child: Text(
                      "ថែមការងារថ្មី",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                          if (states.contains(MaterialState.pressed)) {
                            return Color.fromARGB(
                                255, 6, 127, 234); // Pressed state color
                          }
                          return Color.fromARGB(
                              255, 13, 3, 80); // Default state color
                        },
                      ),
                    ),
                  );
                }
                return Container();
              },
            )
          ]),
        ),
      ),
    );
  }
}
