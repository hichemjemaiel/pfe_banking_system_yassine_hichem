import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rctfour.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rcttwo.dart';

import '../../Bar.dart';

class Rctone extends StatefulWidget {
    int? id ;
   Rctone({super.key,  this.id});

  @override
  State<Rctone> createState() => _RctoneState();
}

class _RctoneState extends State<Rctone> {
  int myIndex =0;
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
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Carte prépayée"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 80,left: 1),child: Text("Choisissez une option pour continuer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
            SizedBox(height: 100,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height-100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                 InkWell(
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Rcttwo(id : widget.id)));
                   },
                   child:  Container(
                     width: 400,
                     height: 70,
                     decoration: BoxDecoration(
                         color: Color(0xFFF2F2F2),
                         borderRadius: BorderRadius.circular(20)
                     ),
                     child: Row(
                       children: [
                         SizedBox(width: 10,),
                         Image.asset("assets/card.png",scale: 1.5,),
                         SizedBox(width: 20,),
                         Text("Recharge de carte",style: TextStyle(fontSize: 20),),
                         SizedBox(width: 100,),
                         Icon(Icons.arrow_forward_ios)
                       ],
                     ),
                   ),
                 ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Rctfour(id : widget.id)));
                    },
                    child: Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          Image.asset("assets/card.png",scale: 1.5,),
                          SizedBox(width: 20,),
                          Text("Décharge de carte",style: TextStyle(fontSize: 20),),
                          SizedBox(width: 100,),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
