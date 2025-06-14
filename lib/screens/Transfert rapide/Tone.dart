import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Transfert%20rapide/Ttwo.dart';

class Tone extends StatefulWidget {
  const Tone({super.key});

  @override
  State<Tone> createState() => _ToneState();
}

class _ToneState extends State<Tone> {
  void showConfirmationDialog(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return SingleChildScrollView(
            child: Container(
              height : MediaQuery.sizeOf(context).height-100,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Padding(padding: EdgeInsets.only(right: 170),child: Text("Type de service",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 120,top: 10),child: Text("Cliquez pour choisir un service",style: TextStyle(
                      fontSize: 18
                  ),),),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Image.asset("assets/imthree.png"),
                          ),),
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Ria Transfert",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Image.asset("assets/imone.png"),
                          ),),
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Kori Transfert",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Image.asset("assets/imtwo.png"),
                          ),),
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Juba express",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Image.asset("assets/imfour.png"),
                          ),),
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Small World",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                 InkWell(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child:  Container(
                     height: 50,
                     width: 400,
                     decoration: BoxDecoration(
                         color: Colors.grey[200],
                         borderRadius: BorderRadius.circular(20)
                     ),
                     child: Row(

                       children: [
                         Padding(padding: EdgeInsets.only(left: 20),child: Container(
                           width: 50,
                           height: 50,
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(20)
                           ),
                           child: Image.asset("assets/imfive.png"),
                         ),),
                         Padding(padding: EdgeInsets.only(left: 20),child: Text("Western Union",style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold
                         ),),),
                       ],
                     ),
                   ),
                 )

                ],
              ),
            ),
          );
        });
  }
  void showConfirmationDialogTwo(BuildContext context ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext){
          return SingleChildScrollView(
            child: Container(
              height : MediaQuery.sizeOf(context).height-100,
              width: 500,
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Padding(padding: EdgeInsets.only(right: 170),child: Text("Mes comptes",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),),),
                  Padding(padding: EdgeInsets.only(right: 30,top: 10),child: Text("Cliquez pour choisir le compte a débiter",style: TextStyle(
                      fontSize: 18
                  ),),),
                  SizedBox(height: 30,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [

                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Courant | 00563862",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [

                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Epargne libre | 0015153768",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [

                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Epargne diaspo | 0056833862",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [

                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Epargne projet | 000965542",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child:  Container(
                      height: 50,
                      width: 400,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(

                        children: [

                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Wallet | 000905236",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),),
                        ],
                      ),
                    ),
                  )

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
                  Padding(padding: EdgeInsets.only(right: 180,top: 50),child: Text("Détails du transfert",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),),
                  SizedBox(height: 20,),
                 InkWell(
                   onTap: (){
                     showConfirmationDialog(context);
                   },
                   child: Container(
                     width: 400,
                     height: 70,
                     decoration: BoxDecoration(
                       color: Color(0xFFF2F2F2),
                       borderRadius: BorderRadius.circular(20),

                     ),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(padding: EdgeInsets.only(left: 20),child: Text("Selectionner le service",style: TextStyle(
                             fontSize: 16
                         ),),),

                         Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.arrow_forward_ios),),

                       ],
                     ),
                   ),
                 ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      showConfirmationDialogTwo(context);
                    },
                    child: Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),

                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Choisir le compte a debiter",style: TextStyle(
                              fontSize: 16
                          ),),),
                          Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.arrow_forward_ios),),
                        ],
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
                        Padding(padding: EdgeInsets.only(left: 20),child: Text("Source des fonds",style: TextStyle(
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
                        Padding(padding: EdgeInsets.only(left: 20),child: Text("Pays de destination",style: TextStyle(
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
                        Padding(padding: EdgeInsets.only(left: 20),child: Text("Ville",style: TextStyle(
                            fontSize: 16
                        ),),),
                        Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.arrow_forward_ios),),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    width: 400,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none
                                ),
                                hintText: "50 000",
                                suffixIcon: Padding(padding: EdgeInsets.only(top: 10),child: Text("XAF",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 18
                                ),),)
                            ),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Solde disponible 300 000 XAF",style: TextStyle(
                                fontSize: 20,

                                color: Colors.white
                            ),),
                          ),
                        ),


                      ],

                    ),
                  ),
                  SizedBox(height: 60,),
                  InkWell(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Ttwo()));
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
