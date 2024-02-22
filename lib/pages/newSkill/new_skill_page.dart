import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:task_alowcation_app/bloc/skill/skill_bloc.dart';

class NewSkillPage extends StatefulWidget {
  const NewSkillPage({super.key});

  @override
  State<NewSkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<NewSkillPage> {
  final TextEditingController _sknameControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 93, 106, 243),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 29, 2, 136),
        title: const Text("ជំនាញថ្មី",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 2),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 400,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 29, 2, 136).withOpacity(0.8),
                borderRadius: BorderRadius.circular(18)),
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              FadeInRight(
                duration: const Duration(seconds: 1),
                child: TextField(
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "ឈ្មោះជំនាញ",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  controller: _sknameControler,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_sknameControler.text.isNotEmpty) {
                    context
                        .read<SkillBloc>()
                        .add(AddSkill(skname: _sknameControler.text));
                    context.read<SkillBloc>().add(const FetchSkills());

                    Navigator.pop(context);
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      text: 'បញ្ចូលជំនាញថ្មីជោគជ័យ',
                    );
                  }
                },
                // ignore: sort_child_properties_last
                child: const Text(
                  "រក្សាទុកជំនាញថ្មី",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color.fromARGB(
                            255, 6, 127, 234); // Pressed state color
                      }
                      return const Color.fromARGB(
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
