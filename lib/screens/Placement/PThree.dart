import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Placement/Plfour.dart';

class Pthree extends StatefulWidget {
  const Pthree({super.key});

  @override
  State<Pthree> createState() => _PthreeState();
}

class _PthreeState extends State<Pthree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Mot de passe oublié"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child:Column(
            children: [
              SizedBox(height: 100,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 50,right: 100),child: Text("Questions secrete",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),),),
                    SizedBox(height: 20,),
                    Text("Répondez a vos questions pour réinitialiser\nvotre mot de passe",style: TextStyle(
                        fontSize: 20
                    ),),
                    SizedBox(height: 30,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:
                           Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("Quel est votre lieu de naissance ?",style: TextStyle(
                               fontSize: 18
                           ),),
                      ),
                    ),
                    SizedBox(height: 20,),
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
                              hintText: "Cliquer pour saisir la réponse",
                              hintStyle: TextStyle(
                                  fontSize: 16
                              ),

                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:
                      Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("Quelle a été votre école priamire ?",style: TextStyle(
                          fontSize: 18
                      ),),
                      ),
                    ),
                    SizedBox(height: 20,),
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
                              hintText: "Cliquer pour saisir la réponse",
                              hintStyle: TextStyle(
                                  fontSize: 16
                              ),

                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 50,),
                    InkWell(
                      onTap : (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Plfour()));
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Valider",style: TextStyle(
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
