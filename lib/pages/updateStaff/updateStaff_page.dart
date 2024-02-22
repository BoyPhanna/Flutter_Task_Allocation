// ignore_for_file: prefer_const_constructors, unnecessary_this, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_interpolation_to_compose_strings, no_logic_in_create_state

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_alowcation_app/bloc/skill/skill_bloc.dart';
import 'package:task_alowcation_app/bloc/staff/staff_bloc.dart';
import 'package:task_alowcation_app/models/staff.dart';

class UpdateStaffPage extends StatefulWidget {
  final Staff staff;
  const UpdateStaffPage({required this.staff, super.key});

  @override
  State<UpdateStaffPage> createState() =>
      _UpdateStaffPageState(staff: this.staff);
}

class _UpdateStaffPageState extends State<UpdateStaffPage> {
  final Staff staff;
  _UpdateStaffPageState({required this.staff});
  List<String> gender = ['M', 'F', 'O'];
  int _selectedValue = 1;
  String dropdownValue = "";
  int skid = 1;
  final TextEditingController _stnameControler = TextEditingController();
  final TextEditingController _addressControler = TextEditingController();
  final TextEditingController _phoneControler = TextEditingController();

  bool b = true;
  DateTime _dateTime = DateTime(2000);

  List<String> date = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stnameControler.text = staff.stname;
    _addressControler.text = staff.address;
    _phoneControler.text = staff.phone;
    date = staff.dob.split('-').toList();
    if (date[1].length == 1) {
      date[1] = '0' + date[1];
    }
    if (date[2].length == 1) {
      date[2] = '0' + date[2];
    }
    String date2 = date[0] + '-' + date[1] + '-' + date[2];
    _dateTime = DateTime.parse(date2);
    skid = staff.skid;
    if (staff.gender == 'M') {
      _selectedValue = 1;
    } else if (staff.gender == 'F') {
      _selectedValue = 2;
    } else {
      _selectedValue = 3;
    }
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
        title: Text("កែរទិន្នន័យបុគ្គលិក",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "KhmerOSMoul",
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 2),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 560,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 2, 136).withOpacity(0.8),
                borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              FadeInRight(
                duration: Duration(seconds: 1),
                child: TextField(
                  controller: _stnameControler,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "ឈ្មោះបុគ្គលិក",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FadeInRight(
                duration: Duration(seconds: 1),
                child: TextField(
                  controller: _addressControler,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "លំនៅបច្ចុប្បន្ន",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FadeInRight(
                duration: Duration(seconds: 1),
                child: TextField(
                  controller: _phoneControler,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "លេខទូរស័ព្ទ",
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
                    Text("ថ្ងៃខែឆ្មាំកំណើត",
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
                                          firstDate: DateTime(1956),
                                          lastDate: DateTime(2010),
                                          initialDate: _dateTime)
                                      .then((value) {
                                    setState(() {
                                      _dateTime = value!;
                                    });
                                  });
                                },
                                icon: Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        Text(
                            "${_dateTime.day}-${_dateTime.month}-${_dateTime.year}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ]),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              genderAndSkill(),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_stnameControler.text.isNotEmpty &&
                      _dateTime.toString().isNotEmpty &&
                      _phoneControler.text.isNotEmpty &&
                      _addressControler.text.isNotEmpty) {
                    Staff staffupdate = Staff(
                        stid: staff.stid,
                        stname: _stnameControler.text,
                        gender: gender[_selectedValue - 1],
                        dob: _dateTime.year.toString() +
                            "-" +
                            _dateTime.month.toString() +
                            "-" +
                            _dateTime.day.toString(),
                        skid: skid,
                        phone: _phoneControler.text,
                        address: _addressControler.text);
                    context
                        .read<StaffBloc>()
                        .add(UpdateStaff(staff: staffupdate));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "រក្សាទុក",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "KhmerOS",
                    fontSize: 20,
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
                          255, 13, 3, 80); // Default state color
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Column genderAndSkill() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("ភេទ",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "KhmerOS",
                )),
            Text("ជំនាញ",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "KhmerOS",
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      value: 1,
                      groupValue: _selectedValue,
                      onChanged: (value) =>
                          setState(() => _selectedValue = value as int),
                    ),
                    Text("​ប្រុស", style: TextStyle(color: Colors.white))
                  ],
                ),
                Column(
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (value) =>
                          setState(() => _selectedValue = value as int),
                    ),
                    Text("​ស្រី", style: TextStyle(color: Colors.white))
                  ],
                ),
                Column(
                  children: [
                    Radio(
                      activeColor: Colors.green,
                      value: 3,
                      groupValue: _selectedValue,
                      onChanged: (value) =>
                          setState(() => _selectedValue = value as int),
                    ),
                    Text("​ផ្សេងៗ",
                        style: TextStyle(
                          color: Colors.white,
                        ))
                  ],
                ),
              ],
            ),
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
                    for (int i = 0; i < state.skills.length; i++) {
                      if (state.skills[i].skid == staff.skid) {
                        dropdownValue = state.skills[i].skname;
                      }
                    }
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
                        for (int i = 0; i < state.skills.length; i++) {
                          if (state.skills[i].skname == value) {
                            this.skid = state.skills[i].skid!;
                            dropdownValue = state.skills[i].skname;
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
      ],
    );
  }
}
