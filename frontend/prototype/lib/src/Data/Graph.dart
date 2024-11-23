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

  void addReadings(List<VehicleReadings> readings) {
    setState(() {
      _dataPoints.clear();
      _xLabels.clear();

      for (var reading in readings) {
        // Extract timestamp and panel voltage
        double x = reading.timestamp.millisecondsSinceEpoch.toDouble();
        double y = reading.panelVoltage;

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
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: _dataPoints,
              isCurved: true,
              barWidth: 2,
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 86400000, // Example interval (1 day)
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
              sideTitles: SideTitles(showTitles: true),
            ),
          ),
          borderData: FlBorderData(show: true),
        ),
      ),
    );

  }
}
