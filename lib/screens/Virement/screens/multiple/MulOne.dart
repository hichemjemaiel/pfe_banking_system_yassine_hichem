import 'package:flutter/material.dart';

import '../../../Bar.dart';
import '../../../CodeVerif.dart';
import 'AjoutBeneficarieOne.dart';

class Mulone extends StatefulWidget {
  const Mulone({super.key});

  @override
  State<Mulone> createState() => _MuloneState();
}

class _MuloneState extends State<Mulone> {
  int myIndex = 0;
  int nb = 0;
  bool clicked = false;
  void showConfirmationDialog(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return Container(
            height: 450,
            width: 500,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text("Récapitulatifs du virement",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
                SizedBox(height: 30,),
                Text("Compte  a débiter       Compte Courant",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Montant                                    50 000 XAF",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Compte bénéficaire                      0057246",style: TextStyle(fontSize: 20),),
                Text("- - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - -",style: TextStyle(fontSize: 20
                ),),
                Text("Bénéficaire                                   Emane.V",style: TextStyle(fontSize: 20),),
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
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Bar(myIndex: myIndex, onTap: (ind){
          setState(() {
            myIndex = ind;
          });
        }),
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Virements multiple"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Compte a débiter",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 20,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                        child:  ExpansionTile(title: Text("Cliquer pour selectionner")),
                      ),
                    ),

                    Padding(padding: EdgeInsets.only(right: 280,top: 40),child: Text("Montant",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
                    Container(
                        width: 400,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Column(
                          children: [
                            Container(
                              width: 400,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: Color(0xFFF7F7F7),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none
                                      ),
                                      hintText: "Cliquer pour saisir le montant",
                                      hintStyle: TextStyle(
                                          fontSize: 16
                                      ),
                                      suffixIcon: Padding(padding: EdgeInsets.only(top: 10,right: 20),child: Text("XAF",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
                                    ),
                                  )
                              ),
                            ),
                            Container(
                              width: 400,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(child: Text("Solde disponible : 8500 000 XAF",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),),),
                            )
                          ],
                        )
                    ),

                    Padding(padding: EdgeInsets.only(right: 170,top: 40),child: Text("Nombre de bénéficaire",style: TextStyle(
                        fontSize: 20
                    ),),),
                    SizedBox(height: 10,),
                    Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:Center(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                           InkWell(
                             onTap: (){
                               if(nb>0){
                                 setState(() {
                                   nb--;
                                 });
                               }
                             },
                             child:  Padding(padding: EdgeInsets.only(bottom: 10),child: Icon(Icons.minimize_sharp,size: 30,),),
                           ),
                            Text("0${nb}",style: TextStyle(
                              fontSize: 20
                            ),),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  if(nb<2){
                                    nb++;
                                  }
                                });
                              },
                              child: Icon(Icons.add,size: 30,),
                            )
                          ],
                        )
                      ),
                    ),
                      Padding(padding: EdgeInsets.only(right: 290,top: 40),child: Text("Motif",style: TextStyle(
                          fontSize: 20
                      ),),),
                      SizedBox(height: 10,),
                      Container(
                        width: 400,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child:Center(
                          child:  TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                hintText: "Cliquez pour saisir votre motif"
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap : (){
                        setState(() {
                          clicked == false ? clicked = true : clicked = false;
                        });
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                            color: clicked == false ?Colors.grey[200] : Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Raison commune",style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap : (){
                        //showConfirmationDialog(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Ajoutbeneficarieone()));
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Continuer",style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
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
