import 'package:flutter/material.dart';

class Transactionacat extends StatefulWidget {
  const Transactionacat({super.key});

  @override
  State<Transactionacat> createState() => _TransactionacatState();
}

class _TransactionacatState extends State<Transactionacat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Transaction à catégoriser"),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child:Column(

          children: [
            SizedBox(height: 40,),

            Container(
              height: MediaQuery.of(context).size.height-150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/conf.gif",) ,
                  Text("Mission accomplie !",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),),
                  SizedBox(height: 20,),
                  Text(
                    "Toutes vos transactions sont désormais catégorisées.\nVous gérez vos finances comme un professionnel",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100),

                ],
              ),
            ),

          ],
        ),
      )

    );
  }
}
