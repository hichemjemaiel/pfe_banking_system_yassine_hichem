import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pfe_banking_system/screens/historique/model/BankOpDTO.dart';
import 'package:pfe_banking_system/screens/historique/provider/BankOpDTOProvider.dart';

class ExpensesChart extends StatefulWidget {
  final int bankId;
  final String type; // 'withdrawl' for expenses

  const ExpensesChart({
    Key? key,
    required this.bankId,
    this.type = 'withdrawl', // Default to withdrawals as expenses
  }) : super(key: key);

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  bool isLoading = true;
  List<BankOpDTO> operations = [];
  int totalExpenses = 0;
  Map<String, int> monthlyExpenses = {};
  List<FlSpot> spots = [];

  // Debug flag to check if data is being processed correctly
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final provider = Provider.of<BankOpDTOProvider>(context, listen: false);

    try {
      // Get all operations of the specified type
      operations = await provider.getAllBankingOpsForBankAccountByType(
          widget.bankId,
          widget.type
      );

      // Calculate total expenses
      for (var op in operations) {
        totalExpenses += op.montant;
      }

      // Process data for the chart if there are operations
      if (operations.isNotEmpty) {
        processChartData();
        hasData = true;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching chart data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void processChartData() {
    // Group by date (use day as the key for more data points)
    final Map<String, int> dailyExpenses = {};

    for (var op in operations) {
      final date = op.date.substring(0, 10); // Using YYYY-MM-DD format

      if (dailyExpenses.containsKey(date)) {
        dailyExpenses[date] = (dailyExpenses[date] ?? 0) + op.montant;
      } else {
        dailyExpenses[date] = op.montant;
      }
    }

    // Create chart spots from daily expenses
    // Sort dates first
    final sortedDates = dailyExpenses.keys.toList()..sort();

    // Track cumulative expenses for area chart
    int cumulativeAmount = 0;

    // Create spots with cumulative amounts
    for (int i = 0; i < sortedDates.length; i++) {
      final date = sortedDates[i];
      cumulativeAmount += dailyExpenses[date]!;
      spots.add(FlSpot(i.toDouble(), cumulativeAmount.toDouble()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator())
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total expenses header
          const Text(
            'Total expenses',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),

          // Total amount
          Text(
            '${NumberFormat('#,###').format(totalExpenses)} XAF',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Chart section - only show if we have data
          if (hasData && spots.isNotEmpty)
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value == 0) return const Text('0');
                          if (value % 1000 == 0) {
                            return Text('${(value/1000).toInt()}k');
                          }
                          return const Text('');
                        },
                        reservedSize: 40,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.green,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green.withOpacity(0.2),
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(enabled: false),
                ),
              ),
            )
          else
          // Fallback when no chart data is available
            const SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'No chart data available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}