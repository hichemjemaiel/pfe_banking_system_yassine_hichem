import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../CodeVerif.dart';

class Ttwo extends StatefulWidget {
  const Ttwo({super.key});

  @override
  State<Ttwo> createState() => _TtwoState();
}

class _TtwoState extends State<Ttwo> {
  void showConfirmationDialog(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return SingleChildScrollView(
            child: Container(
              height : MediaQuery.sizeOf(context).height+100,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Text("Récapitulatif",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                  SizedBox(height: 30,),
                  Text("Type de service             Compte Courant",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Compte a débiter                 0014794527",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Destination                                   GABON",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Ville                                             Libreville",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Montant                                 200 000 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Frais transfert                              1500 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Frais opérations                             500 XAF",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Bénéficaire                                Viny Emane",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Tel Bénéficaire            (+241) 66 88 99 65",style: TextStyle(fontSize: 20),),
                  Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                  ),),
                  Text("Montant total                          202 000 XAF",style: TextStyle(fontSize: 20),),
                  Padding(padding: EdgeInsets.only(top: 70,left: 60),child:
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Center(
                          child:
                          InkWell(
                            onTap: (){

                            },
                            child: Text("Annuler",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Codeverif()));
                        },
                        child:  Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child:
                            Text("Valider",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),),
                          ),
                        ),
                      )
                    ],
                  ),),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          title: Text("Transfert d'argent"),
          centerTitle: true,
          backgroundColor: Color(0xFFF2F2F2),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),

              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height+100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                       Padding(padding: EdgeInsets.only(left: 20),child:  Icon(Icons.info,color: Colors.green,),),
                        Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Rassurez-vous de bien renseigner les\ninformations du bénéficaire telles que\nreprises sur sa piece d'identité",style: TextStyle(
                            fontSize: 20
                        ),),),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(right: 180,top: 20),child: Text("Détails du bénéficaire",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),),
                    SizedBox(height: 40,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 180,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Nom"
                              ),
                            ),
                          ),
                          ),
                        Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: "Prénom"
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "Téléphone"
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Objet de la transaction",style: TextStyle(
                              fontSize: 16
                          ),),),
                          Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.arrow_forward_ios),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Relations",style: TextStyle(
                              fontSize: 16
                          ),),),
                          Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.arrow_forward_ios),),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Question (facultative)",style: TextStyle(
                              fontSize: 16
                          ),),),
                          Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.arrow_forward_ios),),
                        ],
                      ),
                    ),

                    SizedBox(height: 60,),
                    InkWell(
                      onTap: (){
                          showConfirmationDialog(context);
                      },
                      child:  Container(
                        width: 300,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Suivant",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white
                          ),),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
