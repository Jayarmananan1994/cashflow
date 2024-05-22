import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CashFlowGraph extends StatelessWidget {
  final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  final List<double> cashFlowHistory;
  final int targetCashFlow;
  CashFlowGraph(
      {super.key, required this.cashFlowHistory, required this.targetCashFlow});

  @override
  Widget build(BuildContext context) {
    List<FlSpot> plots = cashFlowHistory
        .asMap()
        .entries
        .map((e) => FlSpot(e.key.toDouble(), e.value.toDouble()))
        .toList();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      height: 250,
      child: LineChart(LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: AxisTitles(
                sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              interval: 1000,
              getTitlesWidget: (value, meta) => Text('${(value / 1000)}K',
                  style: bodyMedium.copyWith(
                    color: greyColor,
                    fontWeight: FontWeight.bold,
                  )),
            ))),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: cashFlowHistory.length.toDouble(),
        minY: 0,
        maxY: targetCashFlow.toDouble(),
        lineBarsData: [
          LineChartBarData(
              belowBarData: BarAreaData(show: false),
              isCurved: true,
              barWidth: 4,
              color: primaryColor,
              dotData: FlDotData(show: false),
              spots: plots),
        ],
      )),
    );
  }
}
