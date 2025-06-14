import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:pfe_banking_system/screens/CodeVerif.dart';

class Paiementd extends StatefulWidget {
  const Paiementd({super.key});

  @override
  State<Paiementd> createState() => _PaiementdState();
}

class _PaiementdState extends State<Paiementd> {
  void show(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext) {
      return Container(
        width: double.infinity,
        height: 550,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          children: [

            Padding(padding: EdgeInsets.only(top: 40),child: Text("Récapitulatif",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),),
            SizedBox(height: 50,),
            Text("Code marchand                            0053935",style: TextStyle(fontSize: 20),),
            Text("------------------------------------------------------------------",style: TextStyle(fontSize: 20),),
            Text("Compte à débiter                     0014794527",style: TextStyle(fontSize: 20),),
            Text("------------------------------------------------------------------",style: TextStyle(fontSize: 20),),
            Text("Montant                                       50 000 XAF",style: TextStyle(fontSize: 20),),
            Text("------------------------------------------------------------------",style: TextStyle(fontSize: 20),),
            Text("Marchand                                       Chez Luc",style: TextStyle(fontSize: 20),),
            Text("------------------------------------------------------------------",style: TextStyle(fontSize: 20),),
            Text("Frais                                                1250 XAF",style: TextStyle(fontSize: 20),),
            Padding(padding: EdgeInsets.only(top: 50,left: 20),child: Row(children: [
              Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),

                ),
                child: Center(
                  child: Text("Annuler",style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              SizedBox(width: 10,),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverif()));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(10),


                  ),
                  child: Center(
                    child: Text("Valider",style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              )
            ],),),
          ],
        ),
    );
    });
  }
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (index){
        setState(() {
          myIndex = index;
        });
      }),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        centerTitle: true,
        title: Text("Détail du paiement"),

      ),
      body: Column(
        children: [
          SizedBox(height: 50,),
              Stack(
                children: [
                  Positioned(

                    child  :Image.asset("assets/bambo.png"),)
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height-330,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Text("Chez Luc",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    Text("00241, Libreville,Gabon\n       (+241)77645184",style: TextStyle(
                      fontSize: 15
                    ),),
                    Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Compte a débiter",style: TextStyle(
                        fontSize: 20
                    ),),),
                    Padding(padding: EdgeInsets.only(right: 50,left: 40,top: 20),child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        suffixIcon: Icon(Icons.arrow_forward_ios),
                        hintText: "Cliquer pour sélectionner"
                      ),

                    ),),
                    Padding(padding: EdgeInsets.only(right: 270,top: 40),child: Text("Montant",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 30,),
                    Container(
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.only(right: 50,left: 40,top: 20),child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                fillColor: Colors.grey[200],
                                filled: true,
                                suffix: Text("XAF"),
                                hintText: "50 000"
                            ),

                          ),),
                          Container(
                            width: 350,
                            height: 74,
                            decoration: BoxDecoration(
                              color:Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Text("Solde disponible : 8 500 000 XAF",style: TextStyle(
                                fontSize: 20,
                                color:Colors.white
                              ),),
                            ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: (){
                        show(context);
                      },
                      child:
                      Container(
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text(
                            "Valider",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    )
                  ],
                ),
              ),


        ],
      )
    );
  }
}
