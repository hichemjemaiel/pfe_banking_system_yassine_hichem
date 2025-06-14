import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';

class TransactionscertifV extends StatefulWidget {
  final String operationType; // "Dépôt" or "Transfert"
  final String montant; // Transaction amount
  final String date; // Transaction date
  final String reference; // BankOpId
  final String motifs; // Transaction motive (default to "Autres" if not provided)

  const TransactionscertifV({
    super.key,
    required this.operationType,
    required this.montant,
    required this.date,
    required this.reference,
    this.motifs = "Autres",
  });

  @override
  State<TransactionscertifV> createState() => _TransactionscertifVState();
}

class _TransactionscertifVState extends State<TransactionscertifV> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(
        myIndex: myIndex,
        onTap: (int index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                Image.asset("assets/conf.gif"),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height - 347,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.security, size: 40, color: Colors.green),
                        const SizedBox(width: 10),
                        Text(
                          "Transaction certifiée\npar Bamboo Sentinelle",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10),
                    child: Text(
                      "Votre paiement a été effectué avec succès.\nConsultez votre Historique pour vérifier le\n               statut de votre transaction",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "------------------------------------------------------------------",
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Type d'opération", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 60),
                        Text(
                          widget.operationType,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Montant", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 210),
                        Text(
                          "${widget.montant} XAF",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Date", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 165),
                        Text(
                          widget.date,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Motifs", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 270),
                        Text(
                          widget.motifs,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Text("Référence", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 200),
                        Text(
                          widget.reference,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.history, size: 30, color: Colors.white),
                          const SizedBox(width: 10),
                          Text(
                            "Consulter l'historique",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.wallet, size: 30, color: Colors.white),
                          const SizedBox(width: 10),
                          Text(
                            "Nouvelle opération",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}