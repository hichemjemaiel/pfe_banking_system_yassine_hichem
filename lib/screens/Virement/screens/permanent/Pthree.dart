import 'package:flutter/material.dart';

import '../../../Bar.dart';
import 'Pfour.dart';

class Pthree extends StatefulWidget {
  const Pthree({super.key});

  @override
  State<Pthree> createState() => _PthreeState();
}

class _PthreeState extends State<Pthree> {
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
          title: Text("Virement permanent"),
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
                    Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Compte a débiter",style: TextStyle(
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
                        child:  ExpansionTile(title: Text("Cliquer pour selectionner")),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(right: 280,top: 40),child: Text("Montant",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
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
                    Padding(padding: EdgeInsets.only(right:110,top: 40),child: Text("Date de la premiere échange",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
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
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "JJ-MM-AAAA",
                                suffixIcon: Icon(Icons.calendar_month,color: Colors.green,)
                            ),

                          )),
                    ),
                    Padding(padding: EdgeInsets.only(right:110,top: 40),child: Text("Date de la derniere échange",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
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
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "JJ-MM-AAAA",
                                suffixIcon: Icon(Icons.calendar_month,color: Colors.green,)
                            ),

                          )),
                    ),
                    Padding(padding: EdgeInsets.only(right:260,top: 40),child: Text("Périodicité",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
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
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "Cliquer pour sélectionner",
                                suffixIcon: Icon(Icons.arrow_forward_ios,color: Colors.black,)
                            ),

                          )),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap : (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Pfour()));
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
