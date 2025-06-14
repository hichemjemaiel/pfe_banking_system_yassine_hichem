import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:pfe_banking_system/screens/Virement/provider/TransferOpProvider.dart';
import 'package:provider/provider.dart';

class Codeverifbambo extends StatefulWidget {
  String montant;
  String senderRIB;
  String receiverRIB;
  String BankId;
  String namecreditnum;
  Codeverifbambo({super.key,required this.montant , required this.senderRIB , required this.receiverRIB, required this.BankId,required this.namecreditnum});

  @override
  State<Codeverifbambo> createState() => _CodeverifbamboState();
}

class _CodeverifbamboState extends State<Codeverifbambo> {
  DateTime now = DateTime.now();
  String? BankOpId;
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
                     Provider.of<TransferOpProvider>(context,listen: false).setMontant(montant: int.parse(widget.montant));
                     Provider.of<TransferOpProvider>(context,listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                     Provider.of<TransferOpProvider>(context,listen: false).setStatus();
                     Provider.of<TransferOpProvider>(context,listen: false).setSenderRIB(senderRIB: widget.senderRIB);
                     Provider.of<TransferOpProvider>(context,listen: false).setReceiverRIB(receiverRIB: widget.receiverRIB);
                     Provider.of<TransferOpProvider>(context,listen: false).setNameCreditNum(namecreditnum: widget.namecreditnum);
                     await Provider.of<TransferOpProvider>(context,listen: false).saveTransferOp();
                     final WithdrawOp = await Provider.of<TransferOpProvider>(context,listen: false).transferModel;
                     if(WithdrawOp != null){
                       setState(() {
                         BankOpId = WithdrawOp.id.toString();
                       });
                     }
                     await Provider.of<BankingOpProvider>(context,listen: false).addBankingOperationToBankingAccount(BankOpId!, widget.BankId);

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
