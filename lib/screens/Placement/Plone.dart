import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Placement/Plsix.dart';
import 'package:pfe_banking_system/screens/Placement/Pltwo.dart';




class Plone extends StatefulWidget {
  const Plone({super.key});

  @override
  State<Plone> createState() => _PloneState();
}

class _PloneState extends State<Plone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Récupération de compte"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            Padding(padding: EdgeInsets.only(right: 10,top: 50),child: Image.asset("assets/shield.png",scale: 2,),),
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
                  Padding(padding: EdgeInsets.only(top: 50,right: 150),child: Text("J'ai oublié mon : ",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),),),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Plsix()));
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
                                  child: Image.asset("assets/badge.png",scale: 1.5,),
                                ),

                                SizedBox(height: 20,),
                                Text("Identifiant",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                ),),
                              ],
                            )
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Pltwo()));
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
                                  child: Image.asset("assets/key.png",scale: 1.5,),
                                ),

                                SizedBox(height: 20,),
                                Text("Mot de passe",style: TextStyle(
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
