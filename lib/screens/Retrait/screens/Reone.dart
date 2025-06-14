import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Done.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Reten.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Retwo.dart';

import '../../Bar.dart';

class Reone extends StatefulWidget {
  int? id ;
   Reone({super.key, this.id});

  @override
  State<Reone> createState() => _ReoneState();
}

class _ReoneState extends State<Reone> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Bar(myIndex: myIndex, onTap: (index){
          setState(() {
            myIndex = index;
          });
        }),
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Retrait"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Quel type d'opération\nsouhaitiez-vous faire ?",style: TextStyle(
                  fontSize: 25
              ),),),
              SizedBox(height: 40,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Done(id : widget.id)));
                      },
                      child:   Container(
                        height: 70,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/rtwo.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Dépot",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 220),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Retwo()));
                      },
                      child:
                      Container(
                        height: 70,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/rthree.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Retrait",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 210),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Reten()));
                      },
                      child:  Container(
                        height: 70,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/rone.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Mise a disposition",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 100),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
