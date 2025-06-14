import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/TransactionsCertif.dart';
import 'package:provider/provider.dart';

import '../../CodeVerif.dart';
import '../../CreationParticulier/model/BankingAccountDTOModel.dart';
import '../../CreationParticulier/provider/BankingAccountDTOProvider.dart';
import '../provider/DepositOpProvider.dart';

class Dseven extends StatefulWidget {
  const Dseven({super.key});

  @override
  State<Dseven> createState() => _DsevenState();
}

class _DsevenState extends State<Dseven> {
  int inde = -1;
  String? DepositOpId ;
  int? BankingOpId ;
  var key = GlobalKey<FormState>();
  TextEditingController montant = TextEditingController();
  void showConfirmationDialog(BuildContext context,String montant,String bankId ){
    DateTime now = new DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return Container(
            height: 450,
            width: 500,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Récapitulatif",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
                SizedBox(height: 30,),
                Text("Code de référence            1567-SFE-890320",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Montant                                   200 000 XAF",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Compte a créditer                    0014794527",style: TextStyle(fontSize: 20),),

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
                      onTap: ()async{
                        Provider.of<DepositOpProvider>(context,listen: false).setMontant(montant: int.parse(montant));
                        Provider.of<DepositOpProvider>(context,listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                        Provider.of<DepositOpProvider>(context,listen:false).setStatus();
                        Provider.of<DepositOpProvider>(context,listen: false).setCreditNum(creditnum: "");
                        await Provider.of<DepositOpProvider>(context,listen: false).saveDepositOp();
                        final depositOp = Provider.of<DepositOpProvider>(context,listen: false).depositOpModel;
                        if(depositOp != null){
                          setState(() {
                            DepositOpId = depositOp.id.toString();

                          });
                        }
                      
                        await Provider.of<DepositOpProvider>(context , listen : false).addDepositOpToBankingAccount(DepositOpId!, bankId.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Transactionscertif()));
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
          );
        });
  }
  @override
  void initState() {
    Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context).accounts;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Encaissez une mise a disposition"),
        centerTitle: true ,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height+300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 50,top: 30),child: Text("Veuillez renseigner les informations pour faire l'encaissement",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Code de référence",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),
                            hintText: "Cliquer pour saisir"
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 290,top: 40),child: Text("Montant",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: montant,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "This field must not be null";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none
                          ),
                          hintText: "Cliquer pour saisir le montant",
                          suffixIcon: Padding(padding: EdgeInsets.only(top: 10,right: 20),child: Text("XAF",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,

                          ),),),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Compte a créditer",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,

                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: ExpansionTile(title: inde == -1 ?Text("Cliquer pour selectionner") : Text("${accounts[inde].type} : ${accounts[inde].RIB }"),children: [
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                              itemCount: accounts.length,
                              itemBuilder: (BuildContext context ,int index){
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      inde = index;
                                    });
                                  },
                                  child: Padding(padding: EdgeInsets.all(10),child: Container(
                                    width: 400,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F2F2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Text("${accounts[index].type} : ${accounts[index].RIB }"),
                                      ],
                                    ),
                                  )),
                                );
                              }),
                        )
                      ],),
                    ),
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: (){
                      if(key.currentState!.validate() && inde != -1){
                        showConfirmationDialog(context,montant.text,accounts[inde].id.toString());
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
                        child: Text("Continuer",style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
