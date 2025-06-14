import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20vers%20autre%20compte/CodeVerifBambo.dart';
import 'package:provider/provider.dart';

import '../../../Bar.dart';
import '../../../CodeVerif.dart';



class Atwo extends StatefulWidget {
  const Atwo({super.key});

  @override
  State<Atwo> createState() => _AtwoState();
}

class _AtwoState extends State<Atwo> {
  int myIndex = 0;
  int ind = -1;
  var key = GlobalKey<FormState>();
  TextEditingController montant = TextEditingController();
  TextEditingController ben =TextEditingController();
  TextEditingController namecreditnum =TextEditingController();
  void showConfirmationDialog(BuildContext context, String montant, String senderRIB, String receiverRIB, String BankId, String namecreditnum){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return Container(
            height: 450,
            width: 500,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Récapitulatifs du virement",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
                SizedBox(height: 30,),
                Text("Compte  a débiter       Compte Courant",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Montant                                    50 000 XAF",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Compte bénéficaire                      0057246",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Bénéficaire                                   Emane.V",style: TextStyle(fontSize: 20),),
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
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverifbambo(montant: montant,senderRIB: senderRIB,receiverRIB: receiverRIB,BankId: BankId,namecreditnum: namecreditnum,)));
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
    Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(71);
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
          title: Text("Virements vers SFE"),
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
                height: MediaQuery.of(context).size.height+200,
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
                                  return Padding(padding: EdgeInsets.only(top: 30),child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        ind = index;
                                      });
                                    },
                                    child: Container(
                                      width: 400,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF7F7F7),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Padding(padding: EdgeInsets.only(left: 20),child: Text("${accounts[index].type} | ${accounts[index].RIB}"),),
                                    ),
                                  ),);
                                }),
                          )
                        ],),
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
                              child: Center(child: Text("Solde disponible : 8500 000 XAF",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),),
                            )
                          ],
                        )
                    ),
                    Padding(padding: EdgeInsets.only(right: 170,top: 40),child: Text("Compte du bénéficaire",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                          child:  TextFormField(
                            controller: ben,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "This filed must not be null";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "Cliquez pour saisir",
                                suffixIcon: Icon(Icons.qr_code_scanner,color: Colors.green,)
                            ),

                          )),
                    ),
                    Padding(padding: EdgeInsets.only(right: 260,top: 40),child: Text("Bénéficaire",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                        child:  TextFormField(
                          controller: namecreditnum,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "This field must not be null";
                            }
                          },
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
                        if(key.currentState!.validate() && ind !=-1){
                          if(accounts[ind].balance > int.parse(montant.text)){
                            showConfirmationDialog(context,montant.text, accounts[ind].RIB,ben.text,accounts[ind].id.toString(),namecreditnum.text);
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
