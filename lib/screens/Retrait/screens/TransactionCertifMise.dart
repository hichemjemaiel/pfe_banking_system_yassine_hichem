import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';

class TransactionscertifMiseD extends StatefulWidget {
  final String montant;
  final String creditnum;
  final String namecreditnum;
  final String accountRIB;
  final String accountType;
  final String? transactionId;
  final String date;

  const TransactionscertifMiseD({
    super.key,
    required this.montant,
    required this.creditnum,
    required this.namecreditnum,
    required this.accountRIB,
    required this.accountType,
    this.transactionId,
    required this.date,
  });

  @override
  State<TransactionscertifMiseD> createState() => _TransactionscertifMiseDState();
}

class _TransactionscertifMiseDState extends State<TransactionscertifMiseD> {
  int myIndex = 0;

  String _formatDate(String date) {
    // Convert date format from DD-MM-YYYY to DD/MM/YYYY à HH:MM
    DateTime now = DateTime.now();
    String formattedTime = "${now.hour.toString().padLeft(2, '0')}H${now.minute.toString().padLeft(2, '0')}";
    return "${date.replaceAll('-', '/')} à $formattedTime";
  }

  String _generateReference() {
    // Generate a reference number based on transaction data or use provided transactionId
    if (widget.transactionId != null) {
      return widget.transactionId!;
    }
    // Generate a random reference number
    return (DateTime.now().millisecondsSinceEpoch % 1000000000).toString();
  }

  double _calculateFees() {
    double amount = double.parse(widget.montant);
    return amount * 0.02 < 1000 ? 1000 : amount * 0.02;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (int index) {
        setState(() {
          myIndex = index;
        });
      }),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Confirmation"),
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
              height: MediaQuery.of(context).size.height +100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Icon(Icons.security, size: 40, color: Colors.green),
                        SizedBox(width: 10),
                        Text(
                          "Transaction certifiée\npar Bamboo Sentinelle",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: Text(
                      "Votre mise à disposition a été effectuée avec succès.\nConsultez votre Historique pour vérifier le\n               statut de votre transaction",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "------------------------------------------------------------------",
                    style: TextStyle(fontSize: 20),
                  ),

                  // Transaction Type
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      children: [
                        Text("Type d'opération", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 60),
                        Expanded(
                          child: Text(
                            "Mise à disposition",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Account Info
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Compte débité", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 80),
                        Expanded(
                          child: Text(
                            "${widget.accountType} | ${widget.accountRIB}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Beneficiary Name
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Bénéficiaire", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 100),
                        Expanded(
                          child: Text(
                            widget.namecreditnum,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Beneficiary Number
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Numéro bénéficiaire", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 30),
                        Expanded(
                          child: Text(
                            widget.creditnum,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Amount
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Montant", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 150),
                        Expanded(
                          child: Text(
                            "${double.parse(widget.montant).toStringAsFixed(0)} XAF",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Fees
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Frais", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 180),
                        Expanded(
                          child: Text(
                            "${_calculateFees().toStringAsFixed(0)} XAF",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Date
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Date", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 100),
                        Expanded(
                          child: Text(
                            _formatDate(widget.date),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  // Reference
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Référence", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 120),
                        Expanded(
                          child: Text(
                            _generateReference(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),

                  // History Button
                  InkWell(
                    onTap: () {
                      // Navigate to history screen
                      // Navigator.pushNamed(context, '/history');
                    },
                    child: Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.history, size: 30, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Consulter l'historique",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // New Operation Button
                  InkWell(
                    onTap: () {
                      // Navigate back to main screen or new operation
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            Icon(Icons.wallet, size: 30, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              "Nouvelle opération",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}