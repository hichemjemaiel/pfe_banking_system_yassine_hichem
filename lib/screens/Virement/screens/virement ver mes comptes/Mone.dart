import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/CodeVerif.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20ver%20mes%20comptes/CodeVetrifMone.dart';
import 'package:provider/provider.dart';

import '../../../OTP/provider/OtpProvider.dart';

class Mone extends StatefulWidget {
  int? id ;
   Mone({super.key ,this.id});

  @override
  State<Mone> createState() => _MoneState();
}

class _MoneState extends State<Mone> {
  int myIndex = 0;
  int ind = -1 ;
  int inde = -1;
  var key = GlobalKey<FormState>();
  String? otpCode;
  TextEditingController montant = TextEditingController();
  void showConfirmationDialog(BuildContext context, String montant, String senderRIB, String receiverRIB, String BankId) {
    // Access the accounts from the provider
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;

    // Find the sender and receiver account details based on RIB
    BankingAccountDTOModel? senderAccount = accounts.firstWhere((account) => account.RIB == senderRIB);
    BankingAccountDTOModel? receiverAccount = accounts.firstWhere((account) => account.RIB == receiverRIB);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 450,
          width: 500,
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                "Récapitulatif du virement",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Compte à débiter:     ${senderAccount.RIB}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "- - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Compte à créditer:     ${receiverAccount.RIB}",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "- - - - - - - - - - - - - - - - - - - - - - - - - - - -",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Montant:                                       $montant XAF",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.only(top: 100, left: 60),
                child: Row(
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text(
                            "Annuler",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    InkWell(
                      onTap: () async {
                        await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21646491524");
                        String? otpCode = Provider.of<OtpProvider>(context, listen: false).otpCode;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Codeverifmone(
                              montant: montant,
                              senderRIB: senderRIB,
                              receiverRIB: receiverRIB,
                              BankId: BankId,
                              otpCode: otpCode,
                              id : widget.id
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "Valider",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
              Text("No enough assets",style: TextStyle(
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
                        Text("Deposer",style: TextStyle(
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
    Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(widget.id!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context).accounts;
    return Scaffold(
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (ind){
        setState(() {
          myIndex = ind;
        });
      }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Virements vers mes comptes"),
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
              height: MediaQuery.of(context).size.height+350,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Compte a débiter",style: TextStyle(
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
                      child:  ExpansionTile(title: ind == -1 ? Text("Cliquer pour selectionner"): Text("${accounts[ind].type} | ${accounts[ind].RIB}"),children: [
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                              itemCount: accounts.length,
                              itemBuilder: (BuildContext context , int index){
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      ind = index;
                                    });
                                  },
                                  child: Padding(padding: EdgeInsets.only(top: 30),child: Container(
                                    height: 70,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(padding: EdgeInsets.only(left: 20),child: Text("${accounts[index].type} | ${accounts[index].RIB}"),),
                                  )),
                                );
                              }),
                        )
                      ],),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Compte a créditer",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 10,),
                  Container(
                    width: 400,

                    decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:Center(
                      child:  ExpansionTile(title: inde == -1 ?Text("Cliquer pour selectionner") : Text("${accounts[inde].type} | ${accounts[inde].RIB}"),children: [
                        SizedBox(
                          height: 300,
                          child: ListView.builder(
                              itemCount: accounts.length,
                              itemBuilder: (BuildContext context , int index){
                                return InkWell(
                                  onTap: (){
                                    setState(() {
                                      inde = index;
                                    });
                                  },
                                  child: Padding(padding: EdgeInsets.only(top: 30),child: Container(
                                    height: 70,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFF7F7F7),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(padding: EdgeInsets.only(left: 20),child: Text("${accounts[index].type} | ${accounts[index].RIB}"),),
                                  )),
                                );
                              }),
                        )
                      ]),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 280,top: 40),child: Text("Montant",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 10,),
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
                            child: Center(child:ind == -1 ? Text("0 XAF",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),) : Text("Solde disponible : ${accounts[ind].balance} XAF",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),),),
                          )
                        ],
                      )
                  ),
                  Padding(padding: EdgeInsets.only(right: 290,top: 40),child: Text("Motif",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 10,),
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child:Center(
                      child:  TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            hintText: "Cliquez pour saisir votre motif"
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap : (){
                      if(key.currentState!.validate() && ind != -1 && inde != -1){
                        if(accounts[ind].balance> int.parse(montant.text)){
                          showConfirmationDialog(context,montant.text,accounts[ind].RIB,accounts[inde].RIB,accounts[ind].id.toString());
                        }else{
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
                  )
                ],
              ),
            )
          ],
        )),
      )
    );
  }
}
