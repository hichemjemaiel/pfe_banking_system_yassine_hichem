import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/CodeVerifRetraitDigiCode.dart';
import 'package:provider/provider.dart';

import '../../CodeVerif.dart';
import '../../OTP/provider/OtpProvider.dart';

class Renine extends StatefulWidget {
  const Renine({super.key});

  @override
  State<Renine> createState() => _RenineState();
}

class _RenineState extends State<Renine> {
  int ind = -1;
  var key = GlobalKey<FormState>();
  String? otpCode;
  TextEditingController montant = TextEditingController();
  TextEditingController namecreditnum = TextEditingController();
  TextEditingController motif = TextEditingController();

  // Calculate transaction fee (you can modify this logic as needed)
  double calculateFee(double amount) {
    // Example fee calculation - 1.5% of amount with minimum 1000 XAF
    double fee = amount * 0.015;
    return fee < 1000 ? 1000 : fee;
  }

  void showConfirmationDialog(BuildContext context, String montant, String BankId, String namecreditnum, BankingAccountDTOModel selectedAccount) {
    double amount = double.parse(montant);
    double fee = calculateFee(amount);

    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return SingleChildScrollView(
            child: Container(
              height: 800,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Récapitulatif",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Compte à débiter    ${selectedAccount.RIB}",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Montant                                      ${amount.toStringAsFixed(0)} XAF",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Bénéficiaire                       $namecreditnum",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Frais                                               ${fee.toStringAsFixed(0)} XAF",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Total à débiter                              ${(amount + fee).toStringAsFixed(0)} XAF",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 70, left: 60),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21646491524");
                            otpCode = await Provider.of<OtpProvider>(context, listen: false).otpCode;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Codeverifretraitdigicode(
                                      montant: montant,
                                      BankId: BankId,
                                      namecreditnum: namecreditnum,
                                      otpCode: otpCode,
                                      motif: motif.text,
                                      compteDebiteur: selectedAccount.RIB,
                                      frais: fee.toStringAsFixed(0),
                                    )
                                )
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text(
                                "Valider",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
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
            ),
          );
        });
  }

  void showNotEnough(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return Container(
              width: 450,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Solde insuffisant",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 65, top: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Annuler",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            // Navigate to deposit screen
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text(
                                "Déposer",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
          );
        });
  }

  @override
  void initState() {
    Provider.of<BankingAccountDTOProvider>(context, listen: false).getAllBankingAccountForClient(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context).accounts;

    return Form(
        key: key,
        child: Scaffold(
            backgroundColor: Color(0xFFF2F2F2),
            appBar: AppBar(
              backgroundColor: Color(0xFFF2F2F2),
              title: Text("Retrait"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "             Depuis quel compte\nsouhaitez-vous faire votre retrait ?",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height + 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.only(top: 40, right: 180),
                          child: Text(
                            "Compte à débiter",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: ExpansionTile(
                            title: ind == -1
                                ? Text("Cliquez pour sélectionner")
                                : Text("${accounts[ind].type} | ${accounts[ind].RIB}"),
                            children: [
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                    itemCount: accounts.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            ind = index;
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 30),
                                          child: Container(
                                            width: 400,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 20, top: 25),
                                              child: Text("${accounts[index].type} | ${accounts[index].RIB}"),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 280, top: 20),
                          child: Text(
                            "Montant",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: TextFormField(
                                    controller: montant,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce champ ne peut pas être vide";
                                      }
                                      if (double.tryParse(value) == null) {
                                        return "Veuillez entrer un montant valide";
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide.none
                                        ),
                                        hintText: "Cliquer pour saisir le montant",
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "XAF",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 400,
                                decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: Text(
                                    ind == -1
                                        ? "Solde disponible : Sélectionnez un compte"
                                        : "Solde disponible : ${accounts[ind].balance.toStringAsFixed(0)} XAF",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.only(right: 200, top: 40),
                          child: Text(
                            "Nom du bénéficiaire",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                            width: 400,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: namecreditnum,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Ce champ ne peut pas être vide";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    hintText: "Nom et prénom"
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(top: 20, right: 320),
                          child: Text(
                            "Motif",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 120,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: TextField(
                              controller: motif,
                              maxLines: 3,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "Cliquez pour saisir votre motif",
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            if (key.currentState!.validate() && ind != -1) {
                              double amount = double.parse(montant.text);
                              double fee = calculateFee(amount);
                              double totalAmount = amount + fee;

                              if (accounts[ind].balance >= totalAmount) {
                                showConfirmationDialog(
                                    context,
                                    montant.text,
                                    accounts[ind].id.toString(),
                                    namecreditnum.text,
                                    accounts[ind]
                                );
                              } else {
                                showNotEnough(context);
                              }
                            } else if (ind == -1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Veuillez sélectionner un compte"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text(
                                "Continuer",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
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
            )
        ));
  }
}