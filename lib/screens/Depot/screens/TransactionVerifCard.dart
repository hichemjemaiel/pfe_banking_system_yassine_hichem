import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';

class TransactionscertifCarde extends StatefulWidget {
  final String operationType;
  final int amount;
  final String date;
  final String reference;
  final String? cardNumber;
  final String? accountRIB;
  final int? fees;
  final int? originalAmount;

  const TransactionscertifCarde({
    super.key,
    required this.operationType,
    required this.amount,
    required this.date,
    required this.reference,
    this.cardNumber,
    this.accountRIB,
    this.fees,
    this.originalAmount,
  });

  @override
  State<TransactionscertifCarde> createState() => _TransactionscertifCardeState();
}

class _TransactionscertifCardeState extends State<TransactionscertifCarde> {
  int myIndex = 0;

  String formatAmount(int amount) {
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]} '
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (int index){
        setState(() {
          myIndex = index;
        });
      }),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Stack(
                children: [
                  Image.asset("assets/conf.gif"),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height+100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 100,top: 20),child: Row(
                      children: [
                        Icon(Icons.security,size: 40,color: Colors.green,),
                        SizedBox(width: 10,),
                        Text("Transaction certifiée\npar Bamboo Sentinelle",style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),),
                    Padding(padding: EdgeInsets.only(top: 40,left: 10),child: Text(
                      "Votre paiement à été effectué avec succès.\nConsultez votre Historique pour vérifier le\n               statut de votre transaction",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                      ,),
                    Text("------------------------------------------------------------------",style: TextStyle(fontSize: 20),),

                    // Transaction details using passed data
                    Padding(padding: EdgeInsets.only(left: 30),child: Row(
                      children: [
                        Text("Type d'opération",style: TextStyle(fontSize: 20),),
                        SizedBox(width: 60,),
                        Expanded(
                          child: Text(widget.operationType,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),),
                    SizedBox(height: 20,),

                    // Display original amount and fees separately if fees exist
                    if (widget.originalAmount != null && widget.fees != null) ...[
                      Padding(padding: EdgeInsets.only(left: 30),child: Row(
                        children: [
                          Text("Montant",style: TextStyle(fontSize: 20),),
                          SizedBox(width: 210,),
                          Text("${formatAmount(widget.originalAmount!)} XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),),
                      SizedBox(height: 20,),
                      Padding(padding: EdgeInsets.only(left: 30),child: Row(
                        children: [
                          Text("Frais",style: TextStyle(fontSize: 20),),
                          SizedBox(width: 240,),
                          Text("${formatAmount(widget.fees!)} XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),),
                      SizedBox(height: 20,),
                      Padding(padding: EdgeInsets.only(left: 30),child: Row(
                        children: [
                          Text("Montant total",style: TextStyle(fontSize: 20),),
                          SizedBox(width: 160,),
                          Text("${formatAmount(widget.amount)} XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),),
                    ] else ...[
                      Padding(padding: EdgeInsets.only(left: 30),child: Row(
                        children: [
                          Text("Montant",style: TextStyle(fontSize: 20),),
                          SizedBox(width: 210,),
                          Text("${formatAmount(widget.amount)} XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),),
                    ],

                    SizedBox(height: 20,),
                    Padding(padding: EdgeInsets.only(left: 30),child: Row(
                      children: [
                        Text("Date",style: TextStyle(fontSize: 20),),
                        SizedBox(width: 165,),
                        Flexible(
                          child: Text(
                            widget.date,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),),
                    SizedBox(height: 20,),

                    // Display card details if available
                    if (widget.cardNumber != null && widget.cardNumber!.isNotEmpty) ...[
                      Padding(padding: EdgeInsets.only(left: 30),child: Row(
                        children: [
                          Text("Carte débitée",style: TextStyle(fontSize: 20),),
                          SizedBox(width: 80,),
                          Text(widget.cardNumber!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),),
                      SizedBox(height: 20,),
                    ],

                    // Display account details if available
                    if (widget.accountRIB != null && widget.accountRIB!.isNotEmpty) ...[
                      Padding(padding: EdgeInsets.only(left: 30),child: Row(
                        children: [
                          Text("Compte crédité",style: TextStyle(fontSize: 20),),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Text(widget.accountRIB!,
                              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),),
                      SizedBox(height: 20,),
                    ],

                    Padding(padding: EdgeInsets.only(left: 30),child: Row(
                      children: [
                        Text("Motifs",style: TextStyle(fontSize: 20),),
                        SizedBox(width: 270,),
                        Text("Depot",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),),
                    SizedBox(height: 20,),
                    Padding(padding: EdgeInsets.only(left: 30),child: Row(
                      children: [
                        Text("Référence",style: TextStyle(fontSize: 20),),
                        SizedBox(width: 200,),
                        Flexible(
                          child: Text(
                            widget.reference,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),),
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: () {
                        // Navigate to history screen
                        // You can implement navigation to history here
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(padding: EdgeInsets.only(left: 20),child: Row(
                          children: [
                            Icon(Icons.history,size: 30,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Consulter l'historique",style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () {
                        // Navigate back to main screen or new operation
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Container(
                        width: 280,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(padding: EdgeInsets.only(left: 20),child: Row(
                          children: [
                            Icon(Icons.wallet,size: 30,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text("Nouvelle opération",style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}