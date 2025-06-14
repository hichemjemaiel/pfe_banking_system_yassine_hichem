import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactModel.dart';
import 'package:pfe_banking_system/screens/Contacts/provider/ContactProvider.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';

class Cthree extends StatefulWidget {
  int? id ;
   Cthree({super.key, this.id});

  @override
  State<Cthree> createState() => _CthreeState();
}

class _CthreeState extends State<Cthree> {
  int myIndex = 0;
  var key = GlobalKey<FormState>();
  String? contactId ;
  TextEditingController nom = TextEditingController();
  TextEditingController adresse = TextEditingController();
  String? categorie;

  void showCategorire(BuildContext context){
     showModalBottomSheet(context: context, builder: (BuildContext ){
      return Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(right: 170,top: 20),child: Text("Choisissez une catégorie",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 20),child: Text("Cliquez pour choisir le une catégorie\na affecter a votre contact",style: TextStyle(fontSize: 18),),),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(padding: EdgeInsets.only(left: 50),child: Icon(Icons.done,color: Colors.green,size: 30,),),
                )
              ],
            ),
            Text("------------------------------------------------------------------",style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    setState(() {
                      categorie ="Amis";
                    });
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.group,color: Colors.green,size: 30,),
                      Text("Amis")
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      categorie = "Collegue";

                    });
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.emoji_food_beverage_rounded,size: 30,color: Colors.greenAccent,),
                      Text("Collegue")
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      categorie = "Famille";
                    });
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.groups,color: Colors.brown,size: 30,),
                      Text("Famille")
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    setState(() {
                      categorie = "Autres";
                    });
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Icon(Icons.house,color: Colors.lightGreen,size: 30,),
                      Text("Autres")
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
// Replace the showConfirm method in your Cthree.dart file with this fixed version:

