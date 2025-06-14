import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Depot/model/OperateurModel.dart';
import 'package:pfe_banking_system/screens/Depot/provider/OperateurProvider.dart';
import 'package:pfe_banking_system/screens/Depot/screens/CodeVerifDepot.dart';
import 'package:pfe_banking_system/screens/Depot/screens/CodeVerifMobileDepot.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dfive.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dsix.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // Add this import for number formatting

import '../../OTP/provider/OtpProvider.dart';
import '../../Retrait/provider/WithdrawlOpProvider.dart';
import '../provider/BankingOpProvider.dart';

class Dfour extends StatefulWidget {
  const Dfour({super.key});

  @override
  State<Dfour> createState() => _DfourState();
}

class _DfourState extends State<Dfour> {
  int ind = -1;
  int inde = -1;
  var key = GlobalKey<FormState>();
  String? BankingOpId;
  DateTime now = DateTime.now();
  TextEditingController montant = TextEditingController();
  TextEditingController creditnum = TextEditingController();

  // Helper method to format numbers with spaces
  String formatAmount(double amount) {
    final formatter = NumberFormat('#,###', 'fr_FR');
    return formatter.format(amount).replaceAll(',', ' ');
  }

  // Helper method to get available balance
  String getAvailableBalance(List<BankingAccountDTOModel> accounts) {
    if (inde == -1 || inde >= accounts.length) {
      return "0";
    }
    // Assuming the account has a balance property
    // If not, you might need to adjust this based on your model
    return formatAmount(accounts[inde].balance ?? 0);
  }

  void showConfirmationDialog(
      BuildContext context,
      String montant,
      String OpId,
      String BankId,
      String creditnum,
      List<BankingAccountDTOModel> accounts,
      List<OperateurModel> operateurs,
      ) {
    String? BankOpId;
    String? otpCode;

    // Get selected account and operator details
    String selectedAccountRIB = inde != -1 ? accounts[inde].RIB ?? "N/A" : "N/A";
    String selectedAccountType = inde != -1 ? accounts[inde].type ?? "N/A" : "N/A";
    String selectedOperatorName = ind != -1 ? operateurs[ind].name ?? "N/A" : "N/A";

    // Calculate commission (you might want to make this dynamic based on amount/operator)
    double commissionAmount = 119.0; // This should be calculated based on your business logic
    double transactionCost = 0.0;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 800,
            width: 500,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 30),
                Text(
                  "Récapitulatif",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 30),

                // Account to debit
                _buildSummaryRow("Compte à débiter", "$selectedAccountType: $selectedAccountRIB"),

                // Amount
                _buildSummaryRow("Montant", "${formatAmount(double.tryParse(montant) ?? 0)} XAF"),

                // Channel
                _buildSummaryRow("Canal", "Mobile Money"),

                // Operator
                _buildSummaryRow("Opérateur", selectedOperatorName),

                // Number to credit
                _buildSummaryRow("Numéro à créditer", _formatPhoneNumber(creditnum)),

                // Owner (assuming it's the same as the number for now)
                _buildSummaryRow("Propriétaire", _formatPhoneNumber(creditnum)),

                // Commission
                _buildSummaryRow("Commission TTC", "${formatAmount(commissionAmount)} XAF"),

                // Transaction cost
                _buildSummaryRow("Coût de transaction TTC", "${formatAmount(transactionCost)} XAF"),

                Padding(
                  padding: EdgeInsets.only(top: 70, left: 60),
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .setMontant(montant: int.parse(montant));
                          Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .setDate(date: "${now.day}-${now.month}-${now.year}");
                          Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .setStatus();
                          Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .setCreditNum(creditnum: creditnum);
                          Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .setNameCreditNum(namecreditnum: selectedOperatorName);
                          await Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .saveWithdrawlOp();
                          final WithdrawlOp = await Provider.of<WithdrawlOpProvider>(
                              context, listen: false).withdrawlOp;
                          if (WithdrawlOp != null) {
                            setState(() {
                              BankOpId = WithdrawlOp.id.toString();
                            });
                          }

                          await Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .addOperateurToWithdarwlOp(BankOpId!, OpId);
                          await Provider.of<WithdrawlOpProvider>(context, listen: false)
                              .addWithdarwlOpToBankingAccount(BankOpId!, BankId);
                          await Provider.of<OtpProvider>(context, listen: false)
                              .generateOtp("+21694399332");
                          otpCode = await Provider.of<OtpProvider>(context, listen: false)
                              .otpCode;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Codeverifmobiledepot(
                                otpCode: otpCode,
                                amount: montant,
                                operatorName: selectedOperatorName,
                                creditNumber: creditnum,
                                accountType: selectedAccountType,
                                accountRIB: selectedAccountRIB,
                              ),
                            ),
                          );
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
                              "Valider",
                              style: TextStyle(
                                fontSize: 20,
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

  Widget _buildSummaryRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 16)),
            Flexible(
              child: Text(
                value,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  String _formatPhoneNumber(String phoneNumber) {
    // Format phone number to add spaces (e.g., "077 46 47 58")
    if (phoneNumber.length >= 8) {
      return phoneNumber.replaceAllMapped(
        RegExp(r'(\d{2})(\d{2})(\d{2})(\d{2})'),
            (Match m) => '${m[1]} ${m[2]} ${m[3]} ${m[4]}',
      );
    }
    return phoneNumber;
  }

  @override
  void initState() {
    Provider.of<OperateurProvider>(context, listen: false).getAllOperatuers();
    Provider.of<BankingAccountDTOProvider>(context, listen: false)
        .getAllBankingAccountForClient(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<OperateurModel> operateurs =
        Provider.of<OperateurProvider>(context).operateurs;
    List<BankingAccountDTOModel> accounts =
        Provider.of<BankingAccountDTOProvider>(context).accounts;

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text("Depot"),
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
                "           Vers quel compte\n     souhaitez-vous faire votre\n                versement ?",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height + 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 200, top: 50),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: ExpansionTile(
                          title: inde == -1
                              ? Text("Cliquer pour sélectionner")
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
                                            Text("${accounts[index].type} : ${accounts[index].RIB}"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
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
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: montant,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field must not be null";
                                  }
                                  if (double.tryParse(value) == null) {
                                    return "Please enter a valid amount";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
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
                          Container(
                            width: 400,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Solde disponible : ${getAvailableBalance(accounts)} XAF",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
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
                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    ind = index;
                                  });
                                },
                                child: Container(
                                  width: 200,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: ind == index
                                        ? Color(0xFF4A9E1F)
                                        : Color(0xFFF2F2F2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text("${operateurs[index].name}"),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30, right: 200),
                      child: Text(
                        "Numéro à créditer",
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
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "00 00 00 00",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        if (key.currentState!.validate()) {
                          if (inde == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Veuillez sélectionner un compte")),
                            );
                            return;
                          }
                          if (ind == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Veuillez sélectionner un opérateur")),
                            );
                            return;
                          }
                          showConfirmationDialog(
                            context,
                            montant.text,
                            operateurs[ind].id.toString(),
                            accounts[inde].id.toString(),
                            creditnum.text,
                            accounts,
                            operateurs,
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
                            "Continuer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
      ),
    );
  }
}