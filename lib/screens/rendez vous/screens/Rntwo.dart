import 'dart:math';

import 'package:flutter/material.dart';

import '../../Bar.dart';

class Rntwo extends StatefulWidget {
  const Rntwo({super.key});

  @override
  State<Rntwo> createState() => _RntwoState();
}

class _RntwoState extends State<Rntwo> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Bar(
            myIndex: myIndex,
            onTap: (index){
              setState(() {
                myIndex = index;
              });
            }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text("Détail du rendez-vous\nen agence Hyperion"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(height: 60,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height-50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 40,right: 280),child: Text("Agence",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("Agence Hyperion",style: TextStyle(fontSize: 20),),),
                  ),
                  Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Date et heure",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Container(
                        width: 200,
                        height: 70,
                        decoration: BoxDecoration(
                          color : Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: Center(
                          child: Text("10 / 12 / 2022",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        )
                      ),
                      Text("à",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Container(
                        width: 150,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text("09:30",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(right: 300,top: 20),child: Text("Objet",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color : Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),

                      ),
                        child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("Erreur de virement",style: TextStyle(fontSize: 20),),),

                  ),
                  Padding(padding: EdgeInsets.only(right: 230,top: 20),child: Text("Commentaire",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color : Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("Bonjour .Je viens pas la suite demandé",style: TextStyle(fontSize: 20),),),

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
