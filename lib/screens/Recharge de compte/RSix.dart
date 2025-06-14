import 'package:flutter/material.dart';

import '../Bar.dart';
import '../CodeVerif.dart';

class Rsix extends StatefulWidget {
  const Rsix({super.key});

  @override
  State<Rsix> createState() => _RsixState();
}

class _RsixState extends State<Rsix> {
  int index =0;
  int myIndex = 0;
  void showConfirmationDialog(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return SingleChildScrollView(
            child: Container(
              height : MediaQuery.sizeOf(context).height+100,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("Récapitulatifs du virement",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  SizedBox(height: 30,),
                  Text("Compte  a débiter             Compte Courant",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Carte a créditer                 **** *** *** 055",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Banque emettrice                                   UBA",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Nom du porteur                Yao Boris Kedake",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Montant                                     20 000 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Frais                                              1800 XAF",style: TextStyle(fontSize: 20),),

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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverif()));
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
        title: Text("Décharge de carte"),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height+400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [


                  SizedBox(height: 50,),
                  Padding(padding: EdgeInsets.only(right: 220),child: Text("Compte a créditer",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                        child: ExpansionTile(title: Text("Cliquer pour sélectionner"))
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(padding: EdgeInsets.only(right: 220),child: Text("Banque émettrice",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,

                    decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child:  ExpansionTile(title: Text("Cliquer pour sélectionner"),children: [
                        ListTile(
                          title: Text("UBA Gabon"),
                        ),
                        ListTile(
                          title: Text("ORABANK Gabon"),
                        ),
                        ListTile(
                          title: Text("Ecobank"),
                        )
                      ],),

                    ),
                  ),
                  SizedBox(height: 40,),
                  Padding(padding: EdgeInsets.only(right: 230),child: Text("Carte a débiter",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                        child: ExpansionTile(title: Text("Cliquer pour sélectionner"))
                    ),
                  ),

                  SizedBox(height: 20,),


                  Padding(padding: EdgeInsets.only(right: 280),child: Text("Montant",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none
                          ),
                          hintText: "Cliquer pour saisir le montant",
                          suffixIcon: Padding(padding: EdgeInsets.only(top: 20),child: Text("XAF",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 18
                          ),),)
                      ),
                    ),
                  ),
                  SizedBox(height: 100,),
                  InkWell(
                    onTap: (){
                      showConfirmationDialog(context);
                    },
                    child:  Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Suivant",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
      ),
    );
  }
}
