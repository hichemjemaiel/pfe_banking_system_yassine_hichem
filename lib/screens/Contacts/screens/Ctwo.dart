import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Contacts/provider/ContactProvider.dart';
import 'package:pfe_banking_system/screens/Contacts/screens/Cthree.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';

class Ctwo extends StatefulWidget {
  int? id;
   Ctwo({super.key,  this.id});

  @override
  State<Ctwo> createState() => _CtwoState();
}

class _CtwoState extends State<Ctwo> {
 int ind = 0;
 int myIndex = 0;
 var key = GlobalKey<FormState>();
 TextEditingController rib = TextEditingController();
 TextEditingController intitule = TextEditingController();
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
        title: Text("Ajout un contact"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
          children: [
            SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height+200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: ind == 1 ? Autres(context) :Column(
                children: [
                  Text("Type de compte",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Padding(padding: EdgeInsets.only(top: 50,left: 50),child: Row(
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
                          child: Text("SFE",style: TextStyle(fontSize: 20),),
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
                          child: Text("Autres",style: TextStyle(fontSize: 20),),
                        ),
                      ),
                      ),
                    ],
                  ),),
                  Padding(padding: EdgeInsets.only(right: 320,top: 30),child: Text("RIB",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

                  Padding(padding: EdgeInsets.only(top: 10),child: Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: rib,
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
                            hintText: "Cliquez pour saisir le RIB",
                            suffixIcon: Icon(Icons.document_scanner)
                        ),
                      ),
                    ),
                  ),),
                  Padding(padding: EdgeInsets.only(right: 200,top: 30),child: Text("Intitulé de compte",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

                  Padding(padding: EdgeInsets.only(top: 10),child: Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: intitule,
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
                  // In your Ctwo.dart, update the "Continuer" button onTap method:

                  InkWell(
                    onTap: () async {
                      if(key.currentState!.validate()){
                        Provider.of<ContactProvider>(context,listen: false).setRib(rib: rib.text);
                        Provider.of<ContactProvider>(context,listen: false).setIntitule(intitule: intitule.text);

                        // Navigate to Cthree and wait for result
                        final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Cthree(id : widget.id))
                        );

                        // If contact was added successfully, return success to Cone
                        if (result == true) {
                          Navigator.pop(context, true);
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Container(
                        width: 300,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Continuer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),),
      )
    );
  }
  Widget Autres(BuildContext context){
    return Column(
      children: [
        Text("Type de compte",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        Padding(padding: EdgeInsets.only(top: 50,left: 50),child: Row(
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
                child: Text("SFE",style: TextStyle(fontSize: 20),),
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
                child: Text("Autres",style: TextStyle(fontSize: 20),),
              ),
            ),
            ),
          ],
        ),),
        Padding(padding: EdgeInsets.only(right: 200,top: 30),child: Text("Libellé de compte",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

        Padding(padding: EdgeInsets.only(top: 10),child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: TextField(
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
        Padding(padding: EdgeInsets.only(right: 300,top: 30),child: Text("Banque",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

        Padding(padding: EdgeInsets.only(top: 10),child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: ExpansionTile(title: Text("Cliquez pour séléctionner"))
          ),
        ),),
        Padding(padding: EdgeInsets.only(right: 250,top: 30),child: Text("Code Banque",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

        Padding(padding: EdgeInsets.only(top: 10),child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: TextField(
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
        Padding(padding: EdgeInsets.only(right: 290,top: 30),child: Text("Agence",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

        Padding(padding: EdgeInsets.only(top: 10),child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: TextField(
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
        Padding(padding: EdgeInsets.only(right: 200,top: 30),child: Text("Numéro de compte",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

        Padding(padding: EdgeInsets.only(top: 10),child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: TextField(
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
        Padding(padding: EdgeInsets.only(right: 290,top: 30),child: Text("Clé RIB",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

        Padding(padding: EdgeInsets.only(top: 10),child: Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Center(
            child: TextField(
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
        InkWell(
          onTap: () async {
            final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Cthree(id : widget.id))
            );

            if (result == true) {
              Navigator.pop(context, true);
            }
          },
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: Container(
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                  color: Color(0xFF4A9E1F),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Continuer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
