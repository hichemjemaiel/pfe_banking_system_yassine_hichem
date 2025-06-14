import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/AgencyProvider.dart';

import 'package:pfe_banking_system/screens/CreationParticulier/provider/DepositAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/SavingAccountProvider.dart';

import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticulierSeven.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticuliereight.dart';
import 'package:provider/provider.dart';

import '../provider/LesDeuxAccountProvider.dart';

class Creationparticuliersix extends StatefulWidget {
  String email;
   Creationparticuliersix({super.key, required this.email});

  @override
  State<Creationparticuliersix> createState() => _CreationparticuliersixState();
}

class _CreationparticuliersixState extends State<Creationparticuliersix> {
  int index = -1;
  int selectedAgencyIndex = -1;
  int pindex = -1;
  @override
  void initState() {
    Provider.of<AgencyProvider>(context,listen: false).getAllAgencies();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    List<AgencyModel> agencies = Provider.of<AgencyProvider>(context).agencies;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        actions: [
          Padding(padding: EdgeInsets.only(right: 350),child: Image.asset("assets/bambo.png"),),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height+280,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 30,left: 60),child: Row(

                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container(
                    width: 20,height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xFF707070),

                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container(
                    width: 20,height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xFF707070),

                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container(
                    width: 20,height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xFF707070),

                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container(
                    width: 20,height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xFF707070),

                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container(
                    width: 20,height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xFF707070),

                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF6C6C6C),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                  Container(
                    width: 20,height: 3,
                    decoration: BoxDecoration(
                      color: Color(0xFF707070),

                    ),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFF6C6C6C),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),


                ],
              ),),
              Padding(padding: EdgeInsets.only(right: 190,top: 20),child: Text("Offres & domiciliation",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),),

              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Choisissez votre agence de préférence \net l'offre qui vous convient",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ExpansionTile(title:  selectedAgencyIndex  == -1 ?Text("Choisissez votre agence") : Text("Agence : ${selectedAgencyIndex}"),
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: agencies.length,
                            itemBuilder: (BuildContext context , int index){
                              return ListTile(
                                onTap: (){
                                  setState(() {
                                    selectedAgencyIndex = agencies[index].id!;
                                  });
                                },
                                title: Text("agence : ${agencies[index].id}"),
                              );
                            }),
                      )
                  ],),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(padding: EdgeInsets.only(right: 120),child: Text("Choisissez votre compte",style: TextStyle(
                  fontSize: 20
              ),),),
              SizedBox(height: 10,),
              Padding(padding: EdgeInsets.all(10),child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap:(){
                      setState(() {
                        index =0;
                      });
                    },
                    child:Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: index == 0 ? Color(0xFF4A9E1F) : Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Courant"),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        index = 1;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: index == 1 ? Color(0xFF4A9E1F)  : Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Epargne"),
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        index  = 2;

                      });
                    },
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                          color: index == 2 ? Color(0xFF4A9E1F) : Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Les deux"),
                      ),
                    ),
                  ),
                ],
              ),),
              Padding(padding: EdgeInsets.only(top: 20,right: 105),child: Text("Choisissez votre package",style: TextStyle(
                  fontSize: 20
              ),),),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(padding: EdgeInsets.all(20),child: index == 1 ? Epargne() : Row(
                  children: [
                     InkWell(
                       onTap: (){
                         setState(() {

                           pindex =0;

                         });
                       },
                       child: Container(
                         height: 280,
                         width: 380,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(10),
                           border: pindex ==0 ? Border.all(color: Color(0xFF4A9E1F),width: 3):null,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black.withOpacity(0.3),
                               spreadRadius: 2,
                               blurRadius: 8,
                               offset: Offset(4, 4),
                             ),
                           ],
                         ),
                         child: SingleChildScrollView(
                           scrollDirection: Axis.horizontal,

                           child:
                           Row(
                             children: [
                               Container(
                                 height: 280,
                                 width: 100,
                                 decoration: BoxDecoration(
                                   color: Color(0xFF4A9E1F),
                                   borderRadius: BorderRadius.circular(10),
                                   border: pindex ==0 ? Border.all(color: Color(0xFF4A9E1F),width: 3):null,
                                 ),
                                 child: Center(
                                   child:RotatedBox(quarterTurns: 3,child: Text("Initiative",style: TextStyle(
                                       fontWeight: FontWeight.bold,
                                       fontSize: 25,
                                       color: Colors.white
                                   ),),),
                                 ),
                               ),

                               Column(
                                 children: [
                                   Padding(padding: EdgeInsets.only(top:10,left: 20,right: 30),child: Text("Un accompagnement\nadapté au lancement\nde vos activités",style: TextStyle(
                                       fontSize: 18
                                   ),),),
                                   Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("-Dépot initial (35 000 XAF)\n-Crédit jusqu'à 10 Millions\n-Chéquier (25 feuillets)\n-Carte visa prépayée\n-Online Banking",style: TextStyle(fontSize: 18,color: Color(0xFF4A9E1F)),),),
                                   Padding(padding: EdgeInsets.only(top: 10,right: 25),child: Text("10 000 Fcfa/ mois",style: TextStyle(
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold
                                   ),),),
                                 ],
                               ),
                             ],
                           ),




                         ),
                       ),
                     ),

                    SizedBox(width: 40,),

                      InkWell(
                        onTap: (){
                          setState(() {
                            pindex =1;
                          });
                        },
                        child: Container(
                          height: 280,
                          width: 380,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: pindex ==1 ? Border.all(color: Color(0xFF4A9E1F),width: 3):null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,

                            child:
                            Row(
                              children: [
                                Container(
                                  height: 280,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(10),
                                    border:  pindex ==1 ? Border.all(color: Color(0xFF4A9E1F),width: 3):null,
                                  ),
                                  child: Center(
                                    child:RotatedBox(quarterTurns: 3,child: Text("Boost",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white
                                    ),),),
                                  ),
                                ),

                                Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top:10,left: 20,right: 30),child: Text("Boostez votre croissance\net sécurisez vos avoirs",style: TextStyle(
                                        fontSize: 18
                                    ),),),
                                    Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("-Dépot initial (13 000 XAF)\n-Dépot /Retrait via Mobile\nMoney\n-Carte visa prépayée\n-Online Banking",style: TextStyle(fontSize: 18,color: Color(0xFF4A9E1F)),),),
                                    Padding(padding: EdgeInsets.only(top: 10,right: 25),child: Text("5 000 XAF/ mois",style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),),),
                                  ],
                                ),
                              ],
                            ),




                          ),
                        ),

                      ),
                    SizedBox(width: 40,),
                     InkWell(
                       onTap: (){
                         setState(() {
                           pindex =2;
                         });
                       },
                       child: Container(
                         height: 280,
                         width: 380,
                         decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.circular(10),
                           border : pindex ==2 ? Border.all(color: Color(0xFF4A9E1F),width: 3):null,
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black.withOpacity(0.3),
                               spreadRadius: 2,
                               blurRadius: 8,
                               offset: Offset(4, 4),
                             ),
                           ],
                         ),
                         child: SingleChildScrollView(
                           scrollDirection: Axis.horizontal,

                           child:
                           Row(
                             children: [
                               Container(
                                   height: 280,
                                   width: 100,
                                   decoration: BoxDecoration(
                                       color: Color(0xFF4A9E1F),
                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                   child: Center(
                                     child:RotatedBox(quarterTurns: 3,child: Text("Envergure",style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontSize: 25,
                                         color: Colors.white
                                     ),),),
                                   )
                               ),

                               Column(
                                 children: [
                                   Padding(padding: EdgeInsets.only(top:10,left: 20,right: 30),child: Text("Boostez votre croissance\net sécurisez vos avoirs",style: TextStyle(
                                       fontSize: 18
                                   ),),),
                                   Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("-Dépot initial (13 000 XAF)\n-Dépot /Retrait via Mobile\nMoney\n-Carte visa prépayée\n-Online Banking",style: TextStyle(fontSize: 18,color: Color(0xFF4A9E1F)),),),
                                   Padding(padding: EdgeInsets.only(top: 10,right: 25),child: Text("10 000 XAF/ mois",style: TextStyle(
                                       fontSize: 20,
                                       fontWeight: FontWeight.bold
                                   ),),),
                                 ],
                               ),
                             ],
                           ),




                         ),
                       ),
                     ),


                  ],
                )),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  InkWell(
                    onTap: () {
                      if(selectedAgencyIndex != -1){
                        if(index ==0){
                          if(pindex ==0){
                            Provider.of<DepositAccountProvider>(context,listen: false).setPack(pack: "Initiative");
                          }
                          if(pindex ==1){
                            Provider.of<DepositAccountProvider>(context,listen: false).setPack(pack: "Boost");
                          }
                          if(pindex ==2){
                            Provider.of<DepositAccountProvider>(context,listen: false).setPack(pack: "Envergure");
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Creationparticulierseven(agencyIndex: selectedAgencyIndex.toString(),email:widget.email)));
                        }else if(index ==1){
                          Provider.of<SavingAccountProvider>(context,listen: false).setPack(pack: "Epargne libre");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Creationparticulierseven(agencyIndex: selectedAgencyIndex.toString(),email:widget.email)));
                        }else if(index ==2){
                          if(pindex ==0){
                            Provider.of<LesDeuxAccountProvider>(context,listen: false).setPack(pack: "Initiative");
                          }
                          if(pindex ==1){
                            Provider.of<LesDeuxAccountProvider>(context,listen: false).setPack(pack: "Boost");
                          }
                          if(pindex ==2){
                            Provider.of<LesDeuxAccountProvider>(context,listen: false).setPack(pack: "Envergure");
                          }
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Creationparticulierseven(agencyIndex: selectedAgencyIndex.toString(),email:widget.email)));
                        }
                      }

                    },
                    child: Container(
                      width: 150,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("Suivant",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20
                        ),),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),

            ],
          ),
        ),
      )
    );
  }
  Widget Epargne(){
    return Row(
      children: [
        InkWell(
          onTap: (){
            setState(() {

              pindex =0;

            });
          },
          child: Container(
            height: 280,
            width: 380,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: pindex ==0 ? Border.all(color: Color(0xFF4A9E1F),width: 3):null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child:
              Row(
                children: [
                  Container(
                    height: 280,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10),
                      border: pindex ==0 ? Border.all(color: Color(0xFF4A9E1F),width: 3):null,
                    ),
                    child: Center(
                      child:RotatedBox(quarterTurns: 3,child: Text("Epargne libre",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white
                      ),),),
                    ),
                  ),

                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top:30,left: 20,right: 30),child: Text("Assurez votre avenir en toute\nsérénité grace à notre compte\népargne sans frais de gestion",style: TextStyle(
                          fontSize: 18
                      ),),),

                      Padding(padding: EdgeInsets.only(top: 110,right:100),child: Text("0 Fcfa/ mois",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),),
                    ],
                  ),
                ],
              ),




            ),
          ),
        ),




      ],
    );
  }
}
