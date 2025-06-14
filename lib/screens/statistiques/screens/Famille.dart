import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/FamilleproviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/AddFamille.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/AddShopping.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/BudgetEspeces.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/BudgetFamille.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/addEspeces.dart';
import 'package:provider/provider.dart';

import 'BudgetShopping.dart';

class Famille extends StatefulWidget {
  int? id ;
  Famille({super.key, this.id});

  @override
  State<Famille> createState() => _FamilleState();
}

class _FamilleState extends State<Famille> {
  @override
  void initState() {
    Provider.of<FamilleProviderDTO>(context,listen: false).getAllEpargens(widget.id!);
    super.initState();
  }

  // Helper method to format date and time
  String formatDateTime(String date, String time) {
    return "$date à $time";
  }

  // Helper method to format amount
  String formatAmount(int amount) {
    return "-$amount FCFA";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FamilleProviderDTO>(
      builder: (context, familleProvider, child) {
        List<FamilleDTO> familles = familleProvider.familles;

        return Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          appBar: AppBar(
            backgroundColor: Color(0xFFF2F2F2),
            title: Text("Statistiques"),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => addFamille(id : widget.id!)));
                },
                child:  Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.add,size: 30,),),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 50,top: 40),child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Image.asset("assets/group.png",scale: 1.5,),
                      ),
                    ),),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(right: 90,top: 60),child: Text("Famille",style: TextStyle(
                            fontSize: 18
                        ),),),
                        Padding(padding: EdgeInsets.only(right: 55),child: Text("50 000 XAF",style: TextStyle(
                            fontSize: 18
                        ),),),
                        SizedBox(height: 10,),
                        Padding(padding: EdgeInsets.only(left: 30),child:  InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetFamille()));
                          },
                          child: Text("+ Définir un budget",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 18),),
                        ),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height-300,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      // Show message when no family expenses available
                      if (familles.isEmpty)
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.family_restroom_outlined,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Aucune dépense familiale enregistrée",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Ajoutez votre première dépense familiale",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      // Display the list of family expenses
                      else
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              itemCount: familles.length,
                              itemBuilder: (BuildContext context , int index){
                                FamilleDTO famille = familles[index];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: InkWell(
                                    onTap: () {
                                      // Add navigation to family expense details if needed
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => FamilleDetails(famille: famille)));
                                    },
                                    child: Container(
                                      width: 400,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Icon(Icons.remove_circle,color: Colors.red,size: 40,),
                                            SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    famille.name, // Family expense description
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    formatDateTime(famille.date, famille.time), // Date and time
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  formatAmount(famille.amount), // Family expense cost
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}