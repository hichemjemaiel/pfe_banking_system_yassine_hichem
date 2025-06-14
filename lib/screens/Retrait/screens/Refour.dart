import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Refive.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Resix.dart';

class Refour extends StatefulWidget {
  const Refour({super.key});

  @override
  State<Refour> createState() => _RefourState();
}

class _RefourState extends State<Refour> {
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Refive()));
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
                                    child: Icon(Icons.person),
                                  ),

                                  SizedBox(height: 20,),
                                  Text("Moi",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),),
                                ],
                              )
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Resix()));
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
                                    child: Icon(Icons.person),
                                  ),

                                  SizedBox(height: 20,),
                                  Text("Un tiers",style: TextStyle(
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
