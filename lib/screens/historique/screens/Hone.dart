import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/ClientDtoProvider.dart';
import 'package:pfe_banking_system/screens/Depot/model/OperateurModel.dart';
import 'package:pfe_banking_system/screens/Depot/provider/OperateurProvider.dart';
import 'package:pfe_banking_system/screens/historique/model/BankOpDTO.dart';
import 'package:pfe_banking_system/screens/historique/provider/BankOpDTOProvider.dart';
import 'package:pfe_banking_system/screens/historique/screens/Hthree.dart';
import 'package:pfe_banking_system/screens/historique/screens/Htwo.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
import '../../CodeVerif.dart';
import '../../CreationParticulier/model/BankingAccountDTOModel.dart';

class Hone extends StatefulWidget {
  int? id;
  Hone({super.key, this.id});

  @override
  State<Hone> createState() => _HoneState();
}

class _HoneState extends State<Hone> {
  String type = "";
  int ind = -1;
  int myIndex = 0;
  int ind1 = -1;
  int BId = -1;

  // Helper method to group transactions by date
  Map<String, List<BankOpDTO>> groupTransactionsByDate(List<BankOpDTO> transactions) {
    Map<String, List<BankOpDTO>> groupedTransactions = {};

    for (var transaction in transactions) {
      String dateKey = transaction.date; // You can format this as needed
      if (groupedTransactions.containsKey(dateKey)) {
        groupedTransactions[dateKey]!.add(transaction);
      } else {
        groupedTransactions[dateKey] = [transaction];
      }
    }

    return groupedTransactions;
  }

