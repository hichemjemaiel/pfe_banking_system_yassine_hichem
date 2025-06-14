import 'package:flutter/material.dart';

class Plfive extends StatefulWidget {
  const Plfive({super.key});

  @override
  State<Plfive> createState() => _PlfiveState();
}

class _PlfiveState extends State<Plfive> {
  bool clicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Mot de passe oublié"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child:Column(
            children: [
              SizedBox(height: 100,),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height-100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 50,right: 50),child: Text("Veuillez modifier votre mot de passe",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),),),
                    Padding(padding: EdgeInsets.only(right: 180,top: 20),child: Text("Ancien mot de passe",style: TextStyle(
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
                              suffixIcon: Icon(Icons.remove_red_eye)
                            ),
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 200,top: 20),child: Text("Nouveau (6 chiffres)",style: TextStyle(
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
                                suffixIcon: Icon(Icons.remove_red_eye)
                            ),
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(right: 140,top: 20),child: Text("Confirmer le mot de passe",style: TextStyle(
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
                                suffixIcon: Icon(Icons.remove_red_eye)
                            ),
                          )
                      ),
                    ),
                    Row(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 40,left: 30),child: InkWell(
                          onTap: (){
                            setState(() {
                              clicked == false ? clicked = true : clicked = false;
                            });
                          },
                          child: Icon(Icons.info,color: Colors.green,),
                        ),),
                        clicked ? Padding(padding: EdgeInsets.only(top: 40,left: 10),child: Text("Pour la sécurité de votre compte . veuillez\ncréer un mot de passe fort a six chiffres",style: TextStyle(
                            fontSize: 18
                        ),),):Text(""),
                      ],
                    ),
                    SizedBox(height: 50,),
                    InkWell(
                      onTap : (){

                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Mettre a jour",style: TextStyle(
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
