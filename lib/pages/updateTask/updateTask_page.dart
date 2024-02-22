// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:task_alowcation_app/bloc/task/task_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_event.dart';
import 'package:task_alowcation_app/models/task.dart';

class UpdateTaskPage extends StatefulWidget {
  final Task task;
  const UpdateTaskPage({required this.task, super.key});

  @override
  // ignore: no_logic_in_create_state
  State<UpdateTaskPage> createState() => _UpdateTaskPageState(task: task);
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {
  final Task task;
  _UpdateTaskPageState({required this.task});
  DateTime _dateTime = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  TextEditingController _tanameControler = TextEditingController();
  TextEditingController _availableControl = TextEditingController();
  bool b = true;
  String dropdownValue = "";
  int skid = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tanameControler.text = task.taname;
    _availableControl.text = task.availability.toString();
    _dateTime = task.deadline;
  }

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
        title: Text("កែរទិន្នន័យការងារ",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "KhmerOSMoul",
              fontSize: 20,
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 2),
            width: MediaQuery.of(context).size.width * 0.9,
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
              FadeInRight(
                duration: Duration(seconds: 1),
                child: TextField(
                  controller: _availableControl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "ធ្វើបាន",
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ]),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<TaskBloc>().add(UpdateTask(
                      task: Task(
                          stid: task.stid,
                          taname: _tanameControler.text,
                          deadline: _dateTime,
                          taid: task.taid,
                          availability: int.parse(_availableControl.text))));
                  Navigator.pop(context);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'កែរការងារជោគជ័យ',
                  );
                },
                child: Text(
                  "រក្សាទុក",
                  style: TextStyle(
                      color: Colors.white, fontFamily: "KhmerOS", fontSize: 20),
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
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
