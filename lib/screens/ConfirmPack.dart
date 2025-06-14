import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/MesComptes.dart';

class ConfirmPack extends StatefulWidget {
  int? id ;
  String? email;
   ConfirmPack({super.key, required this.id,required this.email});

  @override
  State<ConfirmPack> createState() => _ConfirmPackState();
}

class _ConfirmPackState extends State<ConfirmPack> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
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
              Padding(padding: EdgeInsets.only(top: 270),child: Image.asset("assets/conf.gif",),),
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
                      "Votre changement de package est en\n cours de traitement",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center, // Center-align the text
                    ),
                    SizedBox(height: 100), // Add space between text and button
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MesComptes(id: widget.id,email: widget.email!,)));
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
        ),

    );
  }
}