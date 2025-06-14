import 'package:flutter/material.dart';

import '../../Bar.dart';

class Hthree extends StatefulWidget {
  const Hthree({super.key});

  @override
  State<Hthree> createState() => _HthreeState();
}

class _HthreeState extends State<Hthree> {
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
        title: Text("Extrait de compte"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  SizedBox(height: 30,),
                  Text("Selectionner l'intervalle sur lequel vous\nsouhaitez générer votre extrait de compte",style: TextStyle(

                    fontSize: 20
                  ),),
                  Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Date de début",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color:Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Text("30/12/2024",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),),
                        SizedBox(width: 220,),
                        Icon(Icons.calendar_month),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 270,top: 20),child: Text("Date de fin",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color:Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Text("30/12/2024",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),
                        SizedBox(width: 220,),
                        Icon(Icons.calendar_month),
                      ],
                    ),
                  ),
                  SizedBox(height: 60,),
                  Padding(padding: EdgeInsets.only(right: 5),child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text("Valider",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
