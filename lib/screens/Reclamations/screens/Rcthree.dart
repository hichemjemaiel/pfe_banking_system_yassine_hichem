import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe_banking_system/screens/Reclamations/provider/ReclamationProvider.dart';
import 'package:pfe_banking_system/screens/Reclamations/screens/Recverif.dart';
import 'package:pfe_banking_system/screens/TransactionsCertif.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';

class Rcthree extends StatefulWidget {
  int? id;
  Rcthree({super.key,  this.id});

  @override
  State<Rcthree> createState() => _RcthreeState();
}

class _RcthreeState extends State<Rcthree> {
  var key = GlobalKey<FormState>();
  TextEditingController objet = TextEditingController();
  TextEditingController Description = TextEditingController();
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
  String? ReclamationId;
  int myIndex = 0;

  // Add this variable to store selected complaint type
  String? selectedComplaintType;

  // List of complaint types
  final List<String> complaintTypes = [
    'Problème de carte bancaire',
    'Transaction non autorisée',
    'Frais bancaires contestés',
    'Problème de virement',
    'Erreur de solde',
    'Problème de chéquier',
    'Service client insatisfaisant',
    'Problème de prélèvement',
    'Dysfonctionnement DAB',
    'Problème d\'application mobile',
    'Retard de traitement',
    'Autre'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (index){
            setState(() {
              myIndex = index;
            });
          }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Demande de réclamation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height-100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Type de réclamation",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButtonFormField<String>(
                            value: selectedComplaintType,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Cliquer pour sélectionner",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Veuillez sélectionner un type de réclamation";
                              }
                              return null;
                            },
                            items: complaintTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedComplaintType = newValue;
                              });
                            },
                          ),
                        )
                    ),
                    Padding(padding: EdgeInsets.only(right: 320,top: 40),child: Text("Objet",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: Center(
                            child: TextFormField(
                              controller: objet,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "This field must not be null";
                                }
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none
                                  ),
                                  hintText: "Cliquer pour saisir"
                              ),
                            )
                        )
                    ),
                    Padding(padding: EdgeInsets.only(right: 270,top: 40),child: Text("Description",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Padding(padding: EdgeInsets.only(top: 20,left: 10),child: TextFormField(
                        controller: Description,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "This filed must not be null";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Ciquer pour saisir votre description"
                        ),
                      ),),
                    ),
                    SizedBox(height: 40,),

                    InkWell(
                      onTap: () async {
                        if(key.currentState!.validate()){
                          // Check if widget.id is not null
                          if (widget.id == null) {
                            print("Error: Client ID is null");
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Erreur: ID client manquant"))
                            );
                            return;
                          }

                          try {
                            // Use the selected complaint type instead of hardcoded "Reclamation"
                            Provider.of<ReclamationProvider>(context, listen: false).setType(type: selectedComplaintType ?? "Reclamation");
                            Provider.of<ReclamationProvider>(context, listen: false).setObjet(objet: objet.text);
                            Provider.of<ReclamationProvider>(context, listen: false).setDescription(description: Description.text);
                            Provider.of<ReclamationProvider>(context, listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                            Provider.of<ReclamationProvider>(context, listen: false).setTime(time: formattedTime);
                            Provider.of<ReclamationProvider>(context, listen: false).setStatus();

                            // Save reclamation first
                            await Provider.of<ReclamationProvider>(context, listen: false).saveReclamation();

                            // Get the saved reclamation
                            final reclamation = Provider.of<ReclamationProvider>(context, listen: false).reclamation;

                            if(reclamation != null && reclamation.id != null) {
                              // Link reclamation to client
                              await Provider.of<ReclamationProvider>(context, listen: false)
                                  .addReclamationToClient(reclamation.id.toString(), widget.id.toString());

                              // Navigate to success page
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RecVerif(id : widget.id!)));
                            } else {
                              print("Error: Failed to save reclamation or get reclamation ID");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Erreur lors de la sauvegarde de la réclamation"))
                              );
                            }
                          } catch (e) {
                            print("Error in onTap: $e");
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Une erreur s'est produite"))
                            );
                          }
                        }
                      },
                      child: Container(
                        width: 300,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text("Envoyer", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                ),),
            ),
          ],
        ),
      ),
    );
  }
}