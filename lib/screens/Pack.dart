import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/ConfirmPack.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountProvider.dart';
import 'package:pfe_banking_system/screens/MesComptes.dart';
import 'package:provider/provider.dart';
class Pack extends StatefulWidget {
  int BankingId;
  int? id ;
  String? email ;
   Pack({super.key,required this.BankingId,  required this.id,required this.email});

  @override
  State<Pack> createState() => _PackState();
}

class _PackState extends State<Pack> {
  int myIndex = 0;
  int index = -1;
  void showConfirmationDialog(BuildContext context , int ind){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return Container(
            height: 450,
            width: 500,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50),child: Image.asset("assets/pone.png",scale: 1.5,),),
                Padding(padding: EdgeInsets.only(top: 30),child: Text("Vous etes sur le point\nde modifier votre package.\nSouhaitez-vous poursuivre ?",style: TextStyle(
                    fontSize: 20
                ),),),
                Padding(padding: EdgeInsets.only(top: 50,left: 60),child:
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child:
                        InkWell(
                          onTap: (){
                            if(index != -1){
                              if(index ==0){
                                Provider.of<BankingProvider>(context,listen: false).setPackForBanking(widget.BankingId.toString(),"Pack OVA");
                              }
                              else if(index ==1){
                                Provider.of<BankingProvider>(context,listen: false).setPackForBanking(widget.BankingId.toString(),"Pack Activa");
                              }
                              else if(index == 2){
                                Provider.of<BankingProvider>(context,listen: false).setPackForBanking(widget.BankingId.toString(),"Pack A.Standard");
                              }
                            }
                           Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmPack(id: widget.id , email : widget.email)));
                          },
                          child: Text("Oui",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(
                        child:
                        Text("No",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                      ),
                    ),
                  ],
                ),),
              ],
            ),
          );
        });
  }
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
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text("Choisissez votre package"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            SingleChildScrollView(

              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 400,
                      height: 700,
                      decoration: BoxDecoration(
                        color: Color(0xFFc8e0bc),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/ptwo.png", scale: 1.5),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Text(
                                      "Pack OVA",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "3000 FCFA/ Mois",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "....................................................................................",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.done, color: Colors.white),
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Mobile Money/ Wallet",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Carte visa prépayée",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Consultation et historique\n des transactions",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Online Banking",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(right: 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "RIB QR code",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 280),
                          InkWell(
                            onTap: (){
                              setState(() {
                                index = 0;
                              });
                              showConfirmationDialog(context,index);
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                    "Choisir l'offre",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 400,
                      height: 700,
                      decoration: BoxDecoration(
                        color: Color(0xFFc8e0bc),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/pthree.png", scale: 1.5),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 30),
                                    child: Text(
                                      "Pack Activa",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "5000 FCFA/ Mois",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "....................................................................................",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.done, color: Colors.white),
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Mobile Money/ Wallet",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Carte visa prépayée",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Consultation et historique\n des transactions",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Online Banking",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(right: 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "RIB QR code",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Chéquier (payant)",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Accompagnement de\nl'obtention du titre\nde séjour (payant)",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 130),
                          InkWell(
                            onTap: (){
                              setState(() {
                                index =1;
                              });
                              showConfirmationDialog(context,index);
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                    "Choisir l'offre",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 400,
                      height: 700,
                      decoration: BoxDecoration(
                        color: Color(0xFFc8e0bc),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/pthree.png", scale: 1.5),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Pack Altitude Standard",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      "6000 FCFA/ Mois",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Text(
                            "....................................................................................",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Icon(Icons.done, color: Colors.white),
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Mobile Money/ Wallet",
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Carte visa prépayée",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Consultation et historique\n des transactions",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(right: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Online Banking",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(right: 80),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "RIB QR code",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Chéquier (payant)",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Accompagnement de\nl'obtention du titre\nde séjour (payant)",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Avance sur salaire\n( jusqu'à 50%)",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(left: 60),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Limite de crédit (5 millions)",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Domiciliation de revenus",
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: EdgeInsets.only(left: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF4A9E1F),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(Icons.done, color: Colors.white),
                                ),
                                SizedBox(width: 15),
                                Text(
                                  "Cash Delivery (payant)",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 35),
                          InkWell(
                            onTap: (){
                              setState(() {
                                index = 2;
                              });
                              showConfirmationDialog(context,index);
                            },
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                    "Choisir l'offre",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
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