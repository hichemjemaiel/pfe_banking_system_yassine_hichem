import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Renine.dart';

class Reeight extends StatefulWidget {
  const Reeight({super.key});

  @override
  State<Reeight> createState() => _ReeightState();
}

class _ReeightState extends State<Reeight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Retrait en station"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child:Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 50),child: Text("Qui est le bénéficiaire?",style: TextStyle(
                  fontSize: 20
              ),),),
              SizedBox(height: 50,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [

                    SizedBox(height: 150,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Renine()));
                          },
                          child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Image.asset("assets/retone.png",scale: 1.5,),
                                  ),

                                  SizedBox(height: 20,),
                                  Text("Réseau bamboo",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),),
                                ],
                              )
                          ),
                        ),
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40)
                                    ),
                                    child: Image.asset("assets/rettwo.png"),
                                  ),

                                  SizedBox(height: 20,),
                                  Text("Réseau Ecobank",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),),
                                ],
                              )
                          ),
                        )
                      ],
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
