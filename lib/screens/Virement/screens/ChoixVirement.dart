import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/Virement/screens/permanent/Pone.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20ver%20mes%20comptes/Mone.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20vers%20autre%20compte/AOne.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20vers%20autre%20compte/Ebone.dart';


class Choixvirement extends StatefulWidget {
  final int id; // Non-nullable id
  const Choixvirement({super.key, required this.id}); // Correct constructor

  @override
  State<Choixvirement> createState() => _ChoixvirementState();
}

class _ChoixvirementState extends State<Choixvirement> {
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
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text("Virement"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Choisissez le canal\nde virement",
                style: TextStyle(fontSize: 25),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Mone(id : widget.id)),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image.asset(
                              "assets/dollar.png",
                              scale: 1.5,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Vers mes comptes",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 100),
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Ebone(id: widget.id),
                        ),
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Image.asset(
                              "assets/dollar.png",
                              scale: 1.5,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Vers un autre compte",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 80),
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}