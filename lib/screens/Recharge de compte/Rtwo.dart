import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Recharge%20de%20compte/Rfive.dart';
import 'package:pfe_banking_system/screens/Recharge%20de%20compte/Rfour.dart';
import 'package:pfe_banking_system/screens/Recharge%20de%20compte/Rthree.dart';

import '../Bar.dart';
import '../CodeVerif.dart';

class Rtwo extends StatefulWidget {
  const Rtwo({super.key});

  @override
  State<Rtwo> createState() => _RtwoState();
}

class _RtwoState extends State<Rtwo> {
  int index = 0;
  int ind = -1;
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
        title: Text("Recharge de carte"),
        centerTitle: true,
      ),
      body: index == 1 ? tier(context) : SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height+250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              index =0;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: index == 0 ? Color(0xFF4A9E1F) :Colors.grey,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text("Ma carte ",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              index =1;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: index == 1 ? Color(0xFF4A9E1F) :Colors.grey,
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: Center(
                              child: Text("Un tiers ",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Padding(padding: EdgeInsets.only(right: 220),child: Text("Compte a débiter",style: TextStyle(
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
                            onTap: (){
                              setState(() {
                                ind = 0;
                              });
                            },
                            title: Text("UBA Gabon"),
                          ),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  ind =1;
                                });
                              },
                              title: Text("ORABANK Gabon"),
                            ),
                            ListTile(
                              onTap: (){
                                setState(() {
                                  ind = 2;
                                });
                              },
                              title: Text("Ecobank"),
                            )
                          ],),

                    ),
                  ),
                  SizedBox(height: 40,),
                  Padding(padding: EdgeInsets.only(right: 220),child: Text("Carte a créditer",style: TextStyle(
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
                  Padding(padding: EdgeInsets.only(right: 220),child: Text("Nom du porteur",style: TextStyle(
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
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none
                            ),
                            hintText: "Cliquer pour saisir le montant"
                          ),
                        ))

                  ),
                  SizedBox(height: 20,),
                  Padding(padding: EdgeInsets.only(right: 280),child: Text("Montant",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none
                              ),
                              hintText: "50 000",
                              suffixIcon: Padding(padding: EdgeInsets.only(top: 10),child: Text("XAF",style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 18
                              ),),)
                            ),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Solde disponible 300 000 XAF",style: TextStyle(
                              fontSize: 20,

                              color: Colors.white
                            ),),
                          ),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height: 100,),
                  InkWell(
                    onTap: (){
                      if(ind ==0){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rthree()));
                      }else if(ind ==1){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rfive()));
                      }
                      else if(ind ==2){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rfour()));
                      }
                    },
                    child: Container(
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
  Widget tier(BuildContext context){
    return SingleChildScrollView(
        child:Column(
          children: [
            SizedBox(height: 50,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height+100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              index =0;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: index == 0 ? Color(0xFF4A9E1F) :Colors.grey,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Text("Ma carte ",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              index =1;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                                color: index == 1 ? Color(0xFF4A9E1F) :Colors.grey,
                                borderRadius: BorderRadius.circular(10)

                            ),
                            child: Center(
                              child: Text("Un tiers ",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 50,),
                  Padding(padding: EdgeInsets.only(right: 220),child: Text("Compte a débiter",style: TextStyle(
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
                  Padding(padding: EdgeInsets.only(right: 220),child: Text("Carte a créditer",style: TextStyle(
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
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintText: "50 000",
                                suffixIcon: Padding(padding: EdgeInsets.only(top: 10),child: Text("XAF",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 18
                                ),),)
                            ),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Solde disponible 300 000 XAF",style: TextStyle(
                                fontSize: 20,

                                color: Colors.white
                            ),),
                          ),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height:70,),
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
    );
  }
}
