import 'package:flutter/material.dart';

import '../../CodeVerif.dart';

class Dthree extends StatefulWidget {
  const Dthree({super.key});

  @override
  State<Dthree> createState() => _DthreeState();
}

class _DthreeState extends State<Dthree> {
  void showConfirmationDialog(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return Container(
            height: 450,
            width: 500,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Récapitulatif",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
                SizedBox(height: 30,),
                Text("Compte  a débiter             000554501101",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Montant                                   50 000 XAF",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Station                                        Station 01",style: TextStyle(fontSize: 20),),

                Padding(padding: EdgeInsets.only(top: 70,left: 60),child:
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child:
                        InkWell(
                          onTap: (){

                          },
                          child: Text("Annuler",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverif()));
                      },
                      child:  Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child:
                          Text("Valider",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    )
                  ],
                ),),
              ],
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Agence Hyperion"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text("Vers quel compte\nsouhaitez-vous faire\nvotre versement ?",style: TextStyle(
                fontSize: 30,

              ),),
              SizedBox(height: 30,),
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height+200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 160,top: 40),child: Text("Selectionner le compte",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: ExpansionTile(title: Text("Cliquer pour selectionner")),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(top: 20,right: 280),child: Text("Montant",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                        width: 400,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Column(
                          children: [
                            Container(
                              width: 400,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none
                                      ),
                                      hintText: "Cliquer pour saisir le montant",
                                      hintStyle: TextStyle(
                                          fontSize: 16
                                      ),
                                      suffixIcon: Padding(padding: EdgeInsets.only(top: 10,right: 20),child: Text("XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
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
                              child: Center(child: Text("Solde disponible : 8500 000 XAF",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),),
                            )
                          ],
                        )
                    ),
                    Padding(padding: EdgeInsets.only(right: 180,top: 40),child: Text("Selectionner la station",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ExpansionTile(title: Text("Choisissez votre station")),

                      ),
                    ),


                    SizedBox(height: 50,),
                    InkWell(
                      onTap: (){
                        showConfirmationDialog(context);
                      },
                      child: Container(
                        width: 300,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Continuer",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ],
          ),
        )
    );
  }
}
