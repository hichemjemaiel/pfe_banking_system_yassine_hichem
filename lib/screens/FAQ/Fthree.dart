import 'package:flutter/material.dart';

class Fthree extends StatefulWidget {
  const Fthree({super.key});

  @override
  State<Fthree> createState() => _FthreeState();
}

class _FthreeState extends State<Fthree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Nouvelle conversations"),
        centerTitle: true,

      ),
      body: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)
                ),
              ),Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20),child: Text("Priere de ne pas intier de nouvelle requetes\navant que celle-ci ne soit résolut",style: TextStyle(fontSize: 20),),),
          SizedBox(height: 20,),
          Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text("3 juil.2024",style:TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child:Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Bonjour Mr Yao comment pouvons\nnous vous aider ?",style: TextStyle(fontSize: 18),),),
          ),
          Padding(padding: EdgeInsets.only(right: 230,top: 10),child: Text("Priscillia il y a 2 min",style: TextStyle(fontSize: 15)),),
          Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Container(
            width: 300,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10)
            ),
            child:Padding(padding: EdgeInsets.only(top: 20,left: 20),child:  Text("Dépot ou retrait sur compte",style: TextStyle(fontSize: 18),),),
          ),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child:Padding(padding: EdgeInsets.only(top: 20,left: 20),child:  Text("Erreur de transaction",style: TextStyle(fontSize: 18),),),
              ),Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child:Padding(padding: EdgeInsets.only(top: 12,left: 20),child:  Text("Information sur Bamboo",style: TextStyle(fontSize: 18),),),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child:Padding(padding: EdgeInsets.only(top: 20,left: 20),child:  Text("Perte de carte",style: TextStyle(fontSize: 18),),),
              ),Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child:Padding(padding: EdgeInsets.only(top: 20,left: 20),child:  Text("Transaction Bancaire",style: TextStyle(fontSize: 18),),),
              ),
            ],
          )
        ],
      ),
    );
  }
}
