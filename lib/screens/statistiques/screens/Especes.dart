import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EspecesProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/AddShopping.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/BudgetEspeces.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/addEspeces.dart';
import 'package:provider/provider.dart';

import 'BudgetShopping.dart';

class Especes extends StatefulWidget {
  int? id ;
   Especes({super.key, this.id});

  @override
  State<Especes> createState() => _EspecesState();
}

class _EspecesState extends State<Especes> {
  @override
  void initState() {
    Provider.of<EspecesProviderDTO>(context,listen: false).getAllEpargens(widget.id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<EspecesDTO> especes = Provider.of<EspecesProviderDTO>(context).especes;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Statistiques"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => addEspeces(id : widget.id!)));
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
                    color: Colors.green[600],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Image.asset("assets/expense.png",scale: 1.5,),
                ),
              ),),
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 70,top: 60),child: Text("Especes",style: TextStyle(
                      fontSize: 18
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 50),child: Text("50 000 XAF",style: TextStyle(
                      fontSize: 18
                  ),),),
                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.only(left: 30),child:  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetEspeces()));
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
                  SizedBox(
                    height: 600,
                    child: ListView.builder(
                        itemCount: especes.length,
                        itemBuilder: (BuildContext context ,int index){
                          return Padding(padding: EdgeInsets.all(20),child: Container(
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
                                    Padding(padding: EdgeInsets.only(top: 10,right: 80),child:  Text("${especes[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
                                    Padding(padding: EdgeInsets.only(left: 20),child: Text("${especes[index].date} ${especes[index].time}",style: TextStyle(fontSize: 18),),),
                                  ],
                                ),
                                Padding(padding: EdgeInsets.only(left: 100),child:  Text("-${especes[index].amount}",style: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.bold),),),
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),);
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