  // Helper method to format date for display
  String formatDateForDisplay(String date) {
    try {
      List<String> dateParts = date.split("-");
      if (dateParts.length >= 3) {
        int day = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);
        return "$day ${getMonthName(month)} $year";
      }
    } catch (e) {
      return date;
    }
    return date;
  }

  // Helper method to show "no transactions available" message
  Widget _buildNoTransactionsMessage(String transactionType) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height - 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20),
            Text(
              "Aucune transaction disponible",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600]
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Aucune $transactionType trouvée pour ce compte",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500]
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAccounts(BuildContext context) {
    List<BankingAccountDTOModel> bankingAccounts =
        Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 180, top: 20),
                    child: Text(
                      "Mes comptes ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Cliquez pour choisir le compte a afficher",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: bankingAccounts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(20),
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                ind1 = index;
                                BId = bankingAccounts[ind1].id!;
                              });

                              Navigator.pop(context);
                              await loadOperations("${bankingAccounts[ind1].RIB}");
                            },
                            child: Container(
                              width: 400,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${bankingAccounts[index].type} | ${bankingAccounts[index].RIB}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )
          );
        }
    );
  }

  void showFilter(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, right: 80),
                  child: Text(
                    "Filtrer votre recherche",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30, top: 20),
                  child: Text(
                    "Choisissez la tag qui correspond a votre recherche",
                    style: TextStyle(fontSize: 20, color: Colors.grey[500], fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 1),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      setState(() {
                        ind = 0;
                      });
                    },
                    child: Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, left: 20),
                        child: Text(
                          "Virements reçus",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 1),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      setState(() {
                        ind = 1;
                      });
                    },
                    child: Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, left: 20),
                        child: Text(
                          "Virements envoyées",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 1),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Provider.of<BankOpDTOProvider>(context, listen: false)
                          .getAllBankingOpsForBankAccountByType(BId, "deposit");
                      setState(() {
                        ind = 2;
                      });
                    },
                    child: Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, left: 20),
                        child: Text(
                          "Dépot",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 1),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Provider.of<BankOpDTOProvider>(context, listen: false)
                          .getAllBankingOpsForBankAccountByType(BId, "withdrawl");
                      setState(() {
                        ind = 3;
                      });
                    },
                    child: Container(
                      width: 400,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, left: 20),
                        child: Text(
                          "Retrait",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    Provider.of<BankOpDTOProvider>(context, listen: false).getAllBankingOpsForBankAccount(widget.id!);
    Provider.of<BankOpDTOProvider>(context, listen: false).getAllBankingOpsForBankAccountByType(widget.id!, type);
    loadOperations("");
    Provider.of<BankingAccountDTOProvider>(context, listen: false).getClientAssignedToBankingAccount(widget.id!);
    Provider.of<ClientDTOProvider>(context, listen: false).getClient(widget.id!);
    Provider.of<BankingAccountDTOProvider>(context, listen: false).getAllBankingAccountForClient(widget.id!);
    super.initState();
  }

  Future<void> loadOperations(String rib1) async {
    await Provider.of<BankOpDTOProvider>(context, listen: false).getAllBankingOperationsForBankAccountByRIB("${rib1}");
    await Provider.of<BankOpDTOProvider>(context, listen: false).getAllReceivedTransferForBankingAccountByRIB("${rib1}");
  }

  @override
  Widget build(BuildContext context) {
    List<BankOpDTO> operations = Provider.of<BankOpDTOProvider>(context).operations;
    List<BankOpDTO> operationsType = Provider.of<BankOpDTOProvider>(context).operationsType;
    ClientModelDTO? client = Provider.of<BankingAccountDTOProvider>(context).client;
    List<BankingAccountDTOModel> bankingAccounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;

    return Scaffold(
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Historique des opérations"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 30),
              child: Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 40),
                      child: InkWell(
                        child: Row(
                          children: [
                            ind1 == -1
                                ? Text(
                              "Selectionner un compte ",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            )
                                : Text(
                              "${bankingAccounts[ind1].type} | ${bankingAccounts[ind1].RIB}",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.keyboard_arrow_down_outlined, size: 30),
                          ],
                        ),
                        onTap: () {
                          showAccounts(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, right: 140),
                      child: ind1 == -1
                          ? Text(
                        "0 XAF",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF4A9E1F)),
                      )
                          : Text(
                        "${bankingAccounts[ind1].balance} XAF",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFF4A9E1F)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 70,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none
                          ),
                          prefixIcon: Icon(Icons.search),
                          hintText: "Rechercher",
                          suffixIcon: Icon(Icons.calendar_month, color: Colors.green)
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showFilter(context);
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(Icons.filter_alt_rounded),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
            ind == 0
                ? VirementsRecu()
                : ind == 1
                ? VirementsEnvoyees()
                : ind == 2
                ? Depot()
                : ind == 3
                ? Retrait()
                : Padding(
              padding: EdgeInsets.only(top: 200, left: 10),
              child: Text(
                "Selectionner un compte pour\n     vour les transactions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget VirementsRecu() {
    List<BankOpDTO> operationsReceived = Provider.of<BankOpDTOProvider>(context).operationsReceived;
    ClientModelDTO? client = Provider.of<BankingAccountDTOProvider>(context).client;
    ClientModelDTO? foundClient = Provider.of<ClientDTOProvider>(context).client;

    if (operationsReceived.isEmpty) {
      return _buildNoTransactionsMessage("virement reçu");
    }

    // Group transactions by date
    Map<String, List<BankOpDTO>> groupedTransactions = groupTransactionsByDate(operationsReceived);
    List<String> sortedDates = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a)); // Sort dates descending

    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height - 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (BuildContext context, int dateIndex) {
                String date = sortedDates[dateIndex];
                List<BankOpDTO> transactionsForDate = groupedTransactions[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        formatDateForDisplay(date),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    // Transactions for this date
                    ...transactionsForDate.map((operation) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Htwo()));
                        },
                        child: Container(
                          width: 420,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Column(
                                  children: [
                                    Text("${operation.date.split("-")[0]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400])),
                                    Text("${getMonthName(int.parse(operation.date[operation.date.indexOf("-") + 1]))}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400]))
                                  ],
                                ),
                              ),
                              Text(" |", style: TextStyle(fontSize: 45, color: Colors.grey[400])),
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Virement. reçu", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text("${client?.firstName} ${client?.lastName}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 60),
                              Text(" + ${operation.montant}", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
                              SizedBox(width: 20),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget VirementsEnvoyees() {
    List<BankOpDTO> operationsType = Provider.of<BankOpDTOProvider>(context).operationsByRIB;

    if (operationsType.isEmpty) {
      return _buildNoTransactionsMessage("virement envoyé");
    }

    // Group transactions by date
    Map<String, List<BankOpDTO>> groupedTransactions = groupTransactionsByDate(operationsType);
    List<String> sortedDates = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height - 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (BuildContext context, int dateIndex) {
                String date = sortedDates[dateIndex];
                List<BankOpDTO> transactionsForDate = groupedTransactions[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        formatDateForDisplay(date),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    // Transactions for this date
                    ...transactionsForDate.map((operation) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Htwo()));
                        },
                        child: Container(
                          width: 420,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Column(
                                  children: [
                                    Text("${operation.date.split("-")[0]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400])),
                                    Text("${getMonthName(int.parse(operation.date[operation.date.indexOf("-") + 1]))}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400]))
                                  ],
                                ),
                              ),
                              Text(" |", style: TextStyle(fontSize: 45, color: Colors.grey[400])),
                              Padding(
                                padding: EdgeInsets.only(top: 12, left: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 20),
                                          child: Text("Virement A ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text("${operation.namecreditnum == null ? "" : operation.namecreditnum}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 60),
                              Text("- ${operation.montant}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget Depot() {
    List<BankOpDTO> operationsType = Provider.of<BankOpDTOProvider>(context).operationsType;
    List<BankingAccountDTOModel> bankingAccounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;

    if (operationsType.isEmpty) {
      return _buildNoTransactionsMessage("dépôt");
    }

    // Group transactions by date
    Map<String, List<BankOpDTO>> groupedTransactions = groupTransactionsByDate(operationsType);
    List<String> sortedDates = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height - 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (BuildContext context, int dateIndex) {
                String date = sortedDates[dateIndex];
                List<BankOpDTO> transactionsForDate = groupedTransactions[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        formatDateForDisplay(date),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    // Transactions for this date
                    ...transactionsForDate.map((operation) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Htwo()));
                        },
                        child: Container(
                          width: 420,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Column(
                                  children: [
                                    Text("${operation.date.split("-")[0]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400])),
                                    Text("${getMonthName(int.parse(operation.date[operation.date.indexOf("-") + 1]))}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400]))
                                  ],
                                ),
                              ),
                              Text(" |", style: TextStyle(fontSize: 45, color: Colors.grey[400])),
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Column(
                                  children: [
                                    operation.operateurName == null
                                        ? Text("Dépot via         ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                        : Text("Dépot via ${operation.operateurName}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding: EdgeInsets.only(right: 70),
                                      child: Text("${ind1 != -1 ? bankingAccounts[ind1].RIB.substring(15) : ''}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Text("+ ${operation.montant}  XAF", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget Retrait() {
    List<BankOpDTO> operationsType = Provider.of<BankOpDTOProvider>(context).operationsType;
    List<BankingAccountDTOModel> bankingAccounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;

    if (operationsType.isEmpty) {
      return _buildNoTransactionsMessage("retrait");
    }

    // Group transactions by date
    Map<String, List<BankOpDTO>> groupedTransactions = groupTransactionsByDate(operationsType);
    List<String> sortedDates = groupedTransactions.keys.toList()..sort((a, b) => b.compareTo(a));

    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height - 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Column(
        children: [
          SizedBox(height: 40),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: sortedDates.length,
              itemBuilder: (BuildContext context, int dateIndex) {
                String date = sortedDates[dateIndex];
                List<BankOpDTO> transactionsForDate = groupedTransactions[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        formatDateForDisplay(date),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    // Transactions for this date
                    ...transactionsForDate.map((operation) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Htwo()));
                        },
                        child: Container(
                          width: 420,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Column(
                                  children: [
                                    Text("${operation.date.split("-")[0]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400])),
                                    Text("${getMonthName(int.parse(operation.date[operation.date.indexOf("-") + 1]))}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.grey[400]))
                                  ],
                                ),
                              ),
                              Text(" |", style: TextStyle(fontSize: 45, color: Colors.grey[400])),
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 10),
                                child: Column(
                                  children: [
                                    operation.operateurName == null
                                        ? Text("Retrait via", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
                                        : Text("Retrait via ${operation.operateurName}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding: EdgeInsets.only(right: 50),
                                      child: Text("${ind1 != -1 ? bankingAccounts[ind1].RIB.substring(15) : ''}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Text("- ${operation.montant}  XAF", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                              SizedBox(width: 5),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Invalid month';
    }
  }
}