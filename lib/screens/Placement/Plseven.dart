import 'package:flutter/material.dart';

class Plseven extends StatefulWidget {
  const Plseven({super.key});

  @override
  State<Plseven> createState() => _PlsevenState();
}

class _PlsevenState extends State<Plseven> {
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
                    Padding(padding: EdgeInsets.only(top: 50,left: 30),child: Text("Réinitialisation du mot de passe",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),),),
                    SizedBox(height: 20,),
                    Text("Un mail a été envoyé a votre addresse mail\nked*****@gmail.com rattaché au compte.\nVeuillez consulter et suivre les différentes\nétapes pour changer votre mot de passe",style: TextStyle(
                        fontSize: 20
                    ),),

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
                          child: Text("Se connecter",style: TextStyle(
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
