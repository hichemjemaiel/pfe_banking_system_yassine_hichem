import 'package:flutter/material.dart';


import '../../../Bar.dart';
import '../virement vers autre compte/ABOne.dart';
import '../virement vers autre compte/AOne.dart';
import '../virement vers autre compte/Atwo.dart';
import '../virement vers autre compte/EBOne.dart';
import 'Pthree.dart';
import 'Ptwo.dart';

class Pone extends StatefulWidget {
  const Pone({super.key});

  @override
  State<Pone> createState() => _PoneState();
}

class _PoneState extends State<Pone> {
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
              Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Choisissez le canal\n       de virement",style: TextStyle(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Ptwo()));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/bank.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Bamboo",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 200),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Aone()));
                        },
                        child:
                        InkWell(
                          onTap: (){
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Ebone()));
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
                                Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/bank.png",scale: 1.5,),),
                                Padding(padding: EdgeInsets.only(left: 20),child: Text("EcoBank",style: TextStyle(
                                    fontSize: 20
                                ),),),
                                Padding(padding: EdgeInsets.only(left: 190),child: Icon(Icons.arrow_forward_ios),),
                              ],
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Pthree()));
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
                            Padding(padding: EdgeInsets.only(left: 10),child: Image.asset("assets/bank.png",scale: 1.5,),),
                            Padding(padding: EdgeInsets.only(left: 20),child: Text("Autres banques",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 120),child: Icon(Icons.arrow_forward_ios),),
                          ],
                        ),
                      ),
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
