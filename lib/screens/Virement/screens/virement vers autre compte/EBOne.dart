import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactDtoModel.dart';
import 'package:pfe_banking_system/screens/Contacts/provider/ContactDtoProvider.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20vers%20autre%20compte/CodeVerifEcoBank.dart';
import 'package:provider/provider.dart';

import '../../../Bar.dart';
import '../../../OTP/provider/OtpProvider.dart';

class Ebone extends StatefulWidget {
  final int? id; // Client ID parameter
  const Ebone({super.key, this.id});

  @override
  State<Ebone> createState() => _EboneState();
}

class _EboneState extends State<Ebone> {
  int myIndex = 0;
  int ind = -1; // Index for sender account
  int contactIndex = -1; // Index for selected contact
  int contactAccountIndex = -1; // Index for selected contact account
  TextEditingController montant = TextEditingController();
  String? otpCode;
  var key = GlobalKey<FormState>();
  TextEditingController namecreditnum = TextEditingController();
  TextEditingController motif = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    montant.dispose();
    namecreditnum.dispose();
    motif.dispose();
    super.dispose();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("Ebone _loadData: Fetching banking accounts for client ID 1");
      Provider.of<BankingAccountDTOProvider>(context, listen: false).getAllBankingAccountForClient(1);
      if (widget.id != null) {
        print("Ebone _loadData: Fetching contacts for client ID ${widget.id}");
        Provider.of<ContactDtoProvider>(context, listen: false).getAllContactsForClient(widget.id!);
      } else {
        print("Ebone _loadData: Client ID is null, skipping contact fetch");
      }
    });
  }

  void _refreshContacts() {
    if (widget.id != null) {
      print("Ebone _refreshContacts: Refreshing contacts for client ID ${widget.id}");
      Provider.of<ContactDtoProvider>(context, listen: false).refreshContacts(widget.id!);
    }
  }

  void showConfirmationDialog(BuildContext context, String montant, String senderRIB, String receiverRIB, String bankId, String beneficiaryName, String motifText) {
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;
    BankingAccountDTOModel senderAccount = accounts[ind];

    String receiverName = beneficiaryName.isNotEmpty ? beneficiaryName : "Bénéficiaire";
    String receiverRibDisplay = receiverRIB.length > 10
        ? "${receiverRIB.substring(0, 4)}...${receiverRIB.substring(receiverRIB.length - 4)}"
        : receiverRIB;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 600,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF4A9E1F),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.white, size: 28),
                    SizedBox(width: 10),
                    Text(
                      "Récapitulatif du virement",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildTransferDetailItem(
                        "Compte à débiter",
                        senderAccount.type,
                        senderAccount.RIB,
                        Icons.account_balance_wallet,
                      ),
                      _buildDivider(),
                      _buildTransferDetailItem(
                        "Montant",
                        "$montant XAF",
                        "Frais inclus",
                        Icons.payments,
                      ),
                      _buildDivider(),
                      _buildTransferDetailItem(
                        "Bénéficiaire",
                        receiverName,
                        receiverRibDisplay,
                        Icons.person,
                      ),
                      _buildDivider(),
                      if (motifText.isNotEmpty) ...[
                        _buildTransferDetailItem(
                          "Motif",
                          motifText,
                          "",
                          Icons.description,
                        ),
                        _buildDivider(),
                      ],
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber, color: Colors.orange),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Vérifiez bien les informations avant de valider cette opération.",
                                style: TextStyle(
                                  color: Colors.orange[800],
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    "Annuler",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21646491524");
                                otpCode = Provider.of<OtpProvider>(context, listen: false).otpCode;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Codeverifecobank(
                                      montant: montant,
                                      senderRIB: senderRIB,
                                      receiverRIB: receiverRIB,
                                      BankId: bankId,
                                      namecreditnum: beneficiaryName,
                                      otpCode: otpCode,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransferDetailItem(String title, String value, String subtitle, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4A9E1F).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF4A9E1F), size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[300],
      thickness: 1,
      height: 20,
    );
  }

  void showNotEnough(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.error, color: Colors.white, size: 28),
                    SizedBox(width: 10),
                    Text(
                      "Solde insuffisant",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Votre solde est insuffisant pour effectuer cette opération.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Text(
                                    "Annuler",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                // Navigate to deposit screen
                              },
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Déposer",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
        title: const Text("Virements vers autre banque"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: _refreshContacts,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.blue,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer2<BankingAccountDTOProvider, ContactDtoProvider>(
        builder: (context, accountProvider, contactProvider, child) {
          List<BankingAccountDTOModel> accounts = accountProvider.accounts;
          List<ContactDtoModel> contacts = contactProvider.contacts ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sender Account Selection
                          const Text(
                            "Compte à débiter",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ExpansionTile(
                              title: ind == -1
                                  ? const Text("Cliquer pour sélectionner")
                                  : Text("${accounts[ind].type} | ${accounts[ind].RIB}"),
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: accounts.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            ind = index;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Container(
                                            width: double.infinity,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF7F7F7),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 30),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text("${accounts[index].type} | ${accounts[index].RIB}"),
                                              ),
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

                          // Amount Input
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              "Montant",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7F7F7),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: TextFormField(
                                      controller: montant,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Ce champ ne doit pas être vide";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: "Cliquer pour saisir le montant",
                                        hintStyle: const TextStyle(fontSize: 16),
                                        suffixIcon: const Padding(
                                          padding: EdgeInsets.only(top: 10, right: 20),
                                          child: Text(
                                            "XAF",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ind != -1
                                          ? "Solde disponible : ${accounts[ind].balance} XAF"
                                          : "Solde disponible : --- XAF",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Contact Selection
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              "Bénéficiaire",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 300,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: contactProvider.isLoading
                                ? const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Color(0xFF4A9E1F),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Chargement des contacts...",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : contactProvider.errorMessage != null
                                ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    size: 60,
                                    color: Colors.red,
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    "Erreur: ${contactProvider.errorMessage}",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: _refreshContacts,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4A9E1F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      "Réessayer",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : contacts.isEmpty
                                ? const Center(
                              child: Text(
                                "Aucun contact disponible",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                                : ListView.builder(
                              padding: const EdgeInsets.all(10),
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                final contact = contacts[index];
                                final isSelected = contactIndex == index;
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      contactIndex = index;
                                      contactAccountIndex = -1;
                                      namecreditnum.text = contact.nom;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF4A9E1F).withOpacity(0.1)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: isSelected ? const Color(0xFF4A9E1F) : Colors.grey[300]!,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFF4A9E1F),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              contact.nom.isNotEmpty
                                                  ? contact.nom[0].toUpperCase()
                                                  : '?',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                contact.nom,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                contact.type,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 14,
                                                ),
                                              ),
                                              if (contact.categorie != null)
                                                Text(
                                                  contact.categorie!,
                                                  style: TextStyle(
                                                    color: Colors.grey[500],
                                                    fontSize: 12,
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
                            ),
                          ),

                          // Account Selection for Selected Contact
                          if (contactIndex != -1 && contacts[contactIndex].bankingAccounts.isNotEmpty) ...[
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                "Compte du bénéficiaire",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ExpansionTile(
                                title: contactAccountIndex == -1
                                    ? const Text("Sélectionner un compte")
                                    : Text(
                                    "${contacts[contactIndex].bankingAccounts[contactAccountIndex].type} | ${contacts[contactIndex].bankingAccounts[contactAccountIndex].RIB}"),
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      itemCount: contacts[contactIndex].bankingAccounts.length,
                                      itemBuilder: (context, index) {
                                        final account = contacts[contactIndex].bankingAccounts[index];
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              contactAccountIndex = index;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF7F7F7),
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: contactAccountIndex == index
                                                      ? const Color(0xFF4A9E1F)
                                                      : Colors.transparent,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    account.type,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    account.RIB,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 14,
                                                      fontFamily: 'monospace',
                                                    ),
                                                  ),
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
                          ],

                          // Beneficiary Name
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              "Nom du bénéficiaire",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: namecreditnum,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Ce champ ne doit pas être vide";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Nom du bénéficiaire",
                                ),
                              ),
                            ),
                          ),

                          // Motif
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              "Motif",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: TextField(
                                controller: motif,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  hintText: "Cliquez pour saisir votre motif",
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Center(
                            child: InkWell(
                              onTap: () {
                                if (key.currentState!.validate() && ind != -1 && contactIndex != -1 && contactAccountIndex != -1) {
                                  if (accounts[ind].balance >= double.parse(montant.text)) {
                                    showConfirmationDialog(
                                      context,
                                      montant.text,
                                      accounts[ind].RIB,
                                      contacts[contactIndex].bankingAccounts[contactAccountIndex].RIB,
                                      accounts[ind].id.toString(),
                                      namecreditnum.text,
                                      motif.text,
                                    );
                                  } else {
                                    showNotEnough(context);
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Veuillez remplir tous les champs obligatoires"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Continuer",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}