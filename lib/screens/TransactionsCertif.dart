import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';

class Transactionscertif extends StatefulWidget {
  const Transactionscertif({super.key});

  @override
  State<Transactionscertif> createState() => _TransactionscertifState();
}

class _TransactionscertifState extends State<Transactionscertif> {
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
                  Padding(padding: EdgeInsets.only(left: 100,top: 20),child: Row(
                    children: [
                      Icon(Icons.security,size: 40,color: Colors.green,),
                      SizedBox(width: 10,),
                      Text("Transaction certifiée\npar Bamboo Sentinelle",style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold
                      ),)
                    ],
                  ),),
                  Padding(padding: EdgeInsets.only(top: 40,left: 10),child:                 Text("Votre paiement à été effectué avec succès.\nConsultez votre Historique pour vérifier le\n               statut de votre transaction",
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                    ,),
                  Text("------------------------------------------------------------------",style: TextStyle(fontSize: 20),),
                  Padding(padding: EdgeInsets.only(left: 30),child: Row(
                    children: [
                      Text("Type d'opération",style: TextStyle(fontSize: 20),),
                      SizedBox(width: 60,),
                      Text("Paiement Marchand",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),),
                  SizedBox(height: 20,),
                  Padding(padding: EdgeInsets.only(left: 30),child: Row(
                    children: [
                      Text("Montant",style: TextStyle(fontSize: 20),),
                      SizedBox(width: 210,),
                      Text("50 000 XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),),
                  SizedBox(height: 20,),
                  Padding(padding: EdgeInsets.only(left: 30),child: Row(
                    children: [
                      Text("Date",style: TextStyle(fontSize: 20),),
                      SizedBox(width: 165,),
                      Text("16/06/2023 à 10H04",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),),
                  SizedBox(height: 20,),
                  Padding(padding: EdgeInsets.only(left: 30),child: Row(
                    children: [
                      Text("Motifs",style: TextStyle(fontSize: 20),),
                      SizedBox(width: 270,),
                      Text("Autres",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),),
                  SizedBox(height: 20,),
                  Padding(padding: EdgeInsets.only(left: 30),child: Row(
                    children: [
                      Text("Référence",style: TextStyle(fontSize: 20),),
                      SizedBox(width: 200,),
                      Text("648303572",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                    ],
                  ),),
                  SizedBox(height: 30,),
                  Container(
                    width: 280,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(padding: EdgeInsets.only(left: 20),child: Row(
                      children: [
                        Icon(Icons.history,size: 30,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("Consulter l'historique",style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),),
                  ),
                  SizedBox(height: 20,),
                  Container(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
