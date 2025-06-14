import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/DnineT.dart';

import '../../CodeVerif.dart';

class Deightt extends StatefulWidget {
  const Deightt({super.key});

  @override
  State<Deightt> createState() => _DeighttState();
}

class _DeighttState extends State<Deightt> {
  bool clicked = false;
  void showConfirmationDialog(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return SingleChildScrollView(
            child: Container(
              height: 800,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Text("Récapitulatif",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  SizedBox(height: 30,),
                  Text("Canal d'opération                Visa/Mastercard",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Compte a créditer     Courant | 000563862 ",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),

                  Text("Montant                                    300 000 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Frais                                              2000 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Montant total                             52 000 XAF",style: TextStyle(fontSize: 20),),


                  Padding(padding: EdgeInsets.only(top: 70,left: 60),child:
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child:
                          InkWell(
                            onTap: (){

                            },
                            child: Text("Annuler",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverif()));
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Dninet()));
                        },
                        child:  Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child:
                            Text("Valider",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Dépot via carte"),
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
                  Padding(padding: EdgeInsets.only(right: 200,top: 20),child: Text("Compte a créditer",style: TextStyle(
                    fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: ExpansionTile(title: Text("Cliquer pour selectionner")),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 280,top: 20),child: Text("Montant",style: TextStyle(
                    fontSize: 20,
                  ),),),
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "300 000",
                                  suffixIcon: Padding(padding: EdgeInsets.only(top: 10,right: 20),child: Text("XAF",style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),),),
                              ),
                            ),
                          )
                        ),
                        Container(
                          width: 400,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Text("Solde disponible: 800 000 XAF",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                            ),),
                          ),
                        ),

                      ],
                    ),
                  ),
                 Padding(padding: EdgeInsets.only(left: 20,top: 40),child:  Row(children: [
                   InkWell(
                     onTap: (){
                       setState(() {
                         clicked == false ? clicked = true : clicked = false;
                       });
                     }
                     ,child: Container(
                       width: 40,
                       height: 40,
                       decoration: BoxDecoration(
                           color: !clicked ? Colors.grey[300] : Color(0xFF4A9E1F),
                           borderRadius: BorderRadius.circular(10)
                       ),
                     ),
                   ),
                   SizedBox(width: 10,),
                   Text("Inclure les frais",style: TextStyle(
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.green
                   ),)
                 ],),),
                  SizedBox(height: 60,),
                  InkWell(
                    onTap: (){
                      showConfirmationDialog(context);
                    },
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Continuer",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  )
                ],

              ),
            ),
          ],
        ),
      )
    );
  }
}
