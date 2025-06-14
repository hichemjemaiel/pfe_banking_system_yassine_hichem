import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/provider/DechargeCardProvider.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rcfive.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rctthree.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
import '../../CreationParticulier/model/BankingAccountDTOModel.dart';
import '../../CreationParticulier/provider/BankingAccountDTOProvider.dart';
import '../../Depot/model/CardDto.dart';
import '../../Depot/provider/CardDtoProvider.dart';
import '../../OTP/provider/OtpProvider.dart';

class Rctfour extends StatefulWidget {
  int? id ;
   Rctfour({super.key,  this.id});

  @override
  State<Rctfour> createState() => _RctfourState();
}

class _RctfourState extends State<Rctfour> {
  int ind = 0;
  int ind1 = -1;
  int ind2 = -1;
  int ind3 = -1;
  int myIndex = 0;
  String? dechargeId;
  String? rib;
  String? card;
  String? otpCode;
  var key = GlobalKey<FormState>();

  TextEditingController montant = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Provider.of<BankingAccountDTOProvider>(context, listen: false)
        .getAllBankingAccountForClient(widget.id!);
    await Provider.of<CardDtoProvider>(context, listen: false)
        .getAllCardsToClientActive(widget.id!);
    print("Data loaded - Active cards: ${Provider.of<CardDtoProvider>(context, listen: false).Acards.length}");
  }

  void showRec(BuildContext context) {
    List<BankingAccountDTOModel> bankingAccounts =
        Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;
    List<CardDtoModel> acards =
        Provider.of<CardDtoProvider>(context, listen: false).Acards;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Récapitulatif",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Compte a créditer   ${ind1 != -1 ? bankingAccounts[ind1].RIB : 'N/A'}",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "----------------------------------------------------------------",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Carte a débiter          ${ind2 != -1 && acards.isNotEmpty ? '**** **** **** ${acards[ind2].number.substring(acards[ind2].number.length - 4)}' : 'N/A'}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "----------------------------------------------------------------",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Banque émettrice            ${_getBankName(ind3)}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "----------------------------------------------------------------",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Porteur de carte                   ${ind2 != -1 && acards.isNotEmpty ? acards[ind2].name : 'N/A'}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "----------------------------------------------------------------",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Montant                                 ${montant.text} XAF",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "----------------------------------------------------------------",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Frais                                         1800 XAF",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Annuler",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        rib = bankingAccounts[ind1].RIB;
                        card = acards[ind2].id.toString();
                      });

                      await Provider.of<OtpProvider>(context, listen: false)
                          .generateOtp("+21694399332");
                      otpCode = Provider.of<OtpProvider>(context, listen: false).otpCode;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Rcfive(
                            creditRib: rib!,
                            ind3: ind3,
                            card: card!,
                            otpCode: otpCode,
                            montant: montant.text,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Valider",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  String _getBankName(int index) {
    switch (index) {
      case 0:
        return "UBA GABON";
      case 1:
        return "ORABANK GABON";
      case 2:
        return "ECOBANK GABON";
      default:
        return "N/A";
    }
  }

  void showNotEnough(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 450,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                "Solde insuffisant",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 65, top: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Annuler",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to recharge screen
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Recharger",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getBankSelectionTitle() {
    switch (ind3) {
      case 0:
        return Text("UBA GABON");
      case 1:
        return Text("ORABANK GABON");
      case 2:
        return Text("ECOBANK GABON");
      default:
        return Text("Cliquer pour séléctionner");
    }
  }

  Widget _buildBankOption(String bankName, int index) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          setState(() {
            ind3 = index;
          });
        },
        child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(bankName),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<BankingAccountDTOModel> bankingAccounts =
        Provider.of<BankingAccountDTOProvider>(context).accounts;
    // FIXED: Use Acards instead of cards for active cards
    List<CardDtoModel> acards = Provider.of<CardDtoProvider>(context).Acards;

    return Scaffold(
      bottomNavigationBar: Bar(
        myIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Décharge de carte"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height + 1000,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40, right: 200),
                      child: Text(
                        "Compte a créditer ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: ExpansionTile(
                          title: ind1 != -1
                              ? Text("${bankingAccounts[ind1].type} | ${bankingAccounts[ind1].RIB}")
                              : Text("Cliquer pour séléctionner"),
                          children: [
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                itemCount: bankingAccounts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          ind1 = index;
                                        });
                                      },
                                      child: Container(
                                        width: 400,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20),
                                              child: Text("${bankingAccounts[index].type} | ${bankingAccounts[index].RIB}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 200),
                      child: Text(
                        "Banque émettrice",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: ExpansionTile(
                          title: _getBankSelectionTitle(),
                          children: [
                            _buildBankOption("UBA GABON", 0),
                            _buildBankOption("ORABANK GABON", 1),
                            _buildBankOption("ECOBANK GABON", 2),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 220),
                      child: Text(
                        "Carte a débiter",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: ExpansionTile(
                          title: ind2 != -1 && acards.isNotEmpty
                              ? Text("${acards[ind2].type} | ${acards[ind2].number}")
                              : Text("Cliquer pour séléctionner"),
                          children: [
                            SizedBox(
                              height: 300,
                              child: acards.isEmpty
                                  ? Center(
                                child: Text(
                                  "Aucune carte active disponible",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                                  : ListView.builder(
                                itemCount: acards.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.all(20),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          ind2 = index;
                                        });
                                      },
                                      child: Container(
                                        width: 400,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(left: 20),
                                              child: Text("${acards[index].type} | ${acards[index].number}"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 280, top: 20),
                      child: Text(
                        "Montant",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: montant,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "This field must not be null";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Cliquer pour saisir le montant",
                            suffixIcon: Padding(
                              padding: EdgeInsets.only(top: 10, right: 20),
                              child: Text(
                                "XAF",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    if (ind2 != -1 && acards.isNotEmpty)
                      Container(
                        width: 400,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Solde carte : ${acards[ind2].balance} XAF",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        if (ind1 != -1 && ind2 != -1 && ind3 != -1 && key.currentState!.validate()) {
                          if (acards[ind2].balance < int.parse(montant.text)) {
                            showNotEnough(context);
                          } else {
                            showRec(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Veuillez remplir tous les champs")),
                          );
                        }
                      },
                      child: Container(
                        width: 350,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Suivant",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}