import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/MaxBudgetProvider.dart';
import 'package:provider/provider.dart';

class BudgetFamille extends StatefulWidget {
  const BudgetFamille({super.key});

  @override
  State<BudgetFamille> createState() => _BudgetFamilleState();
}

class _BudgetFamilleState extends State<BudgetFamille> {
  var key = GlobalKey<FormState>();
  int? BudgetId;
  TextEditingController montant = TextEditingController();
  @override
  void initState() {
    getExistingBudget();
    super.initState();
  }
  Future<void> getExistingBudget()async{
    try{
      final result = await Provider.of<MaxBudgetProvider>(context,listen: false).getMaxBudgetByType("famille");
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
        title: Text("Budget"),
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
              Padding(padding: EdgeInsets.only(right: 80,top: 40),child: Text("Définissez le montant du budget",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.only(right: 30,top: 20),child: Text("Fixez le monatant que vous souhaitez\nne pas dépasser",style: TextStyle(
                  fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.only(right: 280,top: 20),child: Text("Catégorie",style: TextStyle(
                  fontSize: 20
              ),),),
              Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
                width: 400,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Text("Famille",style: TextStyle(
                    fontSize: 20
                ),),),
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
                    if(BudgetId == null){
                      Provider.of<MaxBudgetProvider>(context,listen: false).setType(type: "famille");
                      Provider.of<MaxBudgetProvider>(context,listen: false).setMaximumBudget(maximumBudget: int.parse(montant.text));
                      await Provider.of<MaxBudgetProvider>(context,listen: false).saveMaxBudget();
                      final result = await Provider.of<MaxBudgetProvider>(context,listen: false).getMaxBudgetByType("famille");
                      if(result != null){
                        setState(() {
                          BudgetId = result.id;

                        });
                      }
                    }else{
                      Provider.of<MaxBudgetProvider>(context,listen: false).updateMaxBudget("famille", int.parse(montant.text));
                    }
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
