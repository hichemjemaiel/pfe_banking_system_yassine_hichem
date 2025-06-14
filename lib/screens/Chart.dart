import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:pfe_banking_system/screens/historique/model/BankOpDTO.dart';
import 'package:pfe_banking_system/screens/historique/provider/BankOpDTOProvider.dart';

class DailyTransactionChart extends StatefulWidget {
  final int bankId;
  final String rib;
  final int selectedMonth;
  final Function(double) onTotalCalculated;
  final String transactionType;
  final bool showOutgoing;
  final bool showIncoming;

  const DailyTransactionChart({
    Key? key,
    required this.bankId,
    required this.rib,
    required this.selectedMonth,
    required this.onTotalCalculated,
    required this.transactionType, //= 'deposit', // Could be 'deposit', 'withdrawl', or 'transfer'
    this.showOutgoing = true,
    this.showIncoming = true,
  }) : super(key: key);

  @override
  _DailyTransactionChartState createState() => _DailyTransactionChartState();
}

class _DailyTransactionChartState extends State<DailyTransactionChart> {
  bool _isLoading = true;
  List<DailyTransactionData> _dailyData = [];
  double _maxAmount = 35000; // Adjusted upper bound
  double _minAmount = 0; // Lower bound at 0
  int _daysInMonth = 31; // Default days in month
  String _monthName = '';
  double _totalAmount = 0; // Total monthly amount
  bool _hasTransactions = false; // Flag to track if there are any transactions

  // Transaction data storage
  Map<int, List<BankOpDTO>> _transactionsByDay = {};

  // Track days with transactions for dot display
  Set<int> _transactionDays = {};

  // Transaction type color mapping
  final Map<String, Color> _typeColors = {
    'deposit': Color(0xFF4A9E1F),  // Green for deposits
    'withdrawl': Color(0xFFE57373), // Red for withdrawals
    'transfer': Color(0xFF42A5F5),  // Blue for transfers
  };

  // Get the color for current transaction type
  Color get _currentTypeColor => _typeColors[widget.transactionType] ?? _typeColors['deposit']!;

  @override
  void initState() {
    super.initState();
    _updateMonthName();
    _fetchTransactionData();
  }

  @override
  void didUpdateWidget(DailyTransactionChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedMonth != widget.selectedMonth ||
        oldWidget.bankId != widget.bankId ||
        oldWidget.rib != widget.rib ||
        oldWidget.transactionType != widget.transactionType) {
      _updateMonthName();
      _fetchTransactionData();
    }
  }

  void _updateMonthName() {
    final DateTime date = DateTime(DateTime.now().year, widget.selectedMonth);
    _monthName = DateFormat('MMMM').format(date);

    // Calculate days in the selected month
    final year = DateTime.now().year;
    _daysInMonth = DateTime(year, widget.selectedMonth + 1, 0).day;
  }

  // Get appropriate title for transaction type
  String get _transactionTypeTitle {
    switch (widget.transactionType) {
      case 'deposit':
        return 'Dépôts';
      case 'withdrawl':
        return 'Retraits';
      case 'transfer':
        return 'Transferts';
      default:
        return 'Transactions';
    }
  }

  Future<void> _fetchTransactionData() async {
    setState(() {
      _isLoading = true;
      _hasTransactions = false;
      _transactionDays = {}; // Reset transaction days
      _transactionsByDay = {}; // Reset transactions by day
    });

    final provider = Provider.of<BankOpDTOProvider>(context, listen: false);

    try {
      // Fetch transactions from provider for the selected month and transaction type
      List<BankOpDTO> monthTransactions = await provider.getAllTransactionsForBankAccountByMonth(
          widget.bankId,
          widget.transactionType,
          widget.selectedMonth.toString()
      );

      // Also try to get the total amount from provider
      int? apiTotalAmount = await provider.getAmountForBankAccountByMonth(
          widget.bankId,
          widget.transactionType,
          widget.selectedMonth.toString()
      );

      // Set the hasTransactions flag
      _hasTransactions = monthTransactions.isNotEmpty;

      // Process data into daily aggregates if there are transactions
      if (_hasTransactions) {
        _processDailyTransactionData(monthTransactions);

        // If we got a valid total amount from the API, use it
        if (apiTotalAmount != null) {
          _totalAmount = apiTotalAmount.toDouble();
          widget.onTotalCalculated(_totalAmount);
          _adjustYAxisForAmount(_totalAmount);
        }
      } else {
        // If no transactions, create a flat line at the bottom
        _createEmptyDataPoints();

        // Get amount from API if available
        if (apiTotalAmount != null && apiTotalAmount > 0) {
          _totalAmount = apiTotalAmount.toDouble();
          widget.onTotalCalculated(_totalAmount);
          _adjustYAxisForAmount(_totalAmount);
          _createDataPointsForAmount(_totalAmount);
        } else {
          _totalAmount = 0;
          widget.onTotalCalculated(0);
        }
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching transaction data: $e');

      // Create empty chart on error
      _createEmptyDataPoints();
      _totalAmount = 0;
      widget.onTotalCalculated(0);

      setState(() {
        _isLoading = false;
      });
    }
  }

  void _adjustYAxisForAmount(double amount) {
    // For 15000 XAF, set appropriate y-axis bounds
    if (amount <= 3000) {
      _minAmount = 0;
      _maxAmount = 6000;
    } else if (amount <= 15000) {
      _minAmount = 0;
      _maxAmount = 30000;
    } else if (amount <= 30000) {
      _minAmount = 0;
      _maxAmount = 45000;
    } else {
      _minAmount = 0;
      _maxAmount = amount * 1.5;
    }
  }

  void _createEmptyDataPoints() {
    // Create a flat line at the minimum amount
    _dailyData = List.generate(_daysInMonth,
            (index) => DailyTransactionData(day: index + 1, amount: _minAmount));

    // Set max amount to ensure proper scaling
    _maxAmount = 5000; // Small range for empty chart
  }

  void _createDataPointsForAmount(double amount) {
    // If amount is 0, create an empty chart
    if (amount == 0) {
      _createEmptyDataPoints();
      return;
    }

    // If we have transaction data by day, use that to create accurate data points
    if (_transactionsByDay.isNotEmpty) {
      _createAccurateDataPoints();
      return;
    }

    // Otherwise create a synthetic curve
    // Calculate baseline - for visual appeal
    double baseline = amount * 0.2;

    // Define key points to create a visually pleasing curve
    List<FlSpot> keyPoints = [];

    // Start near the baseline
    keyPoints.add(FlSpot(0, baseline));

    // Create a curve that peaks at about 30-40% above the baseline
    keyPoints.add(FlSpot(_daysInMonth * 0.3, amount));
    keyPoints.add(FlSpot(_daysInMonth * 0.6, amount * 0.8));

    // End near the baseline
    keyPoints.add(FlSpot(_daysInMonth.toDouble(), baseline * 1.2));

    // Generate smooth curve through these points
    _dailyData = _generateSmoothData(keyPoints);
  }

  void _createAccurateDataPoints() {
    // Create a list of FlSpot points with actual transaction data
    List<FlSpot> keyPoints = [];

    // Start at baseline (0)
    keyPoints.add(FlSpot(0, 0));

    // Add points for days with transactions using exact amounts
    _transactionsByDay.forEach((day, transactions) {
      double totalForDay = 0;
      for (var transaction in transactions) {
        totalForDay += transaction.montant;
      }
      keyPoints.add(FlSpot(day.toDouble(), totalForDay));
    });

    // Add endpoint (return to baseline)
    keyPoints.add(FlSpot(_daysInMonth.toDouble(), 0));

    // Generate smooth curve through these points
    _dailyData = _generateSmoothData(keyPoints);
  }

  List<DailyTransactionData> _generateSmoothData(List<FlSpot> keyPoints) {
    List<DailyTransactionData> result = [];

    // Sort key points by X value
    keyPoints.sort((a, b) => a.x.compareTo(b.x));

    // Generate a point for each day by interpolating between key points
    for (int day = 1; day <= _daysInMonth; day++) {
      double amount = _minAmount;

      // If this is a transaction day, use the exact daily total
      if (_transactionsByDay.containsKey(day)) {
        double totalForDay = 0;
        for (var transaction in _transactionsByDay[day]!) {
          totalForDay += transaction.montant;
        }
        result.add(DailyTransactionData(day: day, amount: totalForDay));
        continue;
      }

      // Find surrounding key points
      FlSpot? before;
      FlSpot? after;

      for (var point in keyPoints) {
        if (point.x <= day && (before == null || point.x > before.x)) {
          before = point;
        }
        if (point.x >= day && (after == null || point.x < after.x)) {
          after = point;
        }
      }

      // Interpolate between points
      if (before != null && after != null && before != after) {
        // Linear interpolation
        double t = (day - before.x) / (after.x - before.x);
        amount = before.y + t * (after.y - before.y);
      } else if (before != null) {
        amount = before.y;
      } else if (after != null) {
        amount = after.y;
      }

      result.add(DailyTransactionData(day: day, amount: amount));
    }

    return result;
  }

  void _processDailyTransactionData(List<BankOpDTO> transactions) {
    // Calculate total from the actual transactions
    _totalAmount = 0;
    _transactionsByDay = {}; // Reset transaction by day map
    _transactionDays = {}; // Reset transaction days

    // For transfers, we may need to filter by RIB based on showOutgoing and showIncoming
    List<BankOpDTO> filteredTransactions = transactions;

    if (widget.transactionType == 'transfer') {
      filteredTransactions = transactions.where((transaction) {
        // For outgoing transfers (user is sender)
        bool isOutgoing = transaction.senderRIB == widget.rib;
        // For incoming transfers (user is receiver)
        bool isIncoming = transaction.receiverRIB == widget.rib;

        // Apply filters based on flags
        if (widget.showOutgoing && widget.showIncoming) {
          return true; // Show all transfers
        } else if (widget.showOutgoing && !widget.showIncoming) {
          return isOutgoing; // Only show outgoing
        } else if (!widget.showOutgoing && widget.showIncoming) {
          return isIncoming; // Only show incoming
        } else {
          return false; // Show nothing if both are false
        }
      }).toList();
    }

    for (var transaction in filteredTransactions) {
      _totalAmount += transaction.montant;

      try {
        // Parse date from "DD-MM-YYYY" format
        final dateParts = transaction.date.split('-');
        if (dateParts.length >= 2) {
          final day = int.tryParse(dateParts[0]);
          final month = int.tryParse(dateParts[1]);

          if (day != null && day >= 1 && day <= _daysInMonth &&
              month != null && month == widget.selectedMonth) {

            // Add this day to transaction days set
            _transactionDays.add(day);

            // Group transactions by day
            if (!_transactionsByDay.containsKey(day)) {
              _transactionsByDay[day] = [];
            }
            _transactionsByDay[day]!.add(transaction);
          }
        }
      } catch (e) {
        print('Error processing transaction date: ${transaction.date}, error: $e');
      }
    }

    // Adjust the y-axis bounds
    _adjustYAxisForAmount(_totalAmount);

    // Notify parent component of the total amount
    widget.onTotalCalculated(_totalAmount);

    // Generate accurate data points based on transaction data
    _createAccurateDataPoints();
  }

  // Get transaction description based on type
  String _getTransactionDescription(BankOpDTO transaction) {
    switch (transaction.type) {
      case 'deposit':
        return 'Dépôt' + (transaction.operateurName != null ? ' via ${transaction.operateurName}' : '');
      case 'withdrawl':
        return 'Retrait' + (transaction.operateurName != null ? ' via ${transaction.operateurName}' : '') +
            (transaction.namecreditnum != null && transaction.namecreditnum!.isNotEmpty ? ' pour ${transaction.namecreditnum}' : '');
      case 'transfer':
        if (transaction.senderRIB == widget.rib) {
          return 'Transfert sortant' +
              (transaction.namecreditnum != null && transaction.namecreditnum!.isNotEmpty ? ' à ${transaction.namecreditnum}' : '');
        } else {
          return 'Transfert entrant' +
              (transaction.namecreditnum != null && transaction.namecreditnum!.isNotEmpty ? ' de ${transaction.namecreditnum}' : '');
        }
      default:
        return 'Transaction';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _buildChart(),
        ),
      ),
    );
  }

  Widget _buildChart() {
    // If there are no transactions
    if (!_hasTransactions && _totalAmount == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            'Aucun ${_transactionTypeTitle.toLowerCase()} pour $_monthName',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 16),
          // Show a minimal flat line
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(_daysInMonth, (index) =>
                        FlSpot(index.toDouble(), _minAmount)),
                    isCurved: false,
                    barWidth: 2,
                    color: Colors.grey[300],
                    dotData: FlDotData(show: false),
                  ),
                ],
                minX: 0,
                maxX: _daysInMonth.toDouble() - 1,
                minY: _minAmount,
                maxY: 5000,
              ),
            ),
          ),
        ],
      );
    }

    // Regular chart for months with data
    return _buildLineChart();
  }

  Widget _buildLineChart() {
    // Determine appropriate Y-axis label values based on the total amount
    List<double> yAxisLabels = [];

    if (_totalAmount <= 3000) {
      yAxisLabels = [0, 1000, 2000, 3000, 4000, 5000];
    } else if (_totalAmount <= 15000) {
      yAxisLabels = [0, 5000, 10000, 15000, 20000, 25000, 30000];
    } else if (_totalAmount <= 30000) {
      yAxisLabels = [0, 10000, 20000, 30000, 40000];
    } else {
      // For larger amounts, generate appropriate intervals
      double interval = _maxAmount / 5;
      for (int i = 0; i <= 5; i++) {
        yAxisLabels.add(i * interval);
      }
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: _maxAmount / 5,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.withOpacity(0.2),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                // Show custom labels based on the total amount
                if (yAxisLabels.contains(value)) {
                  String formattedValue;
                  if (value >= 1000) {
                    formattedValue = '${(value / 1000).toInt()}K';
                  } else {
                    formattedValue = value.toInt().toString();
                  }
                  return Text(
                    formattedValue,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  );
                }
                return SizedBox.shrink();
              },
              interval: _maxAmount / 5,  // Ensure we have 5 intervals
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                // Only show day numbers at specific intervals or transaction days
                final int day = value.toInt() + 1;
                if (day == 1 || day == _daysInMonth || day % 10 == 0 || _transactionDays.contains(day)) {
                  return Text(
                    day.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: _transactionDays.contains(day) ? FontWeight.bold : FontWeight.normal,
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: _dailyData.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value.amount);
            }).toList(),
            isCurved: true,
            barWidth: 3,
            color: _currentTypeColor, // Use appropriate color based on transaction type
            belowBarData: BarAreaData(
              show: true,
              color: _currentTypeColor.withOpacity(0.2), // Light fill color
            ),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                final day = index + 1; // Convert index to day (1-based)

                // Show dots for transaction days
                if (_transactionDays.contains(day)) {
                  return FlDotCirclePainter(
                    radius: 5,
                    color: _currentTypeColor,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                }

                // Show smaller dots for key points (beginning, end, and every 10 days)
                if (day == 1 || day == _daysInMonth || day % 10 == 0) {
                  return FlDotCirclePainter(
                    radius: 3,
                    color: _currentTypeColor.withOpacity(0.6),
                    strokeWidth: 1,
                    strokeColor: Colors.white,
                  );
                }

                // Don't show dots for other days
                return FlDotCirclePainter(
                  radius: 0,
                  color: Colors.transparent,
                  strokeWidth: 0,
                  strokeColor: Colors.transparent,
                );
              },
            ),
          ),
        ],
        minX: 0,
        maxX: _daysInMonth.toDouble() - 1,
        minY: _minAmount,
        maxY: _maxAmount,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            //tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                final day = spot.x.toInt() + 1;

                // Prepare tooltip text
                String tooltipText = '';

                // If this is a transaction day, show detailed information
                if (_transactionDays.contains(day) && _transactionsByDay.containsKey(day)) {
                  final transactions = _transactionsByDay[day]!;
                  tooltipText = 'Jour $day - ${_transactionTypeTitle}\n';
                  tooltipText += '${transactions.length} opération(s)\n';

                  // Show total amount for this day
                  double totalForDay = 0;
                  for (var tx in transactions) {
                    totalForDay += tx.montant;
                  }
                  tooltipText += 'Total: ${NumberFormat.currency(symbol: 'XAF ', decimalDigits: 0).format(totalForDay)}';

                  // For transfer type, show additional details
                  if (widget.transactionType == 'transfer') {
                    final outgoing = transactions.where((tx) => tx.senderRIB == widget.rib).length;
                    final incoming = transactions.where((tx) => tx.receiverRIB == widget.rib).length;

                    if (outgoing > 0 && incoming > 0) {
                      tooltipText += '\n$outgoing sortant(s), $incoming entrant(s)';
                    } else if (outgoing > 0) {
                      tooltipText += '\n$outgoing transfert(s) sortant(s)';
                    } else if (incoming > 0) {
                      tooltipText += '\n$incoming transfert(s) entrant(s)';
                    }
                  }

                  // If there are specific operators for withdrawals or deposits
                  if (widget.transactionType != 'transfer') {
                    final operators = transactions
                        .where((tx) => tx.operateurName != null && tx.operateurName!.isNotEmpty)
                        .map((tx) => tx.operateurName)
                        .toSet();

                    if (operators.isNotEmpty) {
                      tooltipText += '\nOpérateurs: ${operators.join(', ')}';
                    }
                  }

                  // For withdrawals with recipient names
                  if (widget.transactionType == 'withdrawl') {
                    final recipients = transactions
                        .where((tx) => tx.namecreditnum != null && tx.namecreditnum!.isNotEmpty)
                        .map((tx) => tx.namecreditnum)
                        .toSet();

                    if (recipients.isNotEmpty) {
                      tooltipText += '\nDestinataires: ${recipients.join(', ')}';
                    }
                  }
                } else {
                  // For non-transaction days, just show the day and the interpolated amount
                  tooltipText = 'Jour $day\n${NumberFormat.currency(symbol: 'XAF ', decimalDigits: 0).format(spot.y)}';
                }

                return LineTooltipItem(
                  tooltipText,
                  TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

// Helper class to store daily transaction data
class DailyTransactionData {
  final int day;
  double amount;

  DailyTransactionData({
    required this.day,
    required this.amount,
  });
}