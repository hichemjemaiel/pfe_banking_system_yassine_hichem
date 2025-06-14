import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Placement/Plseven.dart';

class Plsix extends StatefulWidget {
  const Plsix({super.key});

  @override
  State<Plsix> createState() => _PlsixState();
}

class _PlsixState extends State<Plsix> {
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
                    Padding(padding: EdgeInsets.only(top: 50,right: 250),child: Text("ID Oublié",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),),),
                    SizedBox(height: 20,),
                    Text("Ne vous inquiétez pas ! ça arrive . Veuillez\nentrer l'identifiant associé a votre compte .",style: TextStyle(
                        fontSize: 20
                    ),),
                    SizedBox(height: 30,),
                    Padding(padding: EdgeInsets.only(right: 200),child: Text("Numéro de compte",style: TextStyle(
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
                              hintText: "Cliquer pour saisir",
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Plseven()));
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
    );;
  }
}
