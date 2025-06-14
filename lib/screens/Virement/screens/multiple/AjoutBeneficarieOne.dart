import 'package:flutter/material.dart';

import '../../../Bar.dart';
import 'AjoutBeneficairetwo.dart';


class Ajoutbeneficarieone extends StatefulWidget {
  const Ajoutbeneficarieone({super.key});

  @override
  State<Ajoutbeneficarieone> createState() => _AjoutbeneficarieoneState();
}

class _AjoutbeneficarieoneState extends State<Ajoutbeneficarieone> {
  int myIndex = 0;
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
                    Padding(padding: EdgeInsets.only(right: 230,top: 40),child: Text("Bénéficaire 1",style: TextStyle(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Ajoutbeneficairetwo()));
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
