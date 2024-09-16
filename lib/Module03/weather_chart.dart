import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeatherChart extends StatelessWidget {
  WeatherChart({
    super.key,
    Color? line1Color,
    Color? line2Color,
    Color? betweenColor,
    double? maxTemp,
    double? minTemp,
    List<dynamic>? dayTemp,
  })  : line1Color = line1Color ?? Colors.green,
        line2Color = line2Color ??  Colors.red,
        betweenColor =
            betweenColor ?? Colors.red.withOpacity(0.5),
        maxTemp = maxTemp ?? 30,
        minTemp = minTemp ?? 0,
        dayTemp = dayTemp ?? [];

  final Color line1Color;
  final Color line2Color;
  final Color betweenColor;
  final double maxTemp;
  final double minTemp;
  final List<dynamic> dayTemp;

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: Colors.white
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '02:00';
        break;
      case 1:
        text = '04:00';
        break;
      case 2:
        text = '06:00';
        break;
      case 3:
        text = '08:00';
        break;
      case 4:
        text = '10:00';
        break;
      case 5:
        text = '12:00';
        break;
      case 6:
        text = '14:00';
        break;
      case 7:
        text = '16:00';
        break;
      case 8:
        text = '18:00';
        break;
      case 9:
        text = '20:00';
        break;
      case 10:
        text = '22:00';
        break;
      case 11:
        text = '23:00';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 10, 
      color: Colors.white, 
      fontWeight: FontWeight.bold);
      
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        ' ${(minTemp + value)} °C',
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 20,
          top: 10,
          bottom: 4,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, (dayTemp[2] - minTemp)),
                  FlSpot(1, (dayTemp[4] - minTemp)),
                  FlSpot(2, (dayTemp[6] - minTemp)),
                  FlSpot(3, (dayTemp[8] - minTemp)),
                  FlSpot(4, (dayTemp[10] - minTemp)),
                  FlSpot(5, (dayTemp[12] - minTemp)),
                  FlSpot(6, (dayTemp[14] - minTemp)),
                  FlSpot(7, (dayTemp[16] - minTemp)),
                  FlSpot(8, (dayTemp[18] - minTemp)),
                  FlSpot(9, (dayTemp[20] - minTemp)),
                  FlSpot(10, (dayTemp[22] - minTemp)),
                  FlSpot(11, (dayTemp[23] - minTemp)),     
                ],
                isCurved: true,
                barWidth: 2,
                color: line1Color,
                dotData: const FlDotData(
                  show: false,
                ),
              ),
             
            ],
           
            minY: 0 ,
            borderData: FlBorderData(
              show: false,
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: leftTitleWidgets,
                  interval: 1,
                  reservedSize: 50,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          ),
        ),
      ),
    );
  }
}