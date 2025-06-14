// ContactUpdate.dart - Update Contact Screen
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactDtoModel.dart';
import 'package:pfe_banking_system/screens/Contacts/provider/ContactDtoProvider.dart';
import 'package:provider/provider.dart';
import '../../Bar.dart';

class ContactUpdate extends StatefulWidget {
  final ContactDtoModel contact;
  final int? clientId;

  ContactUpdate({super.key, required this.contact, this.clientId});

  @override
  State<ContactUpdate> createState() => _ContactUpdateState();
}

class _ContactUpdateState extends State<ContactUpdate> {
  int myIndex = 0;
  var key = GlobalKey<FormState>();

  // Controllers
  late TextEditingController nomController;
  late TextEditingController adresseController;
  late TextEditingController ribController;
  late TextEditingController intituleController;

  // State variables
  String? selectedType;
  String? selectedCategorie;
  int typeIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with current contact data
    nomController = TextEditingController(text: widget.contact.nom);
    adresseController = TextEditingController(text: widget.contact.adresse ?? '');
    ribController = TextEditingController(
        text: widget.contact.bankingAccounts.isNotEmpty
            ? widget.contact.bankingAccounts[0].RIB
            : ''
    );
    intituleController = TextEditingController(
        text: widget.contact.bankingAccounts.isNotEmpty
            ? widget.contact.bankingAccounts[0].type
            : ''
    );

    selectedType = widget.contact.type;
    selectedCategorie = widget.contact.categorie;
    typeIndex = selectedType == "Professionnel" ? 0 : 1;
  }

  @override
  void dispose() {
    nomController.dispose();
    adresseController.dispose();
    ribController.dispose();
    intituleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier le contact"),
        backgroundColor: Color(0xFF4A9E1F),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: key,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Name Field
              Text(
                "Nom du contact",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nomController,
                decoration: InputDecoration(
                  hintText: "Entrez le nom du contact",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom du contact';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Contact Type Selection
              Text(
                "Type de contact",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Professionnel"),
                      value: "Professionnel",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                          typeIndex = 0;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text("Personnel"),
                      value: "Personnel",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                          typeIndex = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Address Field
              Text(
                "Adresse",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: adresseController,
                decoration: InputDecoration(
                  hintText: "Entrez l'adresse",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              SizedBox(height: 20),

              // RIB Field
              Text(
                "RIB",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: ribController,
                decoration: InputDecoration(
                  hintText: "Entrez le RIB",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.credit_card),
                ),
              ),
              SizedBox(height: 20),

              // Intitule Field
              Text(
                "Intitulé",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: intituleController,
                decoration: InputDecoration(
                  hintText: "Entrez l'intitulé",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.account_balance),
                ),
              ),
              SizedBox(height: 20),

              // Category Selection
              Text(
                "Catégorie",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () => showCategorieSelector(context),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.label, color: Colors.grey[600]),
                      SizedBox(width: 10),
                      Text(
                        selectedCategorie ?? "Sélectionner une catégorie",
                        style: TextStyle(
                          color: selectedCategorie != null ? Colors.black : Colors.grey[600],
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_drop_down, color: Colors.grey[600]),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Update Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      showUpdateConfirmation(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A9E1F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Mettre à jour le contact",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  void showCategorieSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Choisissez une catégorie",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Sélectionnez la catégorie qui correspond le mieux à votre contact",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  padding: EdgeInsets.all(20),
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  children: [
                    _buildCategoryOption("Amis", Icons.group, Colors.blue),
                    _buildCategoryOption("Collègue", Icons.work, Colors.orange),
                    _buildCategoryOption("Famille", Icons.family_restroom, Colors.purple),
                    _buildCategoryOption("Autres", Icons.more_horiz, Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryOption(String category, IconData icon, Color color) {
    bool isSelected = selectedCategorie == category;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategorie = category;
        });
        Navigator.pop(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[600],
              size: 35,
            ),
            SizedBox(height: 8),
            Text(
              category,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateConfirmation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 10),
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Confirmer les modifications",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 30),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildSummaryCard("Nom du contact", nomController.text, Icons.person),
                      _buildSummaryCard("Type de contact", selectedType ?? "", Icons.category),
                      _buildSummaryCard("Adresse", adresseController.text, Icons.location_on),
                      _buildSummaryCard("RIB", ribController.text, Icons.credit_card),
                      _buildSummaryCard("Intitulé", intituleController.text, Icons.account_balance),
                      _buildSummaryCard("Catégorie", selectedCategorie ?? "", Icons.label),
                    ],
                  ),
                ),
              ),

              // Action buttons
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
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
                    SizedBox(width: 15),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _updateContact();
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Confirmer",
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
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Color(0xFF4A9E1F),
            size: 24,
          ),
          SizedBox(width: 15),
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
                SizedBox(height: 5),
                Text(
                  value.isEmpty ? "Non spécifié" : value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: value.isEmpty ? Colors.grey[400] : Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateContact() async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF4A9E1F),
                  ),
                  SizedBox(height: 15),
                  Text("Mise à jour en cours..."),
                ],
              ),
            ),
          );
        },
      );

      // Create updated contact object
      ContactDtoModel updatedContact = ContactDtoModel(
        id: widget.contact.id,
        nom: nomController.text,
        type: selectedType!,
        adresse: adresseController.text,
        categorie: selectedCategorie!,
        bankingAccounts: widget.contact.bankingAccounts, // Keep existing banking accounts
        clientModel: widget.contact.clientModel,
      );

      // Call update service
      bool success = await Provider.of<ContactDtoProvider>(context, listen: false)
          .updateContact(widget.contact.id!, updatedContact);

      // Close loading dialog
      Navigator.pop(context);

      if (success) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 10),
                Text("Contact mis à jour avec succès!"),
              ],
            ),
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

        // Navigate back with success result
        Navigator.pop(context, true);
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 10),
                Text("Erreur lors de la mise à jour"),
              ],
            ),
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if it's still open
      Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 10),
              Text("Une erreur est survenue: ${e.toString()}"),
            ],
          ),
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}