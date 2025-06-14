import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:intl/intl.dart';

class TransactionData {
  final String amount;
  final String operatorName;
  final String creditNumber;
  final String accountType;
  final String accountRIB;
  final String transactionReference;
  final DateTime transactionDate;
  final double commission;
  final double transactionCost;

  TransactionData({
    required this.amount,
    required this.operatorName,
    required this.creditNumber,
    required this.accountType,
    required this.accountRIB,
    required this.transactionReference,
    required this.transactionDate,
    this.commission = 119.0,
    this.transactionCost = 0.0,
  });
}

class TransactionscertifMoney extends StatefulWidget {
  final TransactionData? transactionData;

  const TransactionscertifMoney({super.key, this.transactionData});

  @override
  State<TransactionscertifMoney> createState() => _TransactionscertifMoneyState();
}

class _TransactionscertifMoneyState extends State<TransactionscertifMoney> {
  int myIndex = 0;

  // Helper method to format numbers with spaces
  String formatAmount(double amount) {
    final formatter = NumberFormat('#,###', 'fr_FR');
    return formatter.format(amount).replaceAll(',', ' ');
  }

  // Helper method to format phone number
  String _formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length >= 8) {
      return phoneNumber.replaceAllMapped(
        RegExp(r'(\d{2})(\d{2})(\d{2})(\d{2})'),
            (Match m) => '${m[1]} ${m[2]} ${m[3]} ${m[4]}',
      );
    }
    return phoneNumber;
  }

  // Helper method to format date and time
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy à HH\'h\'mm').format(dateTime);
  }

  // Helper method to generate transaction reference
  String _generateReference() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(3);
  }

  Widget _buildTransactionRow(String label, String value, {bool isAmount = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: Text(
                  isAmount ? "$value XAF" : value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use provided data or default values
    final transactionData = widget.transactionData;
    final amount = transactionData?.amount ?? "50 000";
    final operatorName = transactionData?.operatorName ?? "Orange Money";
    final creditNumber = transactionData?.creditNumber ?? "77464758";
    final accountInfo = transactionData != null
        ? "${transactionData!.accountType}: ${transactionData!.accountRIB}"
        : "Compte Courant: 12345678901234567890";
    final transactionDate = transactionData?.transactionDate ?? DateTime.now();
    final reference = transactionData?.transactionReference ?? _generateReference();
    final commission = transactionData?.commission ?? 119.0;
    final transactionCost = transactionData?.transactionCost ?? 0.0;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (int index) {
            setState(() {
              myIndex = index;
            });
          }
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Transaction Certifiée"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            // Success Animation/Image
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/conf.gif",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),

            // Main Content Container
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),

                  // Security Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.security, size: 30, color: Colors.green),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Transaction certifiée\npar Bamboo Sentinelle",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Success Message
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Votre transaction Mobile Money a été effectuée avec succès.\nConsultez votre Historique pour vérifier le statut de votre transaction",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  SizedBox(height: 30),

                  // Divider
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    height: 1,
                    color: Colors.grey[300],
                  ),

                  SizedBox(height: 20),

                  // Transaction Details
                  _buildTransactionRow("Type d'opération", "Dépôt Mobile Money"),
                  _buildTransactionRow("Montant", formatAmount(double.tryParse(amount) ?? 0), isAmount: true),
                  _buildTransactionRow("Opérateur", operatorName),
                  _buildTransactionRow("Numéro crédité", _formatPhoneNumber(creditNumber)),
                  _buildTransactionRow("Compte débité", accountInfo),
                  _buildTransactionRow("Date", _formatDateTime(transactionDate)),
                  _buildTransactionRow("Commission TTC", formatAmount(commission), isAmount: true),
                  _buildTransactionRow("Coût transaction TTC", formatAmount(transactionCost), isAmount: true),
                  _buildTransactionRow("Référence", reference),

                  SizedBox(height: 40),

                  // Action Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        // History Button
                        InkWell(
                          onTap: () {
                            // Navigate to history page
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Redirection vers l'historique..."),
                                backgroundColor: Color(0xFF4A9E1F),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.history, size: 24, color: Colors.white),
                                SizedBox(width: 12),
                                Text(
                                  "Consulter l'historique",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 15),

                        // New Operation Button
                        InkWell(
                          onTap: () {
                            // Navigate back to main screen or new operation
                            Navigator.of(context).popUntil((route) => route.isFirst);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Color(0xFF4A9E1F), width: 2),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline, size: 24, color: Color(0xFF4A9E1F)),
                                SizedBox(width: 12),
                                Text(
                                  "Nouvelle opération",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF4A9E1F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}