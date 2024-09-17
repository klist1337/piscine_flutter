
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:piscine_mobile/Module03/function.dart';

class WeeklyWeatherChart extends StatelessWidget {
  WeeklyWeatherChart({
    super.key,
    Color? line1Color,
    Color? line2Color,
    Color? betweenColor,
    List<dynamic>? weatherDate,
    List<dynamic>? listMaxTemp,
    List<dynamic>? listMinTemp,
    double? minTemp,
    double? maxTemp,

    
  })  : line1Color = line1Color ?? Colors.blue.shade700,
        line2Color = line2Color ?? Colors.red,
        betweenColor =
            betweenColor ?? const Color.fromARGB(255, 57, 47, 46).withOpacity(0.5),
        weatherDate = weatherDate ?? [],
        listMaxTemp = listMaxTemp ?? [],
        listMinTemp = listMinTemp ?? [],
        maxTemp = maxTemp ?? 0,
        minTemp = minTemp ?? 0;
        

  final Color line1Color;
  final Color line2Color;
  final Color betweenColor;
  final List<dynamic> weatherDate;
  final List<dynamic> listMaxTemp;
  final List<dynamic> listMinTemp;
  final double maxTemp;
  final double minTemp;
  

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.white
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = formatDate(weatherDate[0]);
        break;
      case 1:
        text = formatDate(weatherDate[1]);
        break;
      case 2:
        text = formatDate(weatherDate[2]);
        break;
      case 3:
        text = formatDate(weatherDate[3]);
        break;
      case 4:
        text = formatDate(weatherDate[4]);
        break;
      case 5:
        text = formatDate(weatherDate[5]);
        break;
      case 6:
        text = formatDate(weatherDate[6]);
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(text, style: style),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        '${minTemp + value}',
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
          right: 18,
          top: 10,
          bottom: 4,
        ),
        child: LineChart(
          LineChartData(
            lineTouchData: const LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, listMaxTemp[0] - minTemp),
                  FlSpot(1, listMaxTemp[1] - minTemp),
                  FlSpot(2, listMaxTemp[2] - minTemp),
                  FlSpot(3, listMaxTemp[3] - minTemp),
                  FlSpot(4, listMaxTemp[4] - minTemp),
                  FlSpot(5, listMaxTemp[5] - minTemp),
                  FlSpot(6, listMaxTemp[6] - minTemp),
                ],
                isCurved: true,
                barWidth: 2,
                color: line1Color,
                dotData: const FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: [
                  FlSpot(0, listMinTemp[0] - minTemp),
                  FlSpot(1, listMinTemp[1] - minTemp),
                  FlSpot(2, listMinTemp[2] - minTemp),
                  FlSpot(3, listMinTemp[3] - minTemp),
                  FlSpot(4,listMinTemp[4] - minTemp),
                  FlSpot(5,listMinTemp[5] - minTemp),
                  FlSpot(6, listMinTemp[6] - minTemp),
                ],
                isCurved: true,
                barWidth: 2,
                color: line2Color,
                dotData: const FlDotData(
                  show: false,
                ),
              ),
            ],
            betweenBarsData: [
              BetweenBarsData(
                fromIndex: 0,
                toIndex: 1,
                color: betweenColor,
              )
            ],
            minY: 0,
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
                  reservedSize: 40,
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