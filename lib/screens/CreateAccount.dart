import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Auth.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntreprise.dart';

import 'CreationParticulier/screens/CreationParticulier.dart';

class Createaccount extends StatefulWidget {
  const Createaccount({super.key});

  @override
  State<Createaccount> createState() => _CreateaccountState();
}

class _CreateaccountState extends State<Createaccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        actions: [
          Padding(padding: EdgeInsets.only(right: 350),child: Image.asset("assets/bambo.png",),)
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 40,right: 230),child: Text("Commençons",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A9E1F)
          ),),),
          Padding(padding: EdgeInsets.only(left: 30,top: 20),child: Text("Afin de mieux vous proposer une meilleure\nexpérience,Veuilllez sélectionner ci-dessous\nle type de compte qui corresponds le mieux\na votre profil.",style: TextStyle(
            fontSize: 20,

          ),),),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(

              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Creationparticulier()));
                  },
                  child: Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
                    height: 380,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(20),child: Image.asset("assets/gtwo.png",scale: 1.8,),),
                        Padding(padding: EdgeInsets.only(top: 10,right: 120),child: Text("Particulier",style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A9E1F)
                        ),),),
                        Padding(padding: EdgeInsets.only(left: 30),child: Text("Gérez vos finances\npersonnelles en toute\n simplicité et accédez à\nune gamme complete de\nservices bancaires pour\nrépondre a vos besoins quotidiens .",style: TextStyle(
                            fontSize: 18
                        ),),),
                      ],
                    ),
                  ),),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Creationentreprise()));
                  },
                  child: Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
                    height: 380,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.all(20),child: Image.asset("assets/gthree.png",scale: 1.8,),),
                        Padding(padding: EdgeInsets.only(top: 10,right: 80),child: Text("Professionnel",style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4A9E1F)
                        ),),),
                        Padding(padding: EdgeInsets.only(left: 30),child: Text("Simplifiez la gestion de vos finances d'entreprise,\naccédez a des solutions sur mesure et développez votre activité en toute confiance",style: TextStyle(
                            fontSize: 18
                        ),),),
                      ],
                    ),
                  ),),
                ),


              ],

            ),
          ),
          SizedBox(height: 40,),
          Container(
            width: 350,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFF4A9E1F),
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text("Suivant",style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 25),child: Text("Conditions générales",style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.grey,
              fontSize: 18
          ),),),
          Padding(padding: EdgeInsets.only(left: 80,top: 20),child: Row(
            children: [
              Text("Deja un compte?",style: TextStyle(
                  fontWeight: FontWeight.bold,

                  fontSize: 20
              ),),
              InkWell(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auth()));
                },
                child: Text("Se connecter",style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xFF4A9E1F),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),),

        ],
      ),
    );
  }
}
