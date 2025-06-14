import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:intl/intl.dart';

class TransactionscertifM extends StatefulWidget {
  final String? montant;
  final String? operatorName;
  final String? creditNumber;
  final String? ownerName;
  final String? accountType;
  final String? accountRIB;
  final String? transactionReference;
  final DateTime? transactionDate;
  final String? transactionType;
  final double? commission;
  final double? totalAmount;

  const TransactionscertifM({
    super.key,
    this.montant,
    this.operatorName,
    this.creditNumber,
    this.ownerName,
    this.accountType,
    this.accountRIB,
    this.transactionReference,
    this.transactionDate,
    this.transactionType = "Retrait Mobile Money",
    this.commission,
    this.totalAmount,
  });

  @override
  State<TransactionscertifM> createState() => _TransactionscertifMState();
}

class _TransactionscertifMState extends State<TransactionscertifM> {
  int myIndex = 0;

  String _formatDate(DateTime? date) {
    if (date == null) return DateTime.now().toString();
    return DateFormat('dd/MM/yyyy à HH:mm').format(date);
  }

  String _generateReference() {
    if (widget.transactionReference != null && widget.transactionReference!.isNotEmpty) {
      return widget.transactionReference!;
    }
    // Generate a random reference number
    return DateTime.now().millisecondsSinceEpoch.toString().substring(5);
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text("Confirmation de Transaction"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Stack(
              children: [
                Image.asset("assets/conf.gif"),
              ],
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Security Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.security, size: 40, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          "Transaction certifiée\npar Bamboo Sentinelle",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),

                    SizedBox(height: 30),

                    // Success Message
                    Text(
                      "Votre retrait a été effectué avec succès.\nConsultez votre Historique pour vérifier le\nstatut de votre transaction",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 30),

                    // Divider
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.grey[300],
                    ),

                    SizedBox(height: 20),

                    // Transaction Details
                    _buildDetailRow("Type d'opération", widget.transactionType ?? "Retrait Mobile Money"),
                    _buildDetailRow("Montant", "${widget.montant ?? '0'} XAF"),
                    _buildDetailRow("Commission", "${widget.commission?.toStringAsFixed(0) ?? '0'} XAF"),
                    _buildDetailRow("Total débité", "${widget.totalAmount?.toStringAsFixed(0) ?? widget.montant ?? '0'} XAF"),
                    _buildDetailRow("Date", _formatDate(widget.transactionDate)),
                    _buildDetailRow("Opérateur", widget.operatorName ?? "N/A"),
                    _buildDetailRow("Numéro crédité", widget.creditNumber ?? "N/A"),
                    _buildDetailRow("Propriétaire", widget.ownerName ?? "N/A"),
                    _buildDetailRow("Compte débité", "${widget.accountType ?? ''} : ${widget.accountRIB ?? 'N/A'}"),
                    _buildDetailRow("Référence", _generateReference()),

                    SizedBox(height: 40),

                    // Action Buttons
                    _buildActionButton(
                      icon: Icons.history,
                      text: "Consulter l'historique",
                      onTap: () {
                        // Navigate to history page
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
                      },
                    ),

                    SizedBox(height: 15),

                    _buildActionButton(
                      icon: Icons.wallet,
                      text: "Nouvelle opération",
                      onTap: () {
                        // Navigate back to main screen or close current screens
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                    ),

                    SizedBox(height: 15),

                    _buildActionButton(
                      icon: Icons.share,
                      text: "Partager le reçu",
                      onTap: () {
                        _shareReceipt();
                      },
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Color(0xFF4A9E1F),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            SizedBox(width: 15),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _shareReceipt() {
    // Implementation for sharing receipt
    String receiptText = """
🧾 REÇU DE TRANSACTION 🧾

Type: ${widget.transactionType ?? "Retrait Mobile Money"}
Montant: ${widget.montant ?? '0'} XAF
Commission: ${widget.commission?.toStringAsFixed(0) ?? '0'} XAF
Total: ${widget.totalAmount?.toStringAsFixed(0) ?? widget.montant ?? '0'} XAF
Date: ${_formatDate(widget.transactionDate)}
Opérateur: ${widget.operatorName ?? "N/A"}
Numéro: ${widget.creditNumber ?? "N/A"}
Propriétaire: ${widget.ownerName ?? "N/A"}
Référence: ${_generateReference()}

✅ Transaction certifiée par Bamboo Sentinelle
    """;

    // You can use share_plus package to share
    // Share.share(receiptText);

    // For now, show a dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Partager le reçu"),
        content: Text("Fonctionnalité de partage sera ajoutée prochainement"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}