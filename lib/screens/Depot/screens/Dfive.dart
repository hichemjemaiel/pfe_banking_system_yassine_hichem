import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/DepositOpProvider.dart';
import 'package:provider/provider.dart';

import '../../TransactionsCertif.dart';

class Dfive extends StatefulWidget {
  String montant;
  String opId;
  String bankId;
  String creditnum;
   Dfive( {super.key,required this.montant,required this.opId,required this.bankId, required this.creditnum});

  @override
  State<Dfive> createState() => _DfiveState();
}

class _DfiveState extends State<Dfive> {
  DateTime now = DateTime.now();
  String? BankOpId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dépot en cours"),
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height-100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Text("Obtenez un code de confirmation en\n     cliquant sur le code ci-dessous",style: TextStyle(
                    fontSize: 20
                  ),),
                  SizedBox(height: 40,),
                  Container(
                    width: 200,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone,color: Colors.white,),
                        SizedBox(width: 10,),
                        Text("*150*10#",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Text("     Entrez le code reçu dans le champ\nci-dessous puis cliquez sur Confirmer",style: TextStyle(
                    fontSize: 20
                  ),),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                            ),
                          ),
                        ),

                      ),
                      Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),

                      ),
                      Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),

                      ),
                      Container(
                        width: 60,
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                        ),
                        child: Center(
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                          ),
                        ),

                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 200,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Annuler",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),),
                        ),
                      ),
                      InkWell(
                        onTap: ()async{
                          Provider.of<DepositOpProvider>(context,listen: false).setMontant(montant: int.parse(widget.montant));
                          Provider.of<DepositOpProvider>(context,listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                          Provider.of<DepositOpProvider>(context,listen: false).setStatus();
                          Provider.of<DepositOpProvider>(context,listen: false).setCreditNum(creditnum: widget.creditnum);
                          await Provider.of<DepositOpProvider>(context,listen: false).saveDepositOp();
                          final BankinOp = await Provider.of<DepositOpProvider>(context,listen: false).depositOpModel;
                          if(BankinOp != null){
                            setState(() {
                              BankOpId = BankinOp.id.toString();
                            });
                            print("Banking Op ${BankinOp.id} created successfully");
                          }
                          await Provider.of<DepositOpProvider>(context,listen: false).addOperateurToDepositOp(BankOpId!,widget.opId);
                          await Provider.of<BankingOpProvider>(context,listen: false).addBankingOperationToBankingAccount(BankOpId!, widget.bankId);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Transactionscertif()));
                        },
                        child: Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Confirmer",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
