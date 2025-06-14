import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/screens/McOne.dart';

import '../../Bar.dart';

class Mcthree extends StatefulWidget {
  int? id ;
   Mcthree({super.key,  this.id});

  @override
  State<Mcthree> createState() => _McthreeState();
}

class _McthreeState extends State<Mcthree> {
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
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          SizedBox(height: 180,),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 700,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    SizedBox(height: 150,),
                    Text("L'ajout de votre carte a été\n    effectué avec succes",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 150,),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Mcone(id: widget.id!)));
                      },
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text("Quitter",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),)
                  ],
                ),
              ),
              Positioned(
                  top: -100,
                  left: 125,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: Image.asset("assets/conf.gif",fit: BoxFit.contain),
                  ))
            ],
          )
        ],
      ),
      ),
    );
  }
}
