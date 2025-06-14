import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/CodeVerifRetraitMise.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
import '../../CodeVerif.dart';
import '../../OTP/provider/OtpProvider.dart';

class Reten extends StatefulWidget {
  const Reten({super.key});

  @override
  State<Reten> createState() => _RetenState();
}

class _RetenState extends State<Reten> {
  int ind = -1;
  var key = GlobalKey<FormState>();
  TextEditingController montant = TextEditingController();
  TextEditingController creditnum = TextEditingController();
  TextEditingController namecreditnum = TextEditingController();
  String? otpCode;

  void showConfirmationDialog(BuildContext context, String montant, String BankId, String creditnum, String namecreditnum, BankingAccountDTOModel selectedAccount) {
    // Calculate fees (example: 2% of amount or minimum 1000 XAF)
    double amount = double.parse(montant);
    double fees = amount * 0.02 < 1000 ? 1000 : amount * 0.02;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return SingleChildScrollView(
            child: Container(
              height: 500,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text(
                    "Récapitulatif de la mise a disposition",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Compte a débiter      ${selectedAccount.RIB}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Bénéficiaire                                      $namecreditnum",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Numéro bénéficiaire                    $creditnum",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Montant                                       ${amount.toStringAsFixed(0)} XAF",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "Frais                                              ${fees.toStringAsFixed(0)} XAF",
                    style: TextStyle(fontSize: 20),
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
                                    builder: (context) => Codeverifretraitmise(
                                      montant: montant,
                                      BankId: BankId,
                                      creditnum: creditnum,
                                      namecreditnum: namecreditnum,
                                      otpCode: otpCode,
                                      accountRIB: selectedAccount.RIB,
                                      accountType: selectedAccount.type,
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
    showModalBottomSheet(context: context, builder: (BuildContext) {
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
    int myIndex = 0;

    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context).accounts;
    return Form(
        key: key,
        child: Scaffold(
            bottomNavigationBar: Bar(myIndex: myIndex, onTap: (ind) {
              setState(() {
                myIndex = ind;
              });
            }),
            backgroundColor: Color(0xFFF2F2F2),
            appBar: AppBar(
              backgroundColor: Color(0xFFF2F2F2),
              title: Text("Agence"),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
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
                        Padding(
                          padding: EdgeInsets.only(right: 160, top: 80),
                          child: Text(
                            "Compte a débiter",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 400,
                          decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: ExpansionTile(
                              title: ind == -1
                                  ? Text("Cliquer pour sélectionner")
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
                                                color: Color(0xFFF7F7F7),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 20),
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
                        ),

                        Padding(
                          padding: EdgeInsets.only(right: 280, top: 40),
                          child: Text(
                            "Montant",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: 400,
                            height: 100,
                            decoration: BoxDecoration(
                                color: Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 400,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF7F7F7),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                      child: TextFormField(
                                        controller: montant,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "This field must not be null";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide.none
                                          ),
                                          hintText: "Cliquer pour saisir le montant",
                                          hintStyle: TextStyle(fontSize: 16),
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(top: 10, right: 20),
                                            child: Text(
                                              "XAF",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                ),
                                Container(
                                  width: 400,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF4A9E1F),
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Center(
                                    child: Text(
                                      ind == -1
                                          ? "Solde disponible : -- XAF"
                                          : "Solde disponible : ${accounts[ind].balance.toStringAsFixed(0)} XAF",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 190, top: 40),
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
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                              child: TextFormField(
                                controller: namecreditnum,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field must not be null";
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    hintText: "Nom et prénom"
                                ),
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 170, top: 20),
                          child: Text(
                            "Numéro du bénéficiaire",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 400,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                              child: TextFormField(
                                controller: creditnum,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field must not be null";
                                  }
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    hintText: "0 0 0 0 0 0 0 0"
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 40),
                        InkWell(
                          onTap: () {
                            if (key.currentState!.validate() && ind != -1) {
                              if (accounts[ind].balance > int.parse(montant.text)) {
                                showConfirmationDialog(
                                    context,
                                    montant.text,
                                    accounts[ind].id.toString(),
                                    creditnum.text,
                                    namecreditnum.text,
                                    accounts[ind] // Pass the selected account
                                );
                              } else {
                                showNotEnough(context);
                              }
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 50,
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
                  )
                ],
              ),
            )
        ));
  }
}