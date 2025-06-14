import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Reeight.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Refour.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Renine.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Reseven.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Rethree.dart';

import '../../Bar.dart';

class Retwo extends StatefulWidget {
  const Retwo({super.key});

  @override
  State<Retwo> createState() => _RetwoState();
}

class _RetwoState extends State<Retwo> {
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
              Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Comment souhaitez-vous\nfaire votre retrait ?",style: TextStyle(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rethree()));
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


                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Reseven()));
                      },
                      child: Container(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Renine()));
                      },
                      child: Container(
                        height: 70,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/rethree.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Digicode",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 190),child: Icon(Icons.arrow_forward_ios),),
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
