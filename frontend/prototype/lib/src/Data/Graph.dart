import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prototype/src/DAOs/VehicleReadings.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({Key? key}) : super(key: key);

  @override
  LineChartWidgetState createState() => LineChartWidgetState();
}

class LineChartWidgetState extends State<LineChartWidget> {
  final List<FlSpot> _dataPoints = [];

  void addReadings(List<VehicleReadings> readings) {
    setState(() {
      _dataPoints.clear(); // Clear previous data
      for (var reading in readings) {
        // Assuming timestamp as x and panelVoltage as y
        double x = reading.timestamp.millisecondsSinceEpoch.toDouble();
        double y = reading.panelVoltage;
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
          titlesData: FlTitlesData(show: true),
          borderData: FlBorderData(show: true),
        ),
      ),
    );
  }
}
