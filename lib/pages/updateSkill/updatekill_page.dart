// ignore_for_file: prefer_const_constructors, sort_child_properties_last, no_logic_in_create_state

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:task_alowcation_app/bloc/skill/skill_bloc.dart';
import 'package:task_alowcation_app/models/skill.dart';

class UpdateSkillPage extends StatefulWidget {
  final Skill skill;
  const UpdateSkillPage(this.skill, {super.key});

  @override
  State<UpdateSkillPage> createState() => _UpdateSkillPageState(skill);
}

class _UpdateSkillPageState extends State<UpdateSkillPage> {
  final TextEditingController _sknameControler = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sknameControler.text = skill.skname;
  }

  Skill skill;
  _UpdateSkillPageState(this.skill);
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
        title: Text("កែជំនាញ",
            style: TextStyle(color: Colors.white, fontSize: 20)),
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
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "ឈ្មោះជំនាញ",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  controller: _sknameControler,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_sknameControler.text.isNotEmpty) {
                    context.read<SkillBloc>().add(UpdateSkill(
                        skill: Skill(
                            skname: _sknameControler.text, skid: skill.skid)));
                    context.read<SkillBloc>().add(FetchSkills());
                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'រក្សាទុករួចរាល់',
                    );
                  }
                },
                child: Text(
                  "រក្សាទុក",
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}
