import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Depot/model/CardDto.dart';
import 'package:pfe_banking_system/screens/Depot/provider/CardDtoProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/DepositOpProvider.dart';
import 'package:pfe_banking_system/screens/Depot/screens/CodeVerifCardDepot.dart';
import 'package:pfe_banking_system/screens/Depot/screens/TransactionVerifCard.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/TransactionVertifCard.dart';
import 'package:provider/provider.dart';

import '../../CodeVerif.dart';
import '../../TransactionsCertif.dart';

class Dsevent extends StatefulWidget {
  int? id ;
  Dsevent({super.key, this.id});

  @override
  State<Dsevent> createState() => _DseventState();
}

class _DseventState extends State<Dsevent> {
  bool clicked = false;
  int ind = -1;
  int inde = -1;
  String? DepositOpId ;
  int? BankingOpId ;
  @override
  void initState() {
    Provider.of<CardDtoProvider>(context,listen: false).getAllCardsToClientActive(widget.id!);
    Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(widget.id!);
    super.initState();
  }
  void showConfirmationDialog(BuildContext context ){
    List<CardDtoModel> cards = Provider.of<CardDtoProvider>(context,listen: false).Acards;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return SingleChildScrollView(
            child: Container(
              height: 450,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Padding(padding: EdgeInsets.only(right: 250),child: Text("Récapitulatif",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 40,top: 20),child: Text("Cliquer pour choisir la carte a débiter",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        itemCount: cards.length,
                        itemBuilder: (BuildContext context, int index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                ind = index;
                                Navigator.pop(context);
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
                                  SizedBox(width: 10,),
                                  Image.asset("assets/imone.png",scale: 1.5,),
                                  SizedBox(width: 10,),
                                  Text("${cards[index].type} | "),
                                  Text("**** **** **** ${cards[index].number.substring(cards[index].number.length - 4)}")
                                ],
                              ),
                            ),),
                          );
                        }),
                  )


                ],
              ),
            ),
          );
        });
  }
  void showNotEnough(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext){
      return Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40)
        ),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50),child: Container(
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text("Not Enough money",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),),
            Padding(padding: EdgeInsets.only(top: 50),child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Annuler",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                  ),
                ),
                Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Recharger",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
                  ),
                ),
              ],
            ),),
          ],
        ),
      );
    });
  }
  void showConfirmationDialogthree(BuildContext context ){
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context,listen: false).accounts;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return SingleChildScrollView(
            child: Container(
              height: 850,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Padding(padding: EdgeInsets.only(right: 250),child: Text("Récapitulatif",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 40,top: 20),child: Text("Cliquer pour choisir la carte a débiter",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 30,),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        itemCount: accounts.length,
                        itemBuilder: (BuildContext context ,int index){
                          return InkWell(
                            onTap: (){
                              setState(() {
                                inde = index;
                                Navigator.pop(context);
                              });
                            },
                            child: Padding(padding: EdgeInsets.all(10),child: Container(
                              width: 400,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 30,),
                                  Text("${accounts[index].type} |   "),
                                  Text("${accounts[index].RIB}"),
                                ],
                              ),
                            ),),
                          );
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }
  void showConfirmationDialogtwo(BuildContext context, String montant, String cardId, String bankId) {
    DateTime now = new DateTime.now();
    List<CardDtoModel> cards = Provider.of<CardDtoProvider>(context, listen: false).Acards;
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;

    // Get the selected card and account
    CardDtoModel selectedCard = cards[ind];
    BankingAccountDTOModel selectedAccount = accounts[inde];

    // Calculate fees (you can adjust this calculation based on your business logic)
    int amount = int.parse(montant);
    int fees = (amount * 0.02).round(); // Example: 2% fees
    int totalAmount = amount + fees;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext) {
          return SingleChildScrollView(
            child: Container(
              height: 800,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Text("Récapitulatif", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )),
                  SizedBox(height: 30),
                  Text("Canal d'operation                      UBA Gabon", style: TextStyle(fontSize: 20)),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -", style: TextStyle(fontSize: 20)),

                  // Use actual card data
                  Text("Carte a débiter                **** **** **** ${selectedCard.number.substring(selectedCard.number.length - 4)}",
                      style: TextStyle(fontSize: 20)),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -", style: TextStyle(fontSize: 20)),

                  // Use actual account data
                  Text("Compte a créditer  ${selectedAccount.RIB}",
                      style: TextStyle(fontSize: 20)),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -", style: TextStyle(fontSize: 20)),

                  // Use actual amount
                  Text("Montant                                     ${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} XAF",
                      style: TextStyle(fontSize: 20)),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -", style: TextStyle(fontSize: 20)),

                  // Use calculated fees
                  Text("Frais                                              ${fees.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} XAF",
                      style: TextStyle(fontSize: 20)),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -", style: TextStyle(fontSize: 20)),

                  // Use calculated total amount
                  Text("Montant total                         ${totalAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} XAF",
                      style: TextStyle(fontSize: 20)),

                  Padding(
                    padding: EdgeInsets.only(top: 70, left: 60),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text("Annuler", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            Provider.of<DepositOpProvider>(context, listen: false).setMontant(montant: amount);
                            Provider.of<DepositOpProvider>(context, listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                            Provider.of<DepositOpProvider>(context, listen: false).setStatus();
                            Provider.of<DepositOpProvider>(context, listen: false).setCreditNum(creditnum: "");
                            await Provider.of<DepositOpProvider>(context, listen: false).saveDepositOp();
                            final depositOp = Provider.of<DepositOpProvider>(context, listen: false).depositOpModel;
                            String depositOpId = "";
                            if (depositOp != null) {
                              depositOpId = depositOp.id.toString();
                              setState(() {
                                DepositOpId = depositOpId;
                              });
                            }
                            await Provider.of<DepositOpProvider>(context, listen: false).addCardToDepositOp(depositOpId, cardId);
                            await Provider.of<DepositOpProvider>(context, listen: false).addDepositOpToBankingAccount(depositOpId, bankId.toString());

                            // Pass transaction data to the certificate screen
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => TransactionscertifCarde(
                                  operationType: "Depot via carte",
                                  amount: totalAmount,
                                  date: "${now.day}/${now.month}/${now.year} à ${now.hour.toString().padLeft(2, '0')}H${now.minute.toString().padLeft(2, '0')}",
                                  reference: depositOpId.isNotEmpty ? depositOpId : "N/A",
                                  cardNumber: "**** **** **** ${selectedCard.number.substring(selectedCard.number.length - 4)}",
                                  accountRIB: selectedAccount.RIB,
                                  fees: fees,
                                  originalAmount: amount,
                                )
                            ));
                          },
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text("Valider", style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    List<BankingAccountDTOModel> accounts = Provider.of<BankingAccountDTOProvider>(context,listen: false).accounts;
    List<CardDtoModel> cards = Provider.of<CardDtoProvider>(context,listen: false).Acards;
    var key = GlobalKey<FormState>();
    TextEditingController montant = TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Depot via carte"),
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
                height: MediaQuery.sizeOf(context).height-100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)

                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 250,top: 40),child:  Text("Carte a débiter",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        showConfirmationDialog(context);
                      },
                      child: Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: ind == -1 ?Row(
                          children: [
                            SizedBox(width: 30,),
                            Text("Cliquer pour selectionner",style: TextStyle(
                                fontSize: 18
                            ),),
                            SizedBox(width: 120,),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ): Row(
                          children: [
                            SizedBox(width: 10,),
                            Image.asset("assets/imone.png",scale: 1.5,),
                            SizedBox(width: 10,),
                            Text("${cards[ind].type} | "),
                            Text("**** **** **** ${cards[ind].number.substring(cards[ind].number.length - 4)}")
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 220,top: 20),child:  Text("Compte a créditer",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        showConfirmationDialogthree(context);
                      },
                      child: Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: inde  == -1 ? Row(
                          children: [
                            SizedBox(width: 30,),
                            Text("Cliquer pour selectionner",style: TextStyle(
                                fontSize: 18
                            ),),
                            SizedBox(width: 120,),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ):Row(
                          children: [
                            SizedBox(width: 30,),
                            Text("${accounts[inde].type} |   "),
                            Text("${accounts[inde].RIB}"),

                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 300,top: 20),child:  Text("Montant",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    // Replace the existing balance display container with this updated version
                    Container(
                      width: 400,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 400,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: TextFormField(
                                controller: montant,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "This field must not be null";
                                  }
                                  // Additional validation for amount vs balance
                                  if (ind != -1) {
                                    int enteredAmount = int.tryParse(value) ?? 0;
                                    if (enteredAmount > cards[ind].balance) {
                                      return "Amount exceeds available balance";
                                    }
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none
                                  ),
                                  hintText: "50 000",
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(top: 10, right: 10),
                                    child: Text("XAF", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Text(
                                ind == -1
                                    ? "Solde disponible: -- XAF"
                                    : "Solde disponible: ${cards[ind].balance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]} ')} XAF",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20,left: 30),child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              clicked == false ? clicked = true : clicked = false ;
                            });
                          },
                          child: Container(
                            width:40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: clicked == false ?Colors.grey[300]: Colors.green,
                                borderRadius: BorderRadius.circular(10)
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text("Inclure les frais",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green
                        ),)
                      ],
                    ),),
                    Padding(padding: EdgeInsets.only(top: 20,right: 80),child: Text("04 chiffres a l'arriere de la carte",style: TextStyle(fontSize: 20),),),
                    Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Center(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Saisir le numéro au dos de la carte",
                              prefixIcon: Padding(padding: EdgeInsets.only(top: 5,left: 10,right: 10),child: Image.asset("assets/imtwo.png",scale: 2,),),
                            ),
                          ),
                        )
                    ),
                    SizedBox(height: 40,),
                    InkWell(
                      onTap: (){
                        if(key.currentState!.validate() && ind !=-1 && inde !=-1){
                          if(cards[ind].balance < int.parse(montant.text)){
                            showNotEnough(context);
                          }else{
                            showConfirmationDialogtwo(context,montant.text,cards[ind].id.toString(),accounts[inde].id.toString());
                          }

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
      ),
    );
  }
}