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
        leading: Icon(
          Icons.person,
          color: Colors.white,
        ),
        actions: [
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
        ],
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
