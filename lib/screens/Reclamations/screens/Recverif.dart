import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/Reclamations/screens/RcOne.dart';

class RecVerif extends StatefulWidget {
  int? id;
   RecVerif({super.key,   this.id});

  @override
  State<RecVerif> createState() => _RecVerifState();
}

class _RecVerifState extends State<RecVerif> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (int index){
        setState(() {
          myIndex = index;
        });
      }),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Stack(
              children: [
                Image.asset("assets/conf.gif"),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height-347,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 100,top: 200),child: Row(
                    children: [
                      Icon(Icons.security,size: 40,color: Colors.green,),
                      SizedBox(width: 10,),
                      Text("Réclamation certifiée\npar Bamboo Sentinelle",style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),),
                  Padding(padding: EdgeInsets.only(top: 40,left: 10),child:                 Text("Votre Reclamation à été effectué avec succès",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ,),


                  SizedBox(height: 200,),
                 InkWell(
                   onTap: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Rcone(id : widget.id!)));
                   },
                   child:  Container(
                     width: 280,
                     height: 50,
                     decoration: BoxDecoration(
                         color: Color(0xFF4A9E1F),
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: Padding(padding: EdgeInsets.only(left: 20),child: Row(
                       children: [
                         Icon(Icons.wallet,size: 30,color: Colors.white,),
                         SizedBox(width: 10,),
                         Text("Nouvelle opération",style: TextStyle(
                             fontSize: 20,
                             color: Colors.white,
                             fontWeight: FontWeight.bold
                         ),)
                       ],
                     ),),
                   ),
                 ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