// Replace the showConfirm method in your Cthree.dart file with this fixed version:

  void showConfirm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 50),
                  child: Text(
                    "Récapitulatif",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Text("Nom du contact               ${nom.text}", style: TextStyle(fontSize: 20)),
                Text("------------------------------------------------------------------", style: TextStyle(fontSize: 20)),
                Text("Type de contrat                      ${ind == 0 ? 'Professionnel' : 'Particulier'}", style: TextStyle(fontSize: 20)),
                Text("------------------------------------------------------------------", style: TextStyle(fontSize: 20)),
                Text("Adresse                        ${adresse.text}", style: TextStyle(fontSize: 20)),
                Text("------------------------------------------------------------------", style: TextStyle(fontSize: 20)),
                Text("Compte SFE      ${Provider.of<ContactProvider>(context, listen: false).rib ?? 'N/A'}", style: TextStyle(fontSize: 20)),
                Text("------------------------------------------------------------------", style: TextStyle(fontSize: 20)),
                Text("Catégorie                                        ${categorie ?? 'N/A'}", style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 180,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            "Annuler",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          // Show loading indicator
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );

                          // Save contact
                          bool contactSaved = await Provider.of<ContactProvider>(context, listen: false).saveContact();

                          if (contactSaved) {
                            final contact = Provider.of<ContactProvider>(context, listen: false).contact;

                            if (contact != null && contact.id != null && widget.id != null) {
                              // Add contact to client
                              bool addedToClient = await Provider.of<ContactProvider>(context, listen: false)
                                  .addContactToClient(contact.id.toString(), widget.id.toString());

                              // Close loading dialog
                              Navigator.pop(context);

                              if (addedToClient) {
                                // Clear provider data
                                Provider.of<ContactProvider>(context, listen: false).clearData();

                                // Close confirmation dialog
                                Navigator.pop(context);

                                // Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Contact ajouté avec succès!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );

                                // Navigate back to contacts list with success result
                                Navigator.pop(context, true); // Return true to Ctwo
                                Navigator.pop(context, true); // Return true to Cone
                              } else {
                                // Close confirmation dialog
                                Navigator.pop(context);

                                // Show error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Erreur lors de l'ajout du contact au client"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              // Close loading dialog
                              Navigator.pop(context);

                              // Close confirmation dialog
                              Navigator.pop(context);

                              // Show error message
                              String errorMsg = "Erreur: ";
                              if (contact == null) {
                                errorMsg += "Contact non créé";
                              } else if (contact.id == null) {
                                errorMsg += "Contact créé mais ID manquant";
                              } else if (widget.id == null) {
                                errorMsg += "ID client manquant";
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMsg),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          } else {
                            // Close loading dialog
                            Navigator.pop(context);

                            // Close confirmation dialog
                            Navigator.pop(context);

                            // Show error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Erreur lors de la création du contact"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } catch (e) {
                          // Close loading dialog if it's open
                          Navigator.pop(context);

                          // Close confirmation dialog
                          Navigator.pop(context);

                          print("Error in contact creation flow: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Erreur inattendue: $e"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 180,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            "Valider",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
    );
  }
  int ind = 0;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: key,
        child: Scaffold(
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
        title: Text("Informations Contact"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 60,),

            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height-100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 100,),
                      Padding(padding: EdgeInsets.only(right: 200),child: Text("Type de contact",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                      Padding(padding: EdgeInsets.only(top: 20,left: 50),child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                ind = 0;
                              });
                            }
                            ,child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                                color: ind == 0 ? Color(0xFF4A9E1F) : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(4, 4),
                                  )
                                ]
                            ),
                            child: Center(
                              child: Text("Professionnel",style: TextStyle(fontSize: 20),),
                            ),
                          ),
                          ),
                          SizedBox(width: 40,),
                          InkWell(
                            onTap: () {
                              setState(() {
                                ind = 1;
                              });
                            }
                            ,child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                                color: ind == 1 ? Color(0xFF4A9E1F) : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(4, 4),
                                  )
                                ]
                            ),
                            child: Center(
                              child: Text("Particulier",style: TextStyle(fontSize: 20),),
                            ),
                          ),
                          ),

                        ],
                      ),),
                      Padding(padding: EdgeInsets.only(right: 220,top: 30),child: Text("Nom du contact",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

                      Padding(padding: EdgeInsets.only(top: 10),child: Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: nom,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "This field must not be null";
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Cliquez pour saisir",

                            ),
                          ),
                        ),
                      ),),
                      Padding(padding: EdgeInsets.only(right: 280,top: 30),child: Text("Adresse",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

                      Padding(padding: EdgeInsets.only(top: 10),child: Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: adresse,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "This field must not be null";
                              }
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Cliquez pour saisir",

                            ),
                          ),
                        ),
                      ),),
                      Padding(padding: EdgeInsets.only(right: 300,top: 30),child: Text("Catégorie",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

                      Padding(padding: EdgeInsets.only(top: 10),child: InkWell(
                        onTap: (){
                          showCategorire(context);
                        },
                        child: Container(
                          width: 400,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Cliquez pour séléctionner",style: TextStyle(fontSize: 18),),
                                  SizedBox(width: 20,),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              )
                          ),
                        ),
                      )),
                      InkWell(
                        onTap: (){
                          if(key.currentState!.validate()){
                            ind == 0 ? Provider.of<ContactProvider>(context,listen: false).setType(type: "Professionnel") : Provider.of<ContactProvider>(context,listen: false).setType(type: "Particulier");
                            Provider.of<ContactProvider>(context,listen: false).setNom(nom: nom.text);
                            Provider.of<ContactProvider>(context,listen: false).setAdresse(adresse: adresse.text);
                            Provider.of<ContactProvider>(context,listen: false).setCategorie(categorie: categorie!);
                            showConfirm(context);
                          }
                        },
                        child:  Padding(padding: EdgeInsets.only(top: 50),child: Container(
                          width: 300,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Continuer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                          ),
                        ),),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: -40,
                    left: 170,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(4, 4)
                          )
                        ]
                      ),
                    )),
              ],
            ),

          ],
        ),
      ),
    ));
  }
}
