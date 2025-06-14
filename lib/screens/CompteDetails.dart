import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountProvider.dart';

import 'package:pfe_banking_system/screens/QrCode.dart';
import 'package:provider/provider.dart';

class CompteDetails extends StatefulWidget {
   String rib;
   int agency_Id;
   CompteDetails({super.key, required this.rib, required this.agency_Id,});

  @override
  State<CompteDetails> createState() => _CompteDetailsState();
}

class _CompteDetailsState extends State<CompteDetails> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text("Détails du compte"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F2F2),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.download),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: buildRibInterne(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRibInterne() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    myIndex = 0;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                      color: myIndex == 0 ? const Color(0xFF4A9E1F) : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "RIB interne",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        const SizedBox(height: 40),
        const Padding(
          padding: EdgeInsets.only(right: 80),
          child: Text(
            "Vos numéro de compte à partager",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Text(
          "--------------------------------------------------------------------",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20),child: Image.asset("assets/bambo.png",scale: 1.5,),),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "Numéro de compte",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 15),
            Container(
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF4A9E1F),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Image.asset("assets/arrow.png", scale: 1.5),
                      const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Partager",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          "--------------------------------------------------------------------",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 5),
        const Padding(
          padding: EdgeInsets.only(right: 200),
          child: Column(
            children: [
              Text(
                "Titulaire du compte",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Yao Boris de Kedake",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "--------------------------------------------------------------------",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding:  EdgeInsets.only(right: 12),
          child: Row(
            children: [
               Padding(
                padding: EdgeInsets.only(right: 100),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Numéro de compte",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40,top: 5),
                      child: Text(
                        "${widget.rib}",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Qrcode()),
                  );
                },
                child: Image.asset("assets/qr.png", scale: 9),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
        const Text(
          "--------------------------------------------------------------------",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
         Padding(
          padding: EdgeInsets.only(right: 100),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right : 120),
                child: Text(
                  "Domiciliation",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 140),child: Text(
                "AGENCE : ${widget.agency_Id}",
                style: TextStyle(fontSize: 20),
              ),),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "--------------------------------------------------------------------",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 100),
        Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF4A9E1F),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 90),
              child: Row(
                children: [
                  const Icon(Icons.copy, color: Colors.white),
                  const SizedBox(width: 2),
                  const Text(
                    "Copier vos informations",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


}