import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:prototype/src/DAOs/vehicle_readings.dart';
import 'package:intl/intl.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});

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
      readings.removeLast();

      for (var reading in readings) {
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

        // Skip invalid values
        if (y.isNaN || y.isInfinite || y <= 0) continue;

        _xLabels.add(reading.timestamp);
        _dataPoints.add(FlSpot(x, y));
      }

      // Ensure the points are sorted by x (timestamp)
      _dataPoints.sort((a, b) => a.x.compareTo(b.x));

      // Remove duplicate points (if first and last points match)
      if (_dataPoints.isNotEmpty && _dataPoints.first.x == _dataPoints.last.x) {
        _dataPoints.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
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
      dotData: const FlDotData(show: true),
    ),
  ],
  minX: _dataPoints.isNotEmpty ? _dataPoints.first.x : 0.0,
  maxX: _dataPoints.isNotEmpty ? _dataPoints.last.x : 1.0,
  titlesData: FlTitlesData(
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        interval: 18000000000, // Show labels every interval time
        getTitlesWidget: (value, _) {
          DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
          return Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              DateFormat('HH:mm').format(date), // Show only time
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 40, // Space for better formatting
        interval: 200, // Adjust interval between labels
        getTitlesWidget: (value, _) {
          return Text(
            value.toStringAsFixed(0), // Format numbers as integers
            style: const TextStyle(fontSize: 10),
          );
        },
      ),
    ),
  ),
  borderData: FlBorderData(show: true),
  gridData: const FlGridData(
    show: true,
    drawHorizontalLine: true,
    drawVerticalLine: true,
  ),
)

          ),
        ),
      ),
    );
  }
}
