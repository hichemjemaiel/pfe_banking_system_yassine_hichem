import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Bar.dart';
import 'ABOne.dart';
import 'Atwo.dart';
import 'EBOne.dart';


class Aone extends StatefulWidget {
  const Aone({super.key});

  @override
  State<Aone> createState() => _AoneState();
}

class _AoneState extends State<Aone> {
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Atwo()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Aone()));
                      },
                      child:
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Ebone()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Abone()));
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
