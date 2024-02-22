// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, avoid_unnecessary_containers

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:task_alowcation_app/bloc/skill/skill_bloc.dart';
import 'package:task_alowcation_app/pages/newSkill/new_skill_page.dart';
import 'package:task_alowcation_app/pages/updateSkill/updatekill_page.dart';

class SkillPage extends StatefulWidget {
  const SkillPage({super.key});

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
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
        title: Text("ទំព័រជំនាញ",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: "KhmerOSMoul")),
      ),
      body: BlocBuilder<SkillBloc, SkillState>(
        builder: (context, state) {
          if (state is SkillInitial) {
            context.read<SkillBloc>().add(const FetchSkills());
          }
          if (state is DisplaySkills) {
            return SizedBox(
              width: 400,
              height: MediaQuery.of(context).size.height,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 260,
                      height: 50,
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewSkillPage()));
                        },
                        child: Text("ជំនាញថ្មី")),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                state.skills.isNotEmpty
                    ? Container(
                        child: Container(
                          child: Container(
                            margin: EdgeInsets.only(left: 8, right: 8),
                            height: 580,
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Container(
                              child: ListView.builder(
                                  itemCount: state.skills.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return FadeInUp(
                                      duration: Duration(seconds: 1),
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        margin: EdgeInsets.all(8),
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 1, 54, 98),
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${state.skills[index].skname}",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UpdateSkillPage(
                                                                      state.skills[
                                                                          index])));
                                                    },
                                                    icon: Icon(Icons.edit,
                                                        color: Colors.white),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {
                                                        QuickAlert.show(
                                                          context: context,
                                                          type: QuickAlertType
                                                              .success,
                                                          text:
                                                              'លុប ${state.skills[index].skname} ជោគជ័យ',
                                                        );

                                                        context
                                                            .read<SkillBloc>()
                                                            .add(DeleteSkill(
                                                                skid: state
                                                                    .skills[
                                                                        index]
                                                                    .skid!));
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      )),
                                                ],
                                              )
                                            ]),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Text("Not Skill"),
                      ),
              ]),
            );
          }

          return Container(
            color: Colors.white,
            child: const CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
