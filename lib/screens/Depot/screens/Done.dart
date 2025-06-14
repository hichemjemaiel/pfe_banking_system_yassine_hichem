import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Deight.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dfour.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dseven.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dsix.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dsixt.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dthree.dart';

import '../../Bar.dart';
import 'Dsevent.dart';
import 'Dtwo.dart';

class Done extends StatefulWidget {
   int? id ;
   Done({super.key, this.id});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
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
          title: Text("Depot"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Choisissez le canal\n    de versement.",style: TextStyle(
                  fontSize: 25
              ),),),
              SizedBox(height: 40,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dtwo()));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/refour.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Agence",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 200),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),


                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dfour()));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/reone.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Mobile Money",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 140),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dsevent(id : widget.id)));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/recharge.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Via carte",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 190),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dseven()));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Text("Encaissement mise a disposition",style: TextStyle(
                                fontSize: 18
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 10 ),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
