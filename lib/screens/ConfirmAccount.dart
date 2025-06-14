import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/MainScreen.dart';

import 'Bar.dart';

class Confirmaccount extends StatefulWidget {
  String email;
   Confirmaccount({super.key, required  this.email});

  @override
  State<Confirmaccount> createState() => _ConfirmaccountState();
}

class _ConfirmaccountState extends State<Confirmaccount> {
  @override
  Widget build(BuildContext context) {
    int myIndex= 0;
    return Scaffold(
      bottomNavigationBar: Bar(
        myIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: SingleChildScrollView(
        child: Column(

          children: [
            Padding(padding: EdgeInsets.only(top: 220),child: Image.asset("assets/conf.gif",),),
            // Add space at the top
            Container(
              height: MediaQuery.of(context).size.height-500,
              width: MediaQuery.of(context).size.width +10, // Adjust width to 90% of screen
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                children: [

                  SizedBox(height: 20), // Add space between image and text
                  Text(
                    "Votre compte épargne à été ajouté\navec succès",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                  SizedBox(height: 100), // Add space between text and button
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(email: widget.email,)));
                    },
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Allez à mes comptes",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )

    );
  }
}
