import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EpargneProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/AddShopping.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/BudgetEpargne.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/addEpargne.dart';
import 'package:provider/provider.dart';

import 'BudgetShopping.dart';

class Epargne extends StatefulWidget {
  int? id ;
   Epargne({super.key,  this.id});

  @override
  State<Epargne> createState() => _EpargneState();
}

class _EpargneState extends State<Epargne> {
  @override
  void initState() {
    Provider.of<EpargneProviderDTO>(context,listen: false).getAllEpargens(widget.id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<EpargneDTO> epargnes = Provider.of<EpargneProviderDTO>(context).epargnes;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Statistiques"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => addEpargne(id : widget.id!)));
            },
            child:  Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.add,size: 30,),),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 50,top: 40),child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Image.asset("assets/house.png",scale: 1.5,),
                ),
              ),),
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 80,top: 60),child: Text("Epargne",style: TextStyle(
                      fontSize: 18
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 50),child: Text("50 000 XAF",style: TextStyle(
                      fontSize: 18
                  ),),),
                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.only(left: 30),child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetEpargne()));
                    },
                    child: Text("+ Définir un budget",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 18),),
                  ),)
                ],
              ),

            ],
          ),
          SizedBox(height: 40,),
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height-300,
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  SizedBox(
                    height: 600,
                    child: ListView.builder(
                        itemCount: epargnes.length,
                        itemBuilder: (BuildContext context , int index){
                          return Padding(padding: EdgeInsets.all(20),child:  Container(
                            width: 400,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Padding(padding: EdgeInsets.only(left: 10),child : Icon(Icons.remove_circle,color: Colors.red,size: 40,),),
                                Column(
                                  children: [
                                    Padding(padding: EdgeInsets.only(top: 10,right: 80),child:  Text("${epargnes[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                                    Padding(padding: EdgeInsets.only(left: 10),child: Text("${epargnes[index].date} à ${epargnes[index].time}",style: TextStyle(fontSize: 18),),),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(left: 50),child:  Text("-${epargnes[index].amount} FCFA",style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),),
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ));
                        }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
