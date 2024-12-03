import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prototype/src/DAOs/VehicleReadings.dart';
import 'package:intl/intl.dart';


class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  LineChartWidgetState createState() => LineChartWidgetState();
}

class LineChartWidgetState extends State<LineChartWidget> {
  final List<FlSpot> _dataPoints = [];
  final List<DateTime> _xLabels = [];

  void addReadings(List<VehicleReadings> readings, int filter) {
    setState(() {
      _dataPoints.clear();
      _xLabels.clear();

      for (var reading in readings) {
        // Extract timestamp and panel voltage
        double x = reading.timestamp.millisecondsSinceEpoch.toDouble();
        double y = 0.0;


        switch (filter) {
          case 0:
            y = reading.cumulativePower;
            break;
          case 1:
            y = reading.fullCharges.toDouble();
            break;
          case 2:
            y = reading.hardwareVersion;
            break;
          case 3:
            y = reading.maxVolt;
            break;
          case 4:
            y = reading.operationalTime;
            break;
          case 5:
            y = reading.overDischarges;
            break;
          case 6:
            y = reading.panelCurrent;
            break;
          case 7:
            y = reading.panelVoltage;
            break;
          default:
            throw Exception("Invalid filter");
        }



        // Store the timestamp for formatting later
        _xLabels.add(reading.timestamp); // Save DateTime for labels
        _dataPoints.add(FlSpot(x, y));

      }
    });
  }



  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(16.0),
        child: Center(
        child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8, // Adjust width to 80% of screen
    child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: _dataPoints,
              isCurved: true,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
              preventCurveOverShooting: true,
              isStrokeCapRound: true,
              isStepLineChart: false,
            ),
          ],
          titlesData: FlTitlesData(
            topTitles: AxisTitles( // Remove top titles
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 86400000,
                getTitlesWidget: (value, _) {
                  DateTime date =
                  DateTime.fromMillisecondsSinceEpoch(value.toInt());
                  return Text(
                    DateFormat('dd-MM-yyyy HH:mm').format(date),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true,
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    ),
    ),
    );
  }
}
