import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20ver%20mes%20comptes/Mone.dart';

class TransactionscertifVi extends StatefulWidget {
  final String montant;
  final String senderRIB;
  final String receiverRIB;
  final String date;
  final String bankOpId;
  final int? id;
   TransactionscertifVi({
    super.key,
    required this.montant,
    required this.senderRIB,
    required this.receiverRIB,
    required this.date,
    required this.bankOpId,  this.id,
  });

  @override
  State<TransactionscertifVi> createState() => _TransactionscertifViState();
}

class _TransactionscertifViState extends State<TransactionscertifVi> {
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
        title: const Text("Confirmation de Transaction"),
        centerTitle: true,
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
              height: MediaQuery.of(context).size.height +100,
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
                      children: const [
                        Icon(Icons.security, size: 40, color: Colors.green),
                        SizedBox(width: 10),
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
                      "Votre virement a été effectué avec succès.\nConsultez votre Historique pour vérifier le\nstatut de votre transaction",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Text(
                    "------------------------------------------------------------------",
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text("Type d'opération", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 60),
                        const Text(
                          "Virement Interne",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text("Montant", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 210),
                        Text(
                          "${widget.montant} XAF",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text("Compte Débité", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 30),
                        Text(
                          widget.senderRIB,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text("Compte Crédité", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 30),
                        Text(
                          widget.receiverRIB,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text("Date", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 165),
                        Text(
                          widget.date,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        const Text("Référence", style: TextStyle(fontSize: 20)),
                        const SizedBox(width: 200),
                        Text(
                          widget.bankOpId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
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
                    child: const Padding(
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
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mone(id: widget.id,))); // Return to previous screen for new operation
                    },
                    child: Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
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
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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