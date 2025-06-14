import 'package:flutter/material.dart';

import '../../Bar.dart';

class Rctwo extends StatefulWidget {
  String type;
  String objet;
  String description;

   Rctwo( {required this.type , required this.objet , required this.description ,super.key});

  @override
  State<Rctwo> createState() => _RctwoState();
}

class _RctwoState extends State<Rctwo> {
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
        title: Text("Détail de la réclamation"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height-100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Type de réclamation",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("Mise a disposition de chéquier",style: TextStyle(fontSize: 20),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 320,top: 40),child: Text("Objet",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text("${widget.objet}",style: TextStyle(fontSize: 20),),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 260,top: 40),child: Text("Description",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(padding: EdgeInsets.all(20),child: Text("${widget.description}",style: TextStyle(fontSize: 20),),),
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
