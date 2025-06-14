import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/AgencyProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
import '../../CodeVerif.dart';
import '../../OTP/provider/OtpProvider.dart';
import 'CodeVerifRetraitAgence.dart';

class Rethree extends StatefulWidget {
  const Rethree({super.key});

  @override
  State<Rethree> createState() => _RethreeState();
}

class _RethreeState extends State<Rethree> {
  int myIndex = 0;
  int ind = -1;
  int inde =-1;
  TextEditingController montant = TextEditingController();
  var key = GlobalKey<FormState>();

  void showConfirmationDialog(BuildContext context, String montant, int agencyId, int BankingId){
    String? otpCode;

    // Get the selected account and agency data
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;
    List<AgencyModel> agencies = Provider.of<AgencyProvider>(context, listen: false).agencies;

    BankingAccountDTOModel selectedAccount = accounts[inde];
    AgencyModel selectedAgency = agencies[ind];

    // Calculate fees (you can adjust this logic based on your business rules)
    int fees = 1000; // Default fee, you can make this dynamic based on amount or other factors

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
                Text("Compte à débiter        ${selectedAccount.RIB}",style: TextStyle(fontSize: 18),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Montant                                   ${montant} XAF",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Agence                                        ${selectedAgency.id ?? 'Agency ${selectedAgency.id}'}",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Frais                                          ${fees} XAF",style: TextStyle(fontSize: 20),),
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
                            Navigator.pop(context);
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
                      onTap: () async{
                        await Provider.of<OtpProvider>(context,listen: false).generateOtp("+21694399332");
                        otpCode = await Provider.of<OtpProvider>(context,listen: false).otpCode;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverifretraitagence( montant:int.parse(montant),  agencyId:agencyId , BankingId:BankingId, otpCode: otpCode,)));
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

  void showNotEnough(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext ){
      return Container(
          width: 450,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("Solde insuffisant",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
              ),),
              Padding(padding: EdgeInsets.only(left: 65,top: 20),child: Row(
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
                          Navigator.pop(context);
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
                      Navigator.pop(context);
                      // Navigate to deposit screen or handle deposit logic
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
                        Text("Déposer",style: TextStyle(
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
          )
      );
    });
  }

  @override
  void initState() {
    Provider.of<AgencyProvider>(context,listen: false).getAllAgencies();
    Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AgencyModel> agencies = Provider.of<AgencyProvider>(context).agencies;
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context,listen: false).accounts;

    return Scaffold(
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (ind){
        setState(() {
          myIndex = ind;
        });
      }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Agence"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: key,
            child: Column(
              children: [
                SizedBox(height: 40,),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height+300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 160,top: 80),child: Text("Selectionner le compte",style: TextStyle(
                          fontSize: 20
                      ),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Center(
                          child:  ExpansionTile(title: inde == -1 ? Text( "Cliquer pour selectionner") :Text("${accounts[inde].type} | ${accounts[inde].RIB}") ,children: [
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  itemCount: accounts.length,
                                  itemBuilder: (BuildContext context , int index){
                                    return Padding(padding: EdgeInsets.only(top: 30),child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          inde = index;
                                        });
                                      },
                                      child: Container(
                                        width: 400,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF7F7F7),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Padding(padding: EdgeInsets.only(left: 10),child: Text("${accounts[index].type} | ${accounts[index].RIB}"),),
                                      ),
                                    ),);
                                  }),
                            )
                          ],),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 180,top: 40),child: Text("Selectionner l'agence",style: TextStyle(
                          fontSize: 20
                      ),),),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ExpansionTile(title: Text(ind == -1 ? "Choisissez votre agence": " Agency : ${agencies[ind].id}"),children: [
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  itemCount: agencies.length,
                                  itemBuilder: (BuildContext context , int index){
                                    return Padding(padding: EdgeInsets.all(5),child:
                                    InkWell(
                                        onTap: (){
                                          setState(() {
                                            ind = index;
                                          });
                                        },
                                        child:  Container(
                                          width: 400,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child:  Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Agency  :${agencies[index].id}"),),
                                        )
                                    ),);
                                  }),
                            ),
                          ],),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20,right: 280),child: Text("Montant",style: TextStyle(
                          fontSize: 20
                      ),),),
                      SizedBox(height: 20,),
                      Container(
                          width: 400,
                          height: 100,
                          decoration: BoxDecoration(
                              color: Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child:Column(
                            children: [
                              Container(
                                width: 400,
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Color(0xFFF7F7F7),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                    child: TextFormField(
                                      controller: montant,
                                      validator: (value){
                                        if(value == null || value.isEmpty){
                                          return "This field must not be null";
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            borderSide: BorderSide.none
                                        ),
                                        hintText: "Cliquer pour saisir le montant",
                                        hintStyle: TextStyle(
                                            fontSize: 16
                                        ),
                                        suffixIcon: Padding(padding: EdgeInsets.only(top: 10,right: 20),child: Text("XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
                                      ),
                                    )
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: Center(
                                  child: Text(
                                    inde == -1
                                        ? "Sélectionnez un compte pour voir le solde"
                                        : "Solde disponible : ${accounts[inde].balance.toStringAsFixed(0)} XAF",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 80,),
                      InkWell(
                        onTap : (){
                          if(key.currentState!.validate() && ind != -1 && inde != -1){
                            if(accounts[inde].balance > int.parse(montant.text)){
                              showConfirmationDialog(context,montant.text,agencies[ind].id!,accounts[inde].id!);
                            }
                            else{
                              showNotEnough(context);
                            }
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 50,
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
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}