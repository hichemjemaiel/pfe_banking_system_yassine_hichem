import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Recharge%20de%20compte/RSix.dart';
import 'package:pfe_banking_system/screens/Recharge%20de%20compte/Rtwo.dart';

import '../Bar.dart';

class Rone extends StatefulWidget {
  const Rone({super.key});

  @override
  State<Rone> createState() => _RoneState();
}

class _RoneState extends State<Rone> {
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
          title: Text("Virement"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Choisissez une option pour continuer",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),),
              SizedBox(height: 40,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    SizedBox(height: 80,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rtwo()));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/recharge.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Recharge de compte",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 80),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rsix()));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/recharge.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Décharge de carte",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 100),child: Icon(Icons.arrow_forward_ios),),
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
