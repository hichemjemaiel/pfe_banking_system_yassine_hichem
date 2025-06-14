import 'package:flutter/material.dart';

import '../../../Bar.dart';
import '../../../CodeVerif.dart';


class Ajoutbeneficairetwo extends StatefulWidget {
  const Ajoutbeneficairetwo({super.key});

  @override
  State<Ajoutbeneficairetwo> createState() => _AjoutbeneficairetwoState();
}

class _AjoutbeneficairetwoState extends State<Ajoutbeneficairetwo> {
  int myIndex = 0;
  void showConfirmationDialog(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return SingleChildScrollView(
            child: Container(
              height: 1000,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Récapitulatifs du virement",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  SizedBox(height: 30,),
                  Text("Compte  a débiter            Compte Courant",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Montant total                           50 000 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Bénéficaire 1                            Emane Viny",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Compte bénéficaire                    0057246",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Montant                                    500 000 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Bénéficaire 2                                Yao N DRI",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Compte bénéficaire                         0057246",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Montant                                     500 000 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Frais                                          15 250 XAF",style: TextStyle(fontSize: 20),),


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
            )
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Bar(myIndex: myIndex, onTap: (ind){
          setState(() {
            myIndex = ind;
          });
        }),
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Ajout du bénéficaire"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 150,top: 40),child: Text("Compte du Bénéficaire",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                        child:  TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Cliquer pour saisir le nom"
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 230,top: 40),child: Text("Bénéficaire 2",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                        child:  TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Cliquer pour saisir le nom"
                          ),
                        ),
                      ),
                    ), Padding(padding: EdgeInsets.only(right: 270,top: 40),child: Text("Montant",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                        child:  TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Cliquer pour saisir le nom"
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 240,top: 40),child: Text("Motant total",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                        child:  TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "500 000",
                            suffixIcon: Padding(padding: EdgeInsets.only(top: 10,right: 20),child: Text("XAF",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 40,),

                    InkWell(
                      onTap : (){
                        showConfirmationDialog(context);
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Continuer",style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
