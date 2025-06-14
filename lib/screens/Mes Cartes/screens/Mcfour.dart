import 'package:flutter/material.dart';

import '../../Bar.dart';

class Mcfour extends StatefulWidget {
  const Mcfour({super.key});

  @override
  State<Mcfour> createState() => _McfourState();
}

class _McfourState extends State<Mcfour> {
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
      body: Column(
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
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  top: -100,
                  left: 120,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),

                    ),
                      child:  Image.asset("assets/cancell.gif",scale: 8,fit: BoxFit.contain),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
