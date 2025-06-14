import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';

class TransactionscertifDi extends StatefulWidget {
  final String? montant;
  final String? beneficiaire;
  final String? compteDebiteur;
  final String? motif;
  final DateTime? dateTransaction;
  final String? reference;
  final String? frais;
  final String? typeOperation;
  final String? digicode;

  const TransactionscertifDi({
    super.key,
    this.montant,
    this.beneficiaire,
    this.compteDebiteur,
    this.motif,
    this.dateTransaction,
    this.reference,
    this.frais,
    this.typeOperation = "Retrait Gab",
    this.digicode,
  });

  @override
  State<TransactionscertifDi> createState() => _TransactionscertifDiState();
}

class _TransactionscertifDiState extends State<TransactionscertifDi> {
  int myIndex = 0;

  String formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} à ${date.hour.toString().padLeft(2, '0')}H${date.minute.toString().padLeft(2, '0')}";
  }

  String generateDigicode() {
    if (widget.digicode != null && widget.digicode!.isNotEmpty) {
      return widget.digicode!;
    }
    return DateTime.now().millisecondsSinceEpoch.toString().substring(1, 10);
  }

  String generateReference() {
    if (widget.reference != null && widget.reference!.isNotEmpty) {
      return widget.reference!;
    }
    return DateTime.now().millisecondsSinceEpoch.toString().substring(5);
  }

  Widget buildInfoRow(String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Divider(
              color: Colors.grey[300],
              thickness: 0.8,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String digicode = generateDigicode();

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (int index) {
            setState(() {
              myIndex = index;
            });
          }
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with success icon
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    // Success icon with green circle background
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Security badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.green.withOpacity(0.3)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.security, color: Colors.green, size: 20),
                          SizedBox(width: 8),
                          Text(
                            "Transaction certifiée\npar Bamboo Sentinelle",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Main content card
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Success message
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: Text(
                        "Votre ${widget.typeOperation?.toLowerCase()} a été effectué\navec succès.",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    // Dotted divider
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: List.generate(
                          30,
                              (index) => Expanded(
                            child: Container(
                              height: 1,
                              color: index % 2 == 0 ? Colors.grey[300] : Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Transaction details
                    buildInfoRow("Type d'opération", widget.typeOperation ?? "Retrait Gab"),
                    buildInfoRow("Montant", "${widget.montant ?? '200 000'} XAF"),
                    buildInfoRow("Date", formatDate(widget.dateTransaction ?? DateTime.now())),
                    buildInfoRow("Motifs", widget.motif?.isNotEmpty == true ? widget.motif! : "Autres"),
                    buildInfoRow("Référence", generateReference(), isLast: true),

                    SizedBox(height: 40),

                    // Digicode section
                    Column(
                      children: [
                        Text(
                          "Digicode",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Text(
                            digicode,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 50),

                    // Action buttons
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          // Get itinerary button
                          GestureDetector(
                            onTap: () {
                              // Handle get itinerary action
                              _showItineraryDialog(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF4A9E1F).withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on, color: Colors.white, size: 24),
                                  SizedBox(width: 12),
                                  Text(
                                    "Obtenir l'itinéraire",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 15),

                          // Consult history button
                          GestureDetector(
                            onTap: () {
                              Navigator.popUntil(context, (route) => route.isFirst);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF4A9E1F).withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.history, color: Colors.white, size: 24),
                                  SizedBox(width: 12),
                                  Text(
                                    "Consulter l'historique",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  void _showItineraryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFF4A9E1F)),
              SizedBox(width: 10),
              Text(
                "Distributeurs à proximité",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Voici les distributeurs les plus proches de votre localisation :",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              _buildATMItem("Bamboo GAB - Centre Ville", "150m", Icons.atm),
              SizedBox(height: 10),
              _buildATMItem("Bamboo GAB - Marché Central", "300m", Icons.atm),
              SizedBox(height: 10),
              _buildATMItem("Bamboo GAB - Université", "500m", Icons.atm),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Fermer",
                style: TextStyle(color: Color(0xFF4A9E1F)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Open maps or navigation
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A9E1F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Naviguer", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildATMItem(String name, String distance, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF4A9E1F), size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  distance,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.navigation, color: Color(0xFF4A9E1F), size: 20),
        ],
      ),
    );
  }
}