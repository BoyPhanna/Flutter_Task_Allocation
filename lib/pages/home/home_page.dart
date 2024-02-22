// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:task_alowcation_app/pages/home/wiget/card.dart';
import 'package:task_alowcation_app/pages/home/wiget/menu_card.dart';
import 'package:task_alowcation_app/pages/home/wiget/workload_wiget.dart';
import 'package:task_alowcation_app/pages/newTask/newTask_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final higth = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        child: ListView(children: [
          FadeInLeft(
            duration: Duration(seconds: 1),
            child: Image(
              image: AssetImage("assets/logo/RUPP_logo.png"),
              width: 100,
              height: 100,
            ),
          ),
          ListTile(
            title: Text(
              "អំពីកម្មវិធី",
              style: TextStyle(fontFamily: "KhmerOSMoul"),
            ),
          ),
          FadeInUp(
            duration: Duration(seconds: 1),
            child: ListTile(
              title: Text(
                "     កម្មវិធីនេះបង្កើតឡើងដើម្បីជួយ\nសម្រួលដែលប្រធានក្រុម ឬអ្នកចាត់ចែងការងារឲ្យកូនក្រុម ងាយស្រួលក្នុងការដាក់ផែនការការងារនិងគ្រប់គ្រងបុគ្គលិកក្នុងផ្នែកនីមួយៗ។ ដោយកម្មវីធីនិងចាត់ចែងការងារឲ្យបុគ្គលិកតាមពេលវេលាកំណត់និង លទ្ធភាពរបស់បុគ្គលិកក្នុងផ្នែកនីមួយដែលអាចធ្វើការងារនោះបាន។",
                style: TextStyle(fontFamily: "KhmerOS", fontSize: 16),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "អំពីខ្ញុំ",
              style: TextStyle(fontFamily: "KhmerOSMoul"),
            ),
          ),
          FadeInRightBig(
            duration: Duration(seconds: 1),
            child: ListTile(
              title: Text(
                "     ខ្ញុំឈ្មោះ គីម ផាន់ណា ជានិសិត្យដែលកំពុងសិក្សានៅ សកលវិទ្យាល័យភូមិន្ទភ្នំពេញ ផ្នែកព័ត៌មានវិទ្យា។ នេះជាកិច្ចការមុខវិទ្យាភាសា Java បញ្ចប់ឆមាសទី១​ ដែលខ្ញុំយកមកឆ្នៃ ឬ Apply ក្នុង Flutter ។",
                style: TextStyle(fontFamily: "KhmerOS", fontSize: 16),
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 29, 2, 136),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewTaskPage()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 1, 96),
        title: Text("ទំព័រដើម",
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: "KhmerOSMoul")),
        leading: Builder(
          builder: (context) => // Ensure Scaffold is in context
              IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer()),
        ),
      ),
      body: Container(
        width: width,
        height: higth,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 102, 81, 240),
            Color.fromARGB(255, 142, 4, 130),
            Color.fromARGB(255, 36, 7, 227),
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              FadeInUp(
                  duration: Duration(milliseconds: 1000),
                  child: CardWiget(width: width)),
              SizedBox(
                height: 10,
              ),
              MenuCard(),
              WorkloadWiget()
            ],
          ),
        )),
      ),
    );
  }
}
