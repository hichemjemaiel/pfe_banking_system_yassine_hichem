import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Depot/model/CardDto.dart';
import 'package:pfe_banking_system/screens/Depot/provider/CardDtoProvider.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/provider/RechargeCardProvider.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rctthree.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
import '../../CodeVerif.dart';
import '../../OTP/provider/OtpProvider.dart';

class Rcttwo extends StatefulWidget {
  final int? id;
  const Rcttwo({super.key, this.id});

  @override
  State<Rcttwo> createState() => _RcttwoState();
}

class _RcttwoState extends State<Rcttwo> {
  int ind = 0;
  int ind1 = -1;
  int ind2 = -1;
  int ind3 = -1;
  int myIndex = 0;
  String? rechargeId;
  String? otpCode;
  String? card;
  String? rib;
  var key = GlobalKey<FormState>();
  var key2 = GlobalKey<FormState>();
  TextEditingController nom = TextEditingController();
  TextEditingController montant = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Only load data if widget.id is not null
    if (widget.id != null) {
      _loadData();
    } else {
      // Handle the case where id is null
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Erreur: ID utilisateur manquant"),
            backgroundColor: Colors.red,
          ),
        );
      });
    }
  }

  Future<void> _loadData() async {
    try {
      // Double check that widget.id is not null before using it
      if (widget.id == null) {
        print("Error: widget.id is null in _loadData");
        return;
      }

      await Provider.of<BankingAccountDTOProvider>(context, listen: false)
          .getAllBankingAccountForClient(widget.id!);

      await Provider.of<CardDtoProvider>(context, listen: false)
          .getAllCardsToClientActive(widget.id!);

      print("Data loaded - Active cards: ${Provider
          .of<CardDtoProvider>(context, listen: false)
          .Acards
          .length}");
    } catch (e) {
      print("Error loading data: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors du chargement des données: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void showRec(BuildContext context) {
    List<BankingAccountDTOModel> bankingAccounts =
        Provider
            .of<BankingAccountDTOProvider>(context, listen: false)
            .accounts;
    List<CardDtoModel> acards =
        Provider
            .of<CardDtoProvider>(context, listen: false)
            .Acards;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 720,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Récapitulatif",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                Text("Compte a débiter         ${ind1 != -1
                    ? bankingAccounts[ind1].RIB
                    : 'N/A'}", style: const TextStyle(fontSize: 20)),
                const Text(
                    "----------------------------------------------------------------",
                    style: TextStyle(fontSize: 20)),
                Text("Carte a créditer          ${ind2 != -1
                    ? '**** **** **** ${acards[ind2].number.substring(
                    acards[ind2].number.length - 4)}'
                    : 'N/A'}", style: const TextStyle(fontSize: 20)),
                const Text(
                    "----------------------------------------------------------------",
                    style: TextStyle(fontSize: 20)),
                Text(
                    "Banque émettrice            ${_getBankName(
                        ind3)}", style: const TextStyle(fontSize: 20)),
                const Text(
                    "----------------------------------------------------------------",
                    style: TextStyle(fontSize: 20)),
                Text("Nom du porteur                   ${nom.text}",
                    style: const TextStyle(fontSize: 20)),
                const Text(
                    "----------------------------------------------------------------",
                    style: TextStyle(fontSize: 20)),
                Text(
                    "Montant                                 ${montant.text} XAF",
                    style: const TextStyle(fontSize: 20)),
                const Text(
                    "----------------------------------------------------------------",
                    style: TextStyle(fontSize: 20)),
                const Text(
                    "Frais                                         800 XAF",
                    style: TextStyle(fontSize: 20)),
                const SizedBox(height: 30),
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
                        child: const Center(
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
                          card = acards[ind2].id.toString();
                          rib = bankingAccounts[ind1].RIB;
                        });

                        await Provider.of<OtpProvider>(context, listen: false)
                            .generateOtp("+21694399332");
                        otpCode = Provider
                            .of<OtpProvider>(context, listen: false)
                            .otpCode;

                        if (mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Rctthree(
                                    debitRib: rib!,
                                    nom: nom.text,
                                    montant: montant.text,
                                    card: card!,
                                    otpCode: otpCode,
                                    ind3: ind3,
                                  ),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 200,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
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
                    ),
                  ],
                )
              ],
            ),
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
              const SizedBox(height: 50),
              const Text(
                "No enough assets",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 65, top: 20),
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
                        child: const Center(
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
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // Navigate to deposit screen
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            "Deposer",
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

  @override
  Widget build(BuildContext context) {
    // Check if widget.id is null and show error state
    if (widget.id == null) {
      return Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),
          title: const Text("Recharger de carte"),
          centerTitle: true,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text(
                "Erreur: ID utilisateur manquant",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    List<BankingAccountDTOModel> bankingAccounts =
        Provider
            .of<BankingAccountDTOProvider>(context)
            .accounts;
    List<CardDtoModel> acards = Provider
        .of<CardDtoProvider>(context)
        .Acards;

    return Scaffold(
      bottomNavigationBar: Bar(
        myIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text("Recharger de carte"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height + 1000,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ind == 1 ? tiers(context) : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40, left: 30),
                            child: Container(
                              width: 340,
                              height: 70,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ind = 0;
                                      });
                                    },
                                    child: Container(
                                      width: 170,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: ind == 0
                                            ? const Color(0xFF4A9E1F)
                                            : const Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Ma carte",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        ind = 1;
                                      });
                                    },
                                    child: Container(
                                      width: 170,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: ind == 1
                                            ? const Color(0xFF4A9E1F)
                                            : const Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Un tiers",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40, right: 200),
                      child: Text(
                        "Compte a débiter ",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: ExpansionTile(
                          title: ind1 != -1 && bankingAccounts.isNotEmpty
                              ? Text("${bankingAccounts[ind1]
                              .type} | ${bankingAccounts[ind1].RIB}")
                              : const Text("Cliquer pour séléctionner"),
                          children: [
                            SizedBox(
                              height: 300,
                              child: bankingAccounts.isEmpty
                                  ? const Center(
                                child: Text(
                                  "Aucun compte disponible",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                                  : ListView.builder(
                                itemCount: bankingAccounts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20),
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
                                          color: const Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                        child: Row(
                                          children: [
                                            Text("${bankingAccounts[index]
                                                .type} | ${bankingAccounts[index]
                                                .RIB}"),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20, right: 200),
                      child: Text(
                        "Banque émettrice",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20, right: 220),
                      child: Text(
                        "Carte a créditer",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: ExpansionTile(
                          title: ind2 != -1 && acards.isNotEmpty
                              ? Text(
                              "${acards[ind2].type} | ${acards[ind2].number}")
                              : const Text("Cliquer pour séléctionner"),
                          children: [
                            SizedBox(
                              height: 300,
                              child: acards.isEmpty
                                  ? const Center(
                                child: Text(
                                  "Aucune carte active disponible",
                                  style: TextStyle(fontSize: 16),
                                ),
                              )
                                  : ListView.builder(
                                itemCount: acards.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20),
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
                                          color: const Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.circular(
                                              20),
                                        ),
                                        child: Row(
                                          children: [
                                            Text("${acards[index]
                                                .type} | ${acards[index]
                                                .number}")
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20, right: 200),
                      child: Text(
                        "Nom du porteur",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: nom,
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
                            hintText: "Cliquer pour saisir le nom",
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 270, top: 20),
                      child: Text(
                        "Montant",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(10),
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
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "50 000",
                                  suffixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, right: 20),
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
                              color: const Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Solde disponible : ${ind1 != -1 &&
                                    bankingAccounts.isNotEmpty
                                    ? bankingAccounts[ind1].balance
                                    : 0} XAF",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    InkWell(
                      onTap: () {
                        if (ind1 != -1 && ind2 != -1 && ind3 != -1 &&
                            key.currentState!.validate()) {
                          if (bankingAccounts.isNotEmpty &&
                              bankingAccounts[ind1].balance <
                                  int.parse(montant.text)) {
                            showNotEnough(context);
                          } else {
                            showRec(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(
                                "Veuillez remplir tous les champs")),
                          );
                        }
                      },
                      child: Container(
                        width: 350,
                        height: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
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

  Widget _getBankSelectionTitle() {
    switch (ind3) {
      case 0:
        return const Text("UBA GABON");
      case 1:
        return const Text("ORABANK GABON");
      case 2:
        return const Text("ECOBANK GABON");
      default:
        return const Text("Cliquer pour séléctionner");
    }
  }

  Widget _buildBankOption(String bankName, int index) {
    return Padding(
      padding: const EdgeInsets.all(20),
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
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Text(bankName),
            ],
          ),
        ),
      ),
    );
  }

  Widget tiers(BuildContext context) {
    List<BankingAccountDTOModel> bankingAccounts =
        Provider
            .of<BankingAccountDTOProvider>(context, listen: false)
            .accounts;
    List<CardDtoModel> acards = Provider
        .of<CardDtoProvider>(context, listen: false)
        .Acards;

    return Form(
      key: key2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30),
                  child: Container(
                    width: 340,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              ind = 0;
                            });
                          },
                          child: Container(
                            width: 170,
                            height: 70,
                            decoration: BoxDecoration(
                              color: ind == 0
                                  ? const Color(0xFF4A9E1F)
                                  : const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Ma carte",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              ind = 1;
                            });
                          },
                          child: Container(
                            width: 170,
                            height: 70,
                            decoration: BoxDecoration(
                              color: ind == 1
                                  ? const Color(0xFF4A9E1F)
                                  : const Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Un tiers",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40, right: 200),
            child: Text(
              "Compte a débiter ",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: ExpansionTile(
                title: ind1 != -1 && bankingAccounts.isNotEmpty
                    ? Text(
                    "${bankingAccounts[ind1].type} | ${bankingAccounts[ind1]
                        .RIB}")
                    : const Text("Cliquer pour séléctionner"),
                children: [
                  SizedBox(
                    height: 300,
                    child: bankingAccounts.isEmpty
                        ? const Center(
                      child: Text(
                        "Aucun compte disponible",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                        : ListView.builder(
                      itemCount: bankingAccounts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
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
                                color: const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text("${bankingAccounts[index]
                                      .type} | ${bankingAccounts[index].RIB}"),
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
          const Padding(
            padding: EdgeInsets.only(top: 20, right: 200),
            child: Text(
              "Banque émettrice",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
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
          const Padding(
            padding: EdgeInsets.only(top: 20, right: 220),
            child: Text(
              "Carte a créditer",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: ExpansionTile(
                title: ind2 != -1 && acards.isNotEmpty
                    ? Text("${acards[ind2].type} | ${acards[ind2].number}")
                    : const Text("Cliquer pour séléctionner"),
                children: [
                  SizedBox(
                    height: 300,
                    child: acards.isEmpty
                        ? const Center(
                      child: Text(
                        "Aucune carte active disponible",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                        : ListView.builder(
                      itemCount: acards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
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
                                color: const Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text("${acards[index].type} | ${acards[index]
                                      .number}")
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
          const Padding(
            padding: EdgeInsets.only(right: 280, top: 20),
            child: Text(
              "Montant",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 400,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
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
                  suffixIcon: const Padding(
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
          const SizedBox(height: 50),
          InkWell(
            onTap: () {
              if (ind1 != -1 && ind2 != -1 && ind3 != -1 &&
                  key2.currentState!.validate()) {
                if (bankingAccounts.isNotEmpty &&
                    bankingAccounts[ind1].balance < int.parse(montant.text)) {
                  showNotEnough(context);
                } else {
                  showRec(context);
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Veuillez remplir tous les champs")),
                );
              }
            },
            child: Container(
              width: 350,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFF4A9E1F),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
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
    );
  }
}