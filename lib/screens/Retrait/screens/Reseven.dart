import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/CodeVerifRetraitMobile.dart';
import 'package:provider/provider.dart';

import '../../CodeVerif.dart';
import '../../CreationParticulier/model/BankingAccountDTOModel.dart';
import '../../CreationParticulier/provider/BankingAccountDTOProvider.dart';
import '../../Depot/model/OperateurModel.dart';
import '../../Depot/provider/OperateurProvider.dart';
import '../../OTP/provider/OtpProvider.dart';

class Reseven extends StatefulWidget {
  const Reseven({super.key});

  @override
  State<Reseven> createState() => _ResevenState();
}

class _ResevenState extends State<Reseven> {
  int ind = -1;
  int inde = -1;
  var key = GlobalKey<FormState>();
  String? otpCode;
  TextEditingController montant = TextEditingController();
  TextEditingController creditnum = TextEditingController();
  TextEditingController namecreditnum = TextEditingController();

  void showConfirmationDialog(
      BuildContext context,
      String montant,
      String OpId,
      String BankId,
      String creditnum,
      String namecreditnum,
      List<BankingAccountDTOModel> accounts,
      List<OperateurModel> operateurs
      ) {
    // Get the selected account and operator data
    BankingAccountDTOModel selectedAccount = accounts[inde];
    OperateurModel selectedOperator = operateurs[ind];

    // Calculate commission (you can adjust this logic based on your business rules)
    double amount = double.parse(montant);
    double commission = amount * 0.02; // 2% commission example
    double totalCost = amount + commission;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 800,
            width: 500,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    "Récapitulatif",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                _buildSummaryRow("Compte à débiter", selectedAccount.RIB ?? "N/A"),
                _buildDivider(),

                _buildSummaryRow("Type de compte", selectedAccount.type ?? "N/A"),
                _buildDivider(),

                _buildSummaryRow("Montant", "$montant XAF"),
                _buildDivider(),

                _buildSummaryRow("Canal", "Mobile Money"),
                _buildDivider(),

                _buildSummaryRow("Opérateur", selectedOperator.name ?? "N/A"),
                _buildDivider(),

                _buildSummaryRow("Numéro à créditer", creditnum),
                _buildDivider(),

                _buildSummaryRow("Propriétaire", namecreditnum),
                _buildDivider(),

                _buildSummaryRow("Commission TTC", "${commission.toStringAsFixed(0)} XAF"),
                _buildDivider(),

                _buildSummaryRow("Coût de transaction TTC", "0 XAF"),
                _buildDivider(),

                _buildSummaryRow("Total à débiter", "${totalCost.toStringAsFixed(0)} XAF", isTotal: true),

                Spacer(),

                Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Annuler",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: () async {
                          await Provider.of<OtpProvider>(context, listen: false)
                              .generateOtp("+21646491524");
                          otpCode = await Provider.of<OtpProvider>(context, listen: false)
                              .otpCode;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Codeverifretraitmobile(
                                montant: montant,
                                opId: OpId,
                                BankId: BankId,
                                creditnum: creditnum,
                                namecreditnum: namecreditnum,
                                otpCode: otpCode,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "Valider",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
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
      },
    );
  }

  // Helper method to build summary rows
  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 20 : 18,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 20 : 18,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? Color(0xFF4A9E1F) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build divider
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
    );
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
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text(
                    "Insufficient Balance",
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
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Text(
                                "Cancel",
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
                                "Deposit",
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
        }
    );
  }

  @override
  void initState() {
    Provider.of<OperateurProvider>(context, listen: false).getAllOperatuers();
    Provider.of<BankingAccountDTOProvider>(context, listen: false).getAllBankingAccountForClient(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OperateurModel> operateurs = Provider.of<OperateurProvider>(context).operateurs;
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context).accounts;

    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text("Retrait"),
          centerTitle: true,
          backgroundColor: Color(0xFFF2F2F2),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  "           Vers quel compte\n     souhaitez-vous faire votre\n                    retrait ?",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height + 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 200, top: 50),
                        child: Text(
                          "Compte a débiter",
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
                        child: Center(
                          child: ExpansionTile(
                            title: inde == -1
                                ? Text("Cliquer pour selectionner")
                                : Text("${accounts[inde].type} : ${accounts[inde].RIB}"),
                            children: [
                              SizedBox(
                                height: 300,
                                child: ListView.builder(
                                    itemCount: accounts.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            inde = index;
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
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
                                                    padding: EdgeInsets.all(15),
                                                    child: Text("${accounts[index].type} : ${accounts[index].RIB}"),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                      );
                                    }
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 260, top: 20),
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
                              width: 400,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: montant,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "This field must not be null";
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
                                      padding: EdgeInsets.only(top: 10, right: 20),
                                      child: Text(
                                        "XAF",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Dynamic balance display
                            Container(
                              width: 400,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: Text(
                                  inde == -1
                                      ? "Available Balance: Select account first"
                                      : "Available Balance: ${accounts[inde].balance.toStringAsFixed(0)} XAF",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, right: 250),
                        child: Text(
                          "Opérateur",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        width: 400,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF2F2F2),
                        ),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: operateurs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      ind = index;
                                    });
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: ind == index ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${operateurs[index].name}",
                                        style: TextStyle(
                                            color: ind == index ? Colors.white : Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, right: 200),
                        child: Text(
                          "Numéro a créditer",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: 70,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFF2F2F2),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: creditnum,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field must not be null";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "00 00 00 00",
                              ),
                            ),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30, right: 160),
                        child: Text(
                          "Propriétaire du numéro",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          height: 70,
                          width: 400,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xFFF2F2F2),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: namecreditnum,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field must not be null";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "Saissez le numéro pour voir le nom",
                              ),
                            ),
                          )
                      ),
                      SizedBox(height: 40),
                      InkWell(
                        onTap: () {
                          if (key.currentState!.validate() && ind != -1 && inde != -1) {
                            if (accounts[inde].balance >= double.parse(montant.text)) {
                              showConfirmationDialog(
                                  context,
                                  montant.text,
                                  operateurs[ind].id.toString(),
                                  accounts[inde].id.toString(),
                                  creditnum.text,
                                  namecreditnum.text,
                                  accounts,
                                  operateurs
                              );
                            } else {
                              showNotEnough(context);
                            }
                          }
                        },
                        child: Container(
                          width: 350,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              "Continuer",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              ),
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
        )
    );
  }
}