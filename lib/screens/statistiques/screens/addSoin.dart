import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/ExpenseProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/MaxBudgetProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/ShoppingProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/Soinprovider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/TransportProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/Soin.dart';
import 'package:provider/provider.dart';

import '../provider/EpargneProvider.dart';

class addSoin extends StatefulWidget {
   int? id ;
   addSoin({super.key, required this.id});

  @override
  State<addSoin> createState() => _addSoinState();
}

class _addSoinState extends State<addSoin> {
  var key = GlobalKey<FormState>();
  int? BudgetId;
  String? expenseId ;
  TextEditingController montant = TextEditingController();
  TextEditingController nom = TextEditingController();
  DateTime now =DateTime.now();
  String formattedTime = DateFormat('HH:mm').format(DateTime.now());
  @override
  void initState() {
    getExistingBudget();
    super.initState();
  }
  Future<void> getExistingBudget()async{
    try{
      final result = await Provider.of<MaxBudgetProvider>(context,listen: false).getMaxBudgetByType("soin");
      if(result != null){
        setState(() {
          BudgetId = result.id;
        });
      }
    }catch(e){
      print("Error getting budget");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text("Ajout Transport"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: Padding(padding: EdgeInsets.only(top: 70),child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Form(
          key: key,
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(right: 120,top: 40),child: Text("Définissez le shopping item",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.only(right: 30,top: 20),child: Text("Fixez le monatant que vous souhaitez\nne pas dépasser",style: TextStyle(
                  fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.only(right: 320,top: 20),child: Text("Type",style: TextStyle(
                  fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: TextFormField(
                    controller: nom,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "This field must not be null";
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,

                        ),
                        hintText: "Type du soin"
                    ),
                  ),
                ),
              ),),
              Padding(padding: EdgeInsets.only(right: 280,top: 20),child: Text("Montant",style: TextStyle(
                  fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.only(right: 10,left:30,top: 20 ),child: TextFormField(
                controller: montant,
                validator: (value){
                  if(value ==  null || value.isEmpty){
                    return "This field must not be null";
                  }
                },
                decoration: InputDecoration(
                    fillColor: Colors.grey[200],
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    suffixText: "XAF",
                    hintText: "10 000"
                ),
              ),),
              SizedBox(height: 50,),
              InkWell(
                onTap: () async{
                  if(key.currentState!.validate()){
                    Provider.of<SoinProvider>(context,listen: false).setAmount(amount: int.parse(montant.text));
                    Provider.of<SoinProvider>(context,listen: false).setType();
                    Provider.of<SoinProvider>(context,listen: false).setName(name: nom.text);
                    Provider.of<SoinProvider>(context,listen: false).setTime(time: "${formattedTime}");
                    Provider.of<SoinProvider>(context,listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                    await Provider.of<SoinProvider>(context,listen: false).saveSoin();
                    final soin = Provider.of<SoinProvider>(context,listen: false).soin;
                    if(soin != null){
                      setState(() {
                        expenseId = soin.id.toString();
                      });
                    }
                    await Provider.of<ExpenseProvider>(context,listen: false).addExpenseToBankingAccount(widget.id.toString(), expenseId!);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Soin(id: widget.id!)));
                  }
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text("Confirmer",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              ),

            ],
          ),),
      ),),
    );
  }
}
