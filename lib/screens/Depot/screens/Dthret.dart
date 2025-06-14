import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dfour.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dfourt.dart';

class Dthret extends StatefulWidget {
  const Dthret({super.key});

  @override
  State<Dthret> createState() => _DthretState();
}

class _DthretState extends State<Dthret> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text("Versement a la banque"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: SingleChildScrollView(
        child:  Column(
          children: [
            Text("           Vous devez maintenant effectuer un\n      virement depuis votre compte BICIG vers le\n                       compte SFE a BICIG",style: TextStyle(
                fontSize: 20
            ),),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height+2200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(title:Row(
                      children: [
                        Image.asset("assets/imtwo.png",scale: 1.5,),
                        SizedBox(width: 20,),
                        Text("BICIG")
                      ],

                    ),children: [
                      Container(
                        width: 400,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Nom du compte",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 10,top: 10),child: Text("EMF SALAM FINANCAL & EXCHANGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(right: 220,top: 10),child: Text("Numéro a renseigner",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 140,top: 10),child: Text("64830 10005450401 32",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            SizedBox(height: 20,),
                            Container(
                              width: 400,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.info,size: 60,color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(top:30,left: 10),child: Column(
                                    children: [
                                      Text("Montant minimum du versement ",style: TextStyle(
                                          fontSize: 20
                                      ),),
                                      Padding(padding: EdgeInsets.only(right: 180),child:  Text("50 000 XAF",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                                    ],
                                  ),),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20,right: 180),child: Text("Options disponible",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 20,top: 20),child:  Row(
                              children: [
                                Image.asset("assets/bank.png",scale: 1.5,),
                                Text("Agenge",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                            Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Row(
                              children: [
                                Image.asset("assets/reone.png",scale: 1.5,),
                                Text("Bank en ligne",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                          ],
                        ),
                      ),
                    ],),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(title:Row(
                      children: [
                        Image.asset("assets/imtwo.png",scale: 1.5,),
                        SizedBox(width: 20,),
                        Text("BICIG")
                      ],

                    ),children: [
                      Container(
                        width: 400,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Nom du compte",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 10,top: 10),child: Text("EMF SALAM FINANCAL & EXCHANGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(right: 220,top: 10),child: Text("Numéro a renseigner",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 140,top: 10),child: Text("64830 10005450401 32",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            SizedBox(height: 20,),
                            Container(
                              width: 400,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.info,size: 60,color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(top:30,left: 10),child: Column(
                                    children: [
                                      Text("Montant minimum du versement ",style: TextStyle(
                                          fontSize: 20
                                      ),),
                                      Padding(padding: EdgeInsets.only(right: 180),child:  Text("50 000 XAF",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                                    ],
                                  ),),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20,right: 180),child: Text("Options disponible",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 20,top: 20),child:  Row(
                              children: [
                                Image.asset("assets/bank.png",scale: 1.5,),
                                Text("Agenge",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                            Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Row(
                              children: [
                                Image.asset("assets/reone.png",scale: 1.5,),
                                Text("Bank en ligne",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                          ],
                        ),
                      ),
                    ],),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(title:Row(
                      children: [
                        Image.asset("assets/imtwo.png",scale: 1.5,),
                        SizedBox(width: 20,),
                        Text("BICIG")
                      ],

                    ),children: [
                      Container(
                        width: 400,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Nom du compte",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 10,top: 10),child: Text("EMF SALAM FINANCAL & EXCHANGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(right: 220,top: 10),child: Text("Numéro a renseigner",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 140,top: 10),child: Text("64830 10005450401 32",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            SizedBox(height: 20,),
                            Container(
                              width: 400,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.info,size: 60,color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(top:30,left: 10),child: Column(
                                    children: [
                                      Text("Montant minimum du versement ",style: TextStyle(
                                          fontSize: 20
                                      ),),
                                      Padding(padding: EdgeInsets.only(right: 180),child:  Text("50 000 XAF",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                                    ],
                                  ),),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20,right: 180),child: Text("Options disponible",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 20,top: 20),child:  Row(
                              children: [
                                Image.asset("assets/bank.png",scale: 1.5,),
                                Text("Agenge",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                            Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Row(
                              children: [
                                Image.asset("assets/reone.png",scale: 1.5,),
                                Text("Bank en ligne",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                          ],
                        ),
                      ),
                    ],),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(title:Row(
                      children: [
                        Image.asset("assets/imtwo.png",scale: 1.5,),
                        SizedBox(width: 20,),
                        Text("BICIG")
                      ],

                    ),children: [
                      Container(
                        width: 400,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Nom du compte",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 10,top: 10),child: Text("EMF SALAM FINANCAL & EXCHANGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(right: 220,top: 10),child: Text("Numéro a renseigner",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 140,top: 10),child: Text("64830 10005450401 32",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            SizedBox(height: 20,),
                            Container(
                              width: 400,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.info,size: 60,color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(top:30,left: 10),child: Column(
                                    children: [
                                      Text("Montant minimum du versement ",style: TextStyle(
                                          fontSize: 20
                                      ),),
                                      Padding(padding: EdgeInsets.only(right: 180),child:  Text("50 000 XAF",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                                    ],
                                  ),),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20,right: 180),child: Text("Options disponible",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 20,top: 20),child:  Row(
                              children: [
                                Image.asset("assets/bank.png",scale: 1.5,),
                                Text("Agenge",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                            Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Row(
                              children: [
                                Image.asset("assets/reone.png",scale: 1.5,),
                                Text("Bank en ligne",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                          ],
                        ),
                      ),
                    ],),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ExpansionTile(title:Row(
                      children: [
                        Image.asset("assets/imtwo.png",scale: 1.5,),
                        SizedBox(width: 20,),
                        Text("BICIG")
                      ],

                    ),children: [
                      Container(
                        width: 400,
                        height: 500,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Nom du compte",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 10,top: 10),child: Text("EMF SALAM FINANCAL & EXCHANGE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(right: 220,top: 10),child: Text("Numéro a renseigner",style: TextStyle(fontSize: 16),),),
                            Padding(padding: EdgeInsets.only(right: 140,top: 10),child: Text("64830 10005450401 32",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            SizedBox(height: 20,),
                            Container(
                              width: 400,
                              height: 120,
                              decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10,),
                                  Icon(Icons.info,size: 60,color: Colors.white,),
                                  Padding(padding: EdgeInsets.only(top:30,left: 10),child: Column(
                                    children: [
                                      Text("Montant minimum du versement ",style: TextStyle(
                                          fontSize: 20
                                      ),),
                                      Padding(padding: EdgeInsets.only(right: 180),child:  Text("50 000 XAF",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                                    ],
                                  ),),
                                ],
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20,right: 180),child: Text("Options disponible",style: TextStyle(
                                fontSize: 20
                            ),),),
                            Padding(padding: EdgeInsets.only(left: 20,top: 20),child:  Row(
                              children: [
                                Image.asset("assets/bank.png",scale: 1.5,),
                                Text("Agenge",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                            Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Row(
                              children: [
                                Image.asset("assets/reone.png",scale: 1.5,),
                                Text("Bank en ligne",style: TextStyle(
                                    fontSize:20,
                                    color: Colors.green
                                ),),
                              ],
                            ),),
                          ],
                        ),
                      ),
                    ],),
                  ),
                  SizedBox(height: 50,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dfourt()));
                    },
                    child: Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text("J'ai effectuer le virement",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
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
