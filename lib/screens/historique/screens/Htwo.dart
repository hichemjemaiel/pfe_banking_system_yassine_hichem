import 'package:flutter/material.dart';

import '../../Bar.dart';

class Htwo extends StatefulWidget {
  const Htwo({super.key});

  @override
  State<Htwo> createState() => _HtwoState();
}

class _HtwoState extends State<Htwo> {
  int ind = -1;
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
        title: Text("Historique des opérations"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(right: 5),child: Icon(Icons.add_circle,color: Colors.green,size: 35,),),
            Padding(padding: EdgeInsets.only(left: 20),child: Text("500 000 XAF",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),),),
            Padding(padding: EdgeInsets.only(left: 10),child: Text("VIR.RECU Viny NDOLO EMANE",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),),

            SizedBox(height: 20,),
             details(context)
          ],
        ),
      ),
    );

  }
  Widget details(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height-100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
      ),
      child: Column(
        children: [

          Padding(padding: EdgeInsets.only(left: 50,top: 40),child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 170),child: Text("Détails de la transaction",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 20,top: 15),child: Text("Montant reçu                        500 000 XAF",style: TextStyle(
                    fontSize: 20,
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 20,top: 10),child: Text("Bénéficaire                     Yao Boris Kedake",style: TextStyle(
                    fontSize: 20,
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 20,top: 10),child: Text("RIB                               562143812287752",style: TextStyle(
                    fontSize: 20,
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 20,top: 10),child: Text("Motifs                                         Transport",style: TextStyle(
                    fontSize: 20,
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 5,top: 10),child: Text("Date de transaction   01/09/2022 a 10h55",style: TextStyle(
                    fontSize: 20,
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 320,top: 10),child: Text("Note :",style: TextStyle(
                    fontSize: 20,
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 30,top: 20),child: Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),
                            hintText: "Ajoutez une note pour plus tard"
                        ),
                      ),
                    ),
                  ),),
                  SizedBox(height: 40,),
                  Padding(padding: EdgeInsets.only(right: 40),child: Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text("Annuler l'opération",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),),
            ],
          )),
        ]
      ),
    );
  }
}
