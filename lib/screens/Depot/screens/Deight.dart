import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dnine.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dthret.dart';

class Deight extends StatefulWidget {
  const Deight({super.key});

  @override
  State<Deight> createState() => _DeightState();
}

class _DeightState extends State<Deight> {
  int ind = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Versement a la banque"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height-100,
              decoration: BoxDecoration(
                  color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color:Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              ind =0;
                            });
                          }
                          ,child: Container(
                            height: 70,
                            width: 150,
                            decoration: BoxDecoration(
                                color: ind == 0 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text("Au guichet",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              ind =1;
                            });
                          }
                          ,child: Container(
                          height: 70,
                          width: 150,
                          decoration: BoxDecoration(
                              color: ind == 1 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Au guichet",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60,),
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.purple[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 70,),
                        Text("Choisissez la banque ou vous allez faire le\nversement",style: TextStyle(
                          fontSize: 16
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 70,),
                        Text("Effectuez le virement en choisissant\nl'une des options disponibles",style: TextStyle(
                            fontSize: 16
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 70,),
                        Text("Entrez le montant viré depuis votre\ncompte bancaire",style: TextStyle(
                            fontSize: 16
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 100,),
                  InkWell(
                    onTap: () {
                      if(ind ==1){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dnine()));
                      }else if(ind ==0){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dthret()));
                      }

                    }
                    ,child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text("J'ai compris",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
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
