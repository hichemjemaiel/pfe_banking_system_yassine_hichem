import 'package:flutter/material.dart';

class Four extends StatefulWidget {
  const Four({super.key});

  @override
  State<Four> createState() => _FourState();
}

class _FourState extends State<Four> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Ismael"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(left: 22),child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(50),

            ),
          ),),
          Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Actif",style: TextStyle(
            fontSize: 20,
          ),),),
          Padding(padding: EdgeInsets.only(left: 30),child: Text("Libreville, Gabon",style: TextStyle(fontSize: 20),),),
          Padding(padding: EdgeInsets.only(left: 30,top: 10),child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text("3 juil.2024",style:TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
            ),
          ),),
          SizedBox(height: 40,),
          Padding(padding: EdgeInsets.only(left: 20),child: Container(
            width: 400,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child:Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Bonjour Mr Yao comment pouvons\nnous vous aider ?",style: TextStyle(fontSize: 18),),),
          ),),
          Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Container(
            width: 300,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10)
            ),
            child:Padding(padding: EdgeInsets.only(top: 20,left: 20),child:  Text("Dépot ou retrait sur compte",style: TextStyle(fontSize: 18),),),
          ),),
          Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
            width: 400,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child:Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("D'accord Mr Yao choisissez l'une des options Suivantes s'il vous palit",style: TextStyle(fontSize: 18),),),
          ),),
          Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Container(
            width: 300,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.green[200],
                borderRadius: BorderRadius.circular(10)
            ),
            child:Padding(padding: EdgeInsets.only(top: 20,left: 20),child:  Text("Echec de depot sur mon compte",style: TextStyle(fontSize: 18),),),
          ),),
          Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
            width: 400,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child:Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Bonjour je suis Ismael\nJ'ai l'honneur de prendre votre requete",style: TextStyle(fontSize: 18),),),
          ),),
          SizedBox(height: 50,),
          Padding(padding: EdgeInsets.only(top: 20,left: 10),child: Container(
            width: 420,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none
                    ),
                    hintText: "Cliquez pour saisir",
                    suffixIcon: Icon(Icons.send)
                ),
              ),
            ),
          ),),
        ],
      ),
    );
  }
}
