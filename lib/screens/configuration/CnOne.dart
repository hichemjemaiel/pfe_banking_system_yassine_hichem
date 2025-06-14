import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Bar.dart';

class Cnone extends StatefulWidget {
  const Cnone({super.key});

  @override
  State<Cnone> createState() => _CnoneState();
}

class _CnoneState extends State<Cnone> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (index){
            setState(() {
              myIndex = index;
            });
          }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Configuration"),
        centerTitle: true,
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.exit_to_app,size: 30,),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(right: 20,top: 40),child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
              ),
            ),),
            Padding(padding: EdgeInsets.only(top: 20,right: 10),child:  Text("Yao Boris Kedake",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height-100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 250,top: 40),child: Text("GENERALE",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20),child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Icon(Icons.settings,color: Colors.white,),
                          ),
                        ),),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 140,top: 10),child: Text("Profil",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                           Padding(padding: EdgeInsets.only(right: 10,left: 15),child:  Text("Mettre a jour mon profil",style: TextStyle(fontSize: 18,color: Colors.grey[400],fontWeight: FontWeight.bold),),),

                          ],
                        ),
                        SizedBox(width: 50,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20),child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Icon(Icons.design_services,color: Colors.white,),
                          ),
                        ),),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 60,top: 10),child: Text("Theme",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(left: 15),child:  Text("Choisir le theme ",style: TextStyle(fontSize: 18,color: Colors.grey[400],fontWeight: FontWeight.bold),),),

                          ],
                        ),
                        SizedBox(width: 120,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20),child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Icon(Icons.security,color: Colors.white,),
                          ),
                        ),),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Text("Confidentialité et sécurité",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(right: 20),child:  Text("Protéger votre compte",style: TextStyle(fontSize: 18,color: Colors.grey[400],fontWeight: FontWeight.bold),),),

                          ],
                        ),
                        SizedBox(width: 30,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20),child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Icon(Icons.notifications,color: Colors.white,),
                          ),
                        ),),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Text("Préférence de notification",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                            Padding(padding: EdgeInsets.only(right: 25,left: 15),child:  Text("Changer vos parametres",style: TextStyle(fontSize: 18,color: Colors.grey[400],fontWeight: FontWeight.bold),),),

                          ],
                        ),
                        SizedBox(width: 30,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20),child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Icon(Icons.settings,color: Colors.white,),
                          ),
                        ),),
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Text("Signaler une erreur",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),


                          ],
                        ),
                        SizedBox(width: 90,),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
