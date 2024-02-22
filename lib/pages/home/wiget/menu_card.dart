import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:task_alowcation_app/pages/skill/skill_page.dart';
import 'package:task_alowcation_app/pages/staff/staff_page.dart';
import 'package:task_alowcation_app/pages/task/stask_page.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(18),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: const Color.fromARGB(255, 241, 240, 240).withOpacity(0.2)),
      child: SizedBox(
        height: 170,
        child: FadeInRight(
          duration: Duration(milliseconds: 1000),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskPage()));
                  },
                  child: SubMenuWiget(
                      pathimage: "assets/logo/task.jpg", title: "ការងារ")),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StaffPage()));
                },
                child: SubMenuWiget(
                    pathimage: "assets/logo/staff.jpg", title: "បុគ្គលិក"),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SkillPage()));
                  },
                  child: SubMenuWiget(
                      pathimage: "assets/logo/skill.jpg", title: "ជំនាញ")),
            ],
          ),
        ),
      ),
    );
  }
}

class SubMenuWiget extends StatelessWidget {
  const SubMenuWiget({
    super.key,
    required this.pathimage,
    required this.title,
  });

  final String pathimage;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          color: Color.fromARGB(255, 33, 2, 158).withOpacity(0.7),
          borderRadius: BorderRadius.circular(18),
        ),
        width: 150,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image(
                    image: AssetImage(pathimage),
                    fit: BoxFit.fill,
                    width: 130,
                    height: 130,
                  ),
                ),
              ),
              Container(
                width: 170,
                height: 130,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color:
                              Color.fromARGB(255, 9, 2, 108).withOpacity(0.4)),
                      width: 140,
                      height: 50,
                      child: Center(
                          child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
