import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/AjoutCompte.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/CompteDetails.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Done.dart';
import 'package:pfe_banking_system/screens/Pack.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Retwo.dart';
import 'package:pfe_banking_system/screens/Virement/screens/ChoixVirement.dart';
import 'package:provider/provider.dart';

class MesComptes extends StatefulWidget {
  int? id;
  String email;
  MesComptes({super.key, required this.id, required this.email});

  @override
  State<MesComptes> createState() => _MesComptesState();
}

class _MesComptesState extends State<MesComptes> {
  int myIndex = 0;
  bool clicked = false;

  @override
  void initState() {
    Provider.of<BankingAccountDTOProvider>(context, listen: false).getAllBankingAccountForClient(widget!.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BankingAccountDTOModel> accountList = Provider.of<BankingAccountDTOProvider>(context).accounts;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(
        myIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      appBar: AppBar(
        title: const Text("Mes Comptes"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: InkWell(
              onTap: () async{
                if(widget.id != null){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AjoutCompte(id : widget.id!,email : widget.email)));
                }
                Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(widget.id!);
              },
              child: const Icon(Icons.add_circle_outline, size: 30, color: Color(0xFF4A9E1F)),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.white,
        child: ListView.builder(
            itemCount: accountList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left column
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${accountList[index].type}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22
                                ),
                              ),
                              const Text(
                                "Yao Boris Kedake",
                                style: TextStyle(fontSize: 18),
                              ),
                              const Text(
                                "N° Compte",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "${accountList[index].RIB}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4A9E1F)
                                ),
                              ),
                              const Text(
                                "Solde compte",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                clicked ? "${accountList[index].balance} XAF" : "**********",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4A9E1F)
                                ),
                              ),
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    clicked = !clicked;
                                  });
                                },
                                child: Icon(clicked ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
                              ),
                            ],
                          ),
                        ),

                        // Right column
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Statut:",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 20,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: accountList[index].status == "INACTIVE" ? Colors.red : Color(0xFF4A9E1F),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Text(
                                        accountList[index].status == "INACTIVE" ? "InActive" : "Active",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFDE60FB),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                      child: Text(
                                        accountList[index].pack == null ? "No Pack" : "${accountList[index].pack}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Container(
                                    height: 50,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Pack(BankingId: accountList[index].id!,id: widget.id,email : widget.email)));
                                          },
                                          child: Image.asset("assets/refresh.png", scale: 1.5),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),

                    // Bottom action buttons
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        _buildActionButton(
                            context,
                            "assets/arrow.png",
                            "Transférer",
                                () => Navigator.push(context, MaterialPageRoute(builder: (context) => Choixvirement(id: widget.id!))),
                            color: Colors.black
                        ),
                        _buildActionButton(
                            context,
                            "assets/dbarrow.png",
                            "Déposer",
                                () => Navigator.push(context, MaterialPageRoute(builder: (context) => Done(id:  widget.id!,)))
                        ),
                        _buildActionButton(
                            context,
                            "assets/barrow.png",
                            "Retirer",
                                () => Navigator.push(context, MaterialPageRoute(builder: (context) => Retwo()))
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String imagePath, String label, Function()? onTap, {Color? color}) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            scale: 1.5,
            color: color,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}