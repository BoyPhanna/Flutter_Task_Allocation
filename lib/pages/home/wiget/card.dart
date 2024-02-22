import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:task_alowcation_app/bloc/task/task_bloc.dart';
import 'package:task_alowcation_app/bloc/task/task_event.dart';

class CardWiget extends StatelessWidget {
  const CardWiget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    final gradientList = <List<Color>>[
      [
        Color.fromRGBO(111, 235, 4, 1),
        Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        Color.fromRGBO(175, 63, 62, 1.0),
        Color.fromRGBO(254, 154, 92, 1),
      ]
    ];

    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskInitial) {
          context.read<TaskBloc>().add(FetchTasks());
        }
        if (state is DisplayTasks) {
          int tasksCount = state.tasks.length;
          int tasksAllredy = 0;
          for (int i = 0; i < tasksCount; i++) {
            if (state.tasks[i].availability > 99) {
              tasksAllredy++;
            }
          }
          Map<String, double> dataMap = {
            "ហើយ": tasksAllredy.toDouble(),
            "នៅសល់": (tasksCount - tasksAllredy).toDouble(),
          };

          return Container(
            margin: EdgeInsets.only(top: 10),
            width: width * 0.9,
            height: 170,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 171, 161, 237),
                    Color.fromARGB(255, 159, 234, 249),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
                border: Border.all(color: Color.fromARGB(255, 110, 172, 223))),
            child: FadeInLeft(
              duration: Duration(milliseconds: 1000),
              child: PieChart(
                dataMap: dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width / 3.2,

                gradientList: gradientList,
                emptyColorGradient: [
                  Color(0xff6c5ce7),
                  Colors.blue,
                ],
                initialAngleInDegree: 0,
                chartType: ChartType.ring,
                ringStrokeWidth: 32,
                centerText: "ការងារ",
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                  decimalPlaces: 1,
                ),
                // gradientList: ---To add gradient colors---
                // emptyColorGradient: ---Empty Color gradient---
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
