import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/AgencyProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/DepositOpProvider.dart';
import 'package:pfe_banking_system/screens/Depot/screens/CodeVerifDepot.dart';
import 'package:provider/provider.dart';

import '../../CodeVerif.dart';
import '../../OTP/provider/OtpProvider.dart';

class Dtwo extends StatefulWidget {
  const Dtwo({super.key});

  @override
  State<Dtwo> createState() => _DtwoState();
}

class _DtwoState extends State<Dtwo> {
  bool clicked = false;
  int index1 = 0;
  int index2 = 0;
  int index3 = 0;
  int index4 = 0;
  int index5 = 0;
  int ind = -1;
  int inde = -1;
  int indexId =-1;
  String? otpCode;
  TextEditingController montant = TextEditingController();
  var key = GlobalKey<FormState>();

  void showConfirmationDialog(BuildContext context,String montant){
    DateTime now = DateTime.now();
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
                Text("Compte  a débiter             000554501101",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Montant                                   50 000 XAF",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Agence                                        Hypérion",style: TextStyle(fontSize: 20),),

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
                      onTap: () async{
                        Provider.of<DepositOpProvider>(context,listen: false).setMontant(
                            montant: int.parse(montant));
                        Provider.of<DepositOpProvider>(context,listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                        Provider.of<DepositOpProvider>(context,listen: false).setStatus();
                        Provider.of<DepositOpProvider>(context,listen: false).setCreditNum(creditnum: "");
                        await Provider.of<OtpProvider>(context,listen: false).generateOtp("+21698698739");
                        otpCode = await Provider.of<OtpProvider>(context,listen: false).otpCode;
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverifdepot(AgencyId : ind+1,BankingAccountId : indexId,otpCode : otpCode)));
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
    Provider.of<AgencyProvider>(context,listen: false).getAllAgencies();
    Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AgencyModel> agencies = Provider.of< AgencyProvider>(context).agencies;
    List<BankingAccountDTOModel> bankingAccounts = Provider.of<BankingAccountDTOProvider>(context).accounts;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Agence Hyperion"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
          children: [
            SizedBox(height: 30,),
            Text("Vers quel compte\nsouhaitez-vous faire\nvotre versement ?",style: TextStyle(
              fontSize: 30,

            ),),
            SizedBox(height: 30,),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height+200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 160,top: 40),child: Text("Selectionner le compte",style: TextStyle(
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
                      child: ExpansionTile(title: Text(inde ==- 1 ?"Cliquer pour selectionner": "${bankingAccounts[inde].type} : ${bankingAccounts[inde].RIB}"),children: [
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              itemCount: bankingAccounts.length,
                              itemBuilder: (BuildContext context , int index){
                                return ListTile(
                                  onTap: (){
                                    setState(() {
                                      inde = index;
                                      indexId = bankingAccounts[index].id!;
                                    });
                                  },
                                  title: Text("${bankingAccounts[index].type} : ${bankingAccounts[index].RIB }"),
                                );
                              }),
                        )
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

                                  validator: (value){
                                    if(value == null || value.isEmpty){
                                      return "This field must not be null";
                                    }
                                  },
                                  controller: montant,
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
                            child: Center(child: inde == -1 ? Text("0 XAF",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),) : Text("Solde disponible : ${bankingAccounts[inde].balance} XAF",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),),
                          )
                        ],
                      )
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
                      child: ExpansionTile(title: Text(ind == -1 ? "Choisissez votre agence" : "Agency : ${ind+1}"),children: [
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                              itemCount: agencies.length,
                              itemBuilder: (BuildContext context , int index){
                                return ListTile(
                                  onTap: (){
                                    setState(() {
                                      ind = index;
                                    });
                                  },
                                  leading: Text("Agency : ${agencies[index].id}",style: TextStyle(fontSize: 18),),
                                );
                              }),
                        )
                      ],),

                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 30,top: 40),child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          setState(() {
                            clicked == false ? clicked = true : clicked = false;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: clicked ? Color(0xFF4A9E1F) : Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text("Billetage",style: TextStyle(fontSize: 20),)
                    ],
                  ),),
                  SizedBox(height: 20,),
                  clicked ? bill(context) : Text(""),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(key.currentState!.validate()&& ind != -1 && inde !=-1){
                        showConfirmationDialog(context,montant.text);
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
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),),
      )
    );
  }
  Widget bill(BuildContext context){

    return Column(
      children: [
        Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(index1 >0){
                      index1 --;
                    }
                  });
                },
                child: Padding(padding: EdgeInsets.only(bottom: 30),child: Icon(Icons.minimize_sharp,size: 50,),),
              ),
              Text(index1 == 0? "Billet de 10 000 XAF" :"${index1}",style: TextStyle(
                fontSize: 20,
                color: Colors.grey[500],
                fontWeight: FontWeight.bold
              ),),
              InkWell(
                onTap: (){
                  setState(() {
                    index1 ++;
                  });
                },
                child: Icon(Icons.add,size: 50,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(index2 >0){
                      index2 --;
                    }
                  });
                },
                child: Padding(padding: EdgeInsets.only(bottom: 30),child: Icon(Icons.minimize_sharp,size: 50,),),
              ),
              Text(index2 == 0? "Billet de 5000 XAF" :"${index2}",style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold
              ),),
              InkWell(
                onTap: (){
                  setState(() {
                    index2 ++;
                  });
                },
                child: Icon(Icons.add,size: 50,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(index3 >0){
                      index3 --;
                    }
                  });
                },
                child: Padding(padding: EdgeInsets.only(bottom: 30),child: Icon(Icons.minimize_sharp,size: 50,),),
              ),
              Text(index3 == 0? "Billet de 2000 XAF" :"${index3}",style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold
              ),),
              InkWell(
                onTap: (){
                  setState(() {
                    index3 ++;
                  });
                },
                child: Icon(Icons.add,size: 50,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(index4 >0){
                      index4 --;
                    }
                  });
                },
                child: Padding(padding: EdgeInsets.only(bottom: 30),child: Icon(Icons.minimize_sharp,size: 50,),),
              ),
              Text(index4 == 0? "Billet de 1000 XAF" :"${index4}",style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold
              ),),
              InkWell(
                onTap: (){
                  setState(() {
                    index4 ++;
                  });
                },
                child: Icon(Icons.add,size: 50,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    if(index5 >0){
                      index5 --;
                    }
                  });
                },
                child: Padding(padding: EdgeInsets.only(bottom: 30),child: Icon(Icons.minimize_sharp,size: 50,),),
              ),
              Text(index5 == 0? "Billet de 500 XAF" :"${index5}",style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.bold
              ),),
              InkWell(
                onTap: (){
                  setState(() {
                    index5 ++;
                  });
                },
                child: Icon(Icons.add,size: 50,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
