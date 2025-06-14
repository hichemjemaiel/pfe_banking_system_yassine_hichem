import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:pfe_banking_system/screens/historique/model/BankOpDTO.dart';
import 'package:pfe_banking_system/screens/historique/provider/BankOpDTOProvider.dart';

import 'Expenses chart.dart'; // Import the ExpensesChart component

class ExpensesPage extends StatefulWidget {
  final int bankId;

  const ExpensesPage({
    Key? key,
    required this.bankId,
  }) : super(key: key);

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  late Future<List<BankOpDTO>> _operationsFuture;

  @override
  void initState() {
    super.initState();
    _operationsFuture = Provider.of<BankOpDTOProvider>(context, listen: false)
        .getAllBankingOpsForBankAccountByType(widget.bankId, 'withdrawl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Overview'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expenses chart - fixed and simplified
              ExpensesChart(bankId: widget.bankId),

              // Monthly breakdown section
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                child: Text(
                  'Monthly Breakdown',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ),

              // Transactions list with improved styling to match screenshot
              FutureBuilder<List<BankOpDTO>>(
                future: _operationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  }

                  final operations = snapshot.data ?? [];

                  if (operations.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Text('No expense transactions found for this account'),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: operations.length,
                    itemBuilder: (context, index) {
                      final operation = operations[index];
                      return ExpenseTransactionCard(operation: operation);
                    },
                  );
                },
              ),

              // Add some bottom padding
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Transaction card widget to display individual transactions - styled to match screenshot
class ExpenseTransactionCard extends StatelessWidget {
  final BankOpDTO operation;

  const ExpenseTransactionCard({
    Key? key,
    required this.operation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date for display
    String displayDate = operation.date;
    try {
      final parsedDate = DateTime.parse(operation.date);
      displayDate = '${parsedDate.day}-${parsedDate.month}-${parsedDate.year}';
    } catch (e) {
      // Keep original format if parsing fails
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Transaction icon - red arrow up for expenses
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_upward, color: Colors.red, size: 20),
            ),

            const SizedBox(width: 16),

            // Transaction details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Withdrawal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    displayDate,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  if (operation.operateurName != null && operation.operateurName!.isNotEmpty)
                    Text(
                      'Operator: ${operation.operateurName}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),

            // Amount (negative for expenses)
            Text(
              '- ${operation.montant} XAF',
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}