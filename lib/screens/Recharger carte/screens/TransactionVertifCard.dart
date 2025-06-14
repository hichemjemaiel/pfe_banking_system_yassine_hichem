import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:intl/intl.dart';

class TransactionscertifCard extends StatefulWidget {
  final String? montant;
  final String? creditRib;
  final String? cardNumber;
  final String? cardHolderName;
  final String? banque;
  final String? operationType;
  final String? reference;
  final DateTime? transactionDate;

  const TransactionscertifCard({
    super.key,
    this.montant,
    this.creditRib,
    this.cardNumber,
    this.cardHolderName,
    this.banque,
    this.operationType,
    this.reference,
    this.transactionDate,
  });

  @override
  State<TransactionscertifCard> createState() => _TransactionscertifCardState();
}

class _TransactionscertifCardState extends State<TransactionscertifCard> {
  int myIndex = 0;

  String _formatCardNumber(String? cardNumber) {
    if (cardNumber == null || cardNumber.isEmpty) return 'N/A';
    if (cardNumber.length >= 4) {
      return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
    }
    return cardNumber;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return DateFormat('dd/MM/yyyy à HH:mm').format(DateTime.now());
    return DateFormat('dd/MM/yyyy à HH:mm').format(date);
  }

  String _generateReference() {
    if (widget.reference != null && widget.reference!.isNotEmpty) {
      return widget.reference!;
    }
    // Generate a random reference number
    return (DateTime.now().millisecondsSinceEpoch % 1000000000).toString();
  }

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
        title: const Text("Confirmation de transaction"),
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
              height: MediaQuery.of(context).size.height - 347,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100, top: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.security,
                            size: 40,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Transaction certifiée\npar Bamboo Sentinelle",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40, left: 10),
                      child: Text(
                        "Votre décharge de carte a été effectuée avec succès.\nConsultez votre Historique pour vérifier le\n               statut de votre transaction",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Text(
                      "------------------------------------------------------------------",
                      style: TextStyle(fontSize: 20),
                    ),

                    // Type d'opération
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Type d'opération",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 60),
                          Text(
                            widget.operationType ?? "Décharge de carte",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Compte crédité
                    if (widget.creditRib != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            const Text(
                              "Compte crédité",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 80),
                            Expanded(
                              child: Text(
                                widget.creditRib!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Carte débitée
                    if (widget.cardNumber != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            const Text(
                              "Carte débitée",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 110),
                            Text(
                              _formatCardNumber(widget.cardNumber),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Banque émettrice
                    if (widget.banque != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            const Text(
                              "Banque émettrice",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 60),
                            Text(
                              widget.banque!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Porteur de carte
                    if (widget.cardHolderName != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            const Text(
                              "Porteur de carte",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 70),
                            Expanded(
                              child: Text(
                                widget.cardHolderName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Montant
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          const Text(
                            "Montant",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 210),
                          Text(
                            "${widget.montant ?? '0'} XAF",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Frais
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Frais",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 250),
                          Text(
                            "1800 XAF",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Date
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 165),
                          Text(
                            _formatDate(widget.transactionDate),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Motifs
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Text(
                            "Motifs",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 150),
                          Text(
                            "Décharge de carte",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Référence
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          const Text(
                            "Référence",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(width: 200),
                          Text(
                            _generateReference(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Action buttons
                    InkWell(
                      onTap: () {
                        // Navigate to transaction history
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
                              Icon(
                                Icons.history,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Consulter l'historique",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    InkWell(
                      onTap: () {
                        // Navigate back to main screen or start new operation
                        Navigator.popUntil(context, (route) => route.isFirst);
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
                              Icon(
                                Icons.wallet,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Nouvelle opération",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}