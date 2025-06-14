import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Placement/PThree.dart';

class Pltwo extends StatefulWidget {
  const Pltwo({super.key});

  @override
  State<Pltwo> createState() => _PltwoState();
}

class _PltwoState extends State<Pltwo> {
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
                    Padding(padding: EdgeInsets.only(top: 50,right: 100),child: Text("Mot de passe Oublié",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),),),
                    SizedBox(height: 20,),
                    Text("Ne vous inquiétez pas ! ça arrive . Veuillez\nentrer l'identifiant associé a votre compte .",style: TextStyle(
                      fontSize: 20
                    ),),
                    SizedBox(height: 30,),
                    Padding(padding: EdgeInsets.only(right: 280),child: Text("Identifiant",style: TextStyle(
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

                            ),
                          )
                      ),
                    ),
                    SizedBox(height: 50,),
                    InkWell(
                      onTap : (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Pthree()));
                      },
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Réinitialiser",style: TextStyle(
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
