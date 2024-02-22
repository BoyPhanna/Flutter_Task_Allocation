import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:task_alowcation_app/bloc/staff/staff_bloc.dart';

import 'package:task_alowcation_app/pages/new_staff/new_staff_page.dart';
import 'package:task_alowcation_app/pages/updateStaff/updateStaff_page.dart';
import 'package:url_launcher/url_launcher.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
          title: const Text(
            "ទំព័របុគ្គលិក",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: "KhmerOSMoul"),
          ),
        ),
        body: BlocBuilder<StaffBloc, StaffState>(
          builder: (context, state) {
            if (state is StaffInitial) {
              context.read<StaffBloc>().add(const FetchStaffs());
            }
            if (state is DisplayStaffs) {
              final dataMap = <String, double>{
                "male": state.men.toDouble(),
                "female": state.women.toDouble(),
                "orther": state.orther.toDouble(),
              };
              final colorList = <Color>[
                const Color.fromARGB(255, 255, 255, 255),
                const Color.fromARGB(255, 236, 96, 241),
                const Color.fromARGB(255, 97, 253, 136),
              ];
              int sum = state.men + state.women + state.orther;
              if (sum == 0) {
                sum = 1;
              }

              return state.staffs.isNotEmpty
                  ? Center(
                      child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        width: width * 0.9,
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 29, 2, 164),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PieChart(
                                dataMap: dataMap,
                                animationDuration:
                                    const Duration(milliseconds: 800),
                                chartLegendSpacing: 32,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 20,
                                legendOptions: const LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.right,
                                  showLegends: false,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: false,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                                // gradientList: ---To add gradient colors---
                                // emptyColorGradient: ---Empty Color gradient---
                              ),
                              FadeInRight(
                                duration: const Duration(seconds: 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ប្រុស ${(state.men / (sum) * 100).toInt()} %",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontFamily: "KhmerOS",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "ស្រី ${(state.women / (sum) * 100).toInt()} %",
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 236, 96, 241),
                                        fontSize: 23,
                                        fontFamily: "KhmerOS",
                                      ),
                                    ),
                                    Text(
                                      "ផ្សេងៗ ${(state.orther / (sum) * 100).toInt()} %",
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 97, 253, 136),
                                        fontSize: 23,
                                        fontFamily: "KhmerOS",
                                      ),
                                    ),
                                    Text(
                                      "សរុប ${((state.men + state.women + state.orther)).toInt()} នាក់",
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 206, 253, 97),
                                        fontSize: 23,
                                        fontFamily: "KhmerOS",
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: width * 0.9,
                        height: 360,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 250, 253, 255)
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ListView.builder(
                            itemCount: state.staffs.length,
                            itemBuilder: (context, index) {
                              return FadeInUp(
                                duration: const Duration(milliseconds: 1000),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 2),
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 8, top: 5),
                                  width: width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: const Color.fromARGB(255, 1, 1, 152),
                                  ),
                                  child: Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.staffs[index].stname,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "KhmerOS",
                                            color: state.staffs[index].gender ==
                                                    "M"
                                                ? Colors.white
                                                : state.staffs[index].gender ==
                                                        "F"
                                                    ? const Color.fromARGB(
                                                        255, 236, 96, 241)
                                                    : const Color.fromARGB(
                                                        255, 97, 253, 136),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              FadeInRight(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    final Uri url = Uri(
                                                        scheme: 'http',
                                                        path:
                                                            "maps.app.goo.gl/gmyhQBD6JBbUWTYr7");
                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      await launchUrl(url);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.location_history,
                                                    color: Color.fromARGB(
                                                        255, 248, 252, 22),
                                                  ),
                                                ),
                                              ),
                                              FadeInRight(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    final Uri url = Uri(
                                                        scheme: 'tel',
                                                        path: state
                                                            .staffs[index]
                                                            .phone);
                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      await launchUrl(url);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                    Icons.call,
                                                    color: Color.fromARGB(
                                                        255, 1, 209, 11),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              UpdateStaffPage(
                                                                  staff: state
                                                                          .staffs[
                                                                      index])));
                                                },
                                                icon: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  context.read<StaffBloc>().add(
                                                      DeleteStaff(
                                                          stid: state
                                                              .staffs[index]
                                                              .stid!));
                                                  context
                                                      .read<StaffBloc>()
                                                      .add(const FetchStaffs());
                                                  setState(() {});
                                                },
                                                icon: const Icon(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.staffs[index].dob,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "KhmerOS",
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            state.staffs[index].address,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "KhmerOS",
                                            ),
                                          ),
                                          Text(
                                            state.skills[index].skname,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "KhmerOS",
                                            ),
                                          )
                                        ]),
                                  ]),
                                ),
                              );
                            }),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewStaffPage()));
                        },
                        // ignore: sort_child_properties_last
                        child: const Text(
                          "ថែមបុគ្គលិកថ្មី",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "KhmerOS",
                              fontSize: 20),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (states) {
                              if (states.contains(MaterialState.pressed)) {
                                return const Color.fromARGB(
                                    255, 6, 127, 234); // Pressed state color
                              }
                              return const Color.fromARGB(
                                  255, 21, 0, 154); // Default state color
                            },
                          ),
                        ),
                      )
                    ]))
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewStaffPage()));
                      },
                      // ignore: sort_child_properties_last
                      child: const Text(
                        "ថែមបុគ្គលិកថ្មី",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(MaterialState.pressed)) {
                              return const Color.fromARGB(
                                  255, 6, 127, 234); // Pressed state color
                            }
                            return const Color.fromARGB(
                                255, 21, 0, 154); // Default state color
                          },
                        ),
                      ),
                    );
            }

            return Container(
              color: Colors.white,
              child: const CircularProgressIndicator(),
            );
          },
        ));
  }
}
