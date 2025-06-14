import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';

class TransactionscertifRAgence extends StatefulWidget {
  final int? montant;
  final String? agencyName;
  final String? accountRIB;
  final String? transactionReference;
  final DateTime? transactionDate;
  final String? operationType;

  const TransactionscertifRAgence({
    super.key,
    this.montant,
    this.agencyName,
    this.accountRIB,
    this.transactionReference,
    this.transactionDate,
    this.operationType = "Retrait en Agence",
  });

  @override
  State<TransactionscertifRAgence> createState() => _TransactionscertifRAgenceState();
}

class _TransactionscertifRAgenceState extends State<TransactionscertifRAgence> {
  int myIndex = 0;

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} à ${date.hour.toString().padLeft(2, '0')}H${date.minute.toString().padLeft(2, '0')}";
  }

  String _formatAmount(int? amount) {
    if (amount == null) return "N/A";
    return "${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} XAF";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (int index){
        setState(() {
          myIndex = index;
        });
      }),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Transaction Confirmée"),
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
              height: MediaQuery.of(context).size.height+100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  // Security Badge
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

                  // Success Message
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 10),
                    child: Text(
                      "Votre opération a été effectuée avec succès.\nConsultez votre Historique pour vérifier le\n               statut de votre transaction",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  // Separator
                  Text(
                    "------------------------------------------------------------------",
                    style: TextStyle(fontSize: 20),
                  ),

                  // Transaction Details
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Type d'opération", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 60),
                        Text(
                          widget.operationType ?? "Retrait en Agence",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Montant", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 210),
                        Text(
                          _formatAmount(widget.montant),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Date", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 165),
                        Text(
                          _formatDate(widget.transactionDate ?? DateTime.now()),
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),

                  if (widget.agencyName != null) ...[
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Text("Agence", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 250),
                          Text(
                            widget.agencyName!,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ],

                  if (widget.accountRIB != null) ...[
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Text("Compte débité", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 150),
                          Expanded(
                            child: Text(
                              widget.accountRIB!,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],

                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Référence", style: TextStyle(fontSize: 20)),
                        SizedBox(width: 200),
                        Text(
                          widget.transactionReference ?? "En cours...",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Action Buttons
                  InkWell(
                    onTap: () {
                      // Navigate to transaction history
                      // You can implement navigation to history page here
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

                  InkWell(
                    onTap: () {
                      // Navigate back to home or new operation
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