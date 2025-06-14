import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/model/DepositOpModel.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/DepositOpProvider.dart';
import 'package:provider/provider.dart';

import '../../TransactionsCertif.dart';

class Codeverifcarddepot extends StatefulWidget {
  String cardId;
  String bankId;

  Codeverifcarddepot( {super.key, required this.cardId, required this.bankId});

  @override
  State<Codeverifcarddepot> createState() => _CodeverifcarddepotState();
}

class _CodeverifcarddepotState extends State<Codeverifcarddepot> {
  String? DepositOpId ;
  int? BankingOpId ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Code de vérification (OTP)"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 40,),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height-173,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
            ),
            child: Column(
              children: [
                Image.asset("assets/otp.jpg",scale: 5,),
                SizedBox(height: 20,),
                Text("Entrez votre code de vérification\n    (OTP) pour confirmer votre\n                    transaction",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 60,height: 60,child: TextField(
                      decoration:InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ) ,),),
                    SizedBox(width: 60,height: 60,child: TextField(
                      decoration:InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ) ,),),
                    SizedBox(width: 60,height: 60,child: TextField(
                      decoration:InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ) ,),),
                    SizedBox(width: 60,height: 60,child: TextField(
                      decoration:InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ) ,),),
                    SizedBox(width: 60,height: 60,child: TextField(
                      decoration:InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ) ,),),
                  ],

                ),
                SizedBox(height: 50,),
                InkWell(
                  onTap: () async{

                    await Provider.of<DepositOpProvider>(context,listen: false).saveDepositOp();
                    final depositOp = Provider.of<DepositOpProvider>(context,listen: false).depositOpModel;
                    if(depositOp != null){
                      setState(() {
                        DepositOpId = depositOp.id.toString();

                      });
                    }
                    await Provider.of<DepositOpProvider>(context,listen: false).addCardToDepositOp(DepositOpId!,widget.cardId);
                    await Provider.of<DepositOpProvider>(context , listen : false).addDepositOpToBankingAccount(DepositOpId!, widget.bankId.toString());
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Transactionscertif()));
                  },
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text("Valider",style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 40,left: 60),child:
                Row(
                  children: [
                    Text("Vous n'avez pas reçu d'OTP?",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),),
                    Text("Renvoyer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Color(0xFF4A9E1F)),)
                  ],
                ),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
