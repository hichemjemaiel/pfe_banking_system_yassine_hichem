import 'package:flutter/material.dart';

import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntrepriseSix.dart';

class Creationentreprisefour extends StatefulWidget {
  String email;
   Creationentreprisefour({super.key, required  this.email});

  @override
  State<Creationentreprisefour> createState() => _CreationentreprisefourState();
}

class _CreationentreprisefourState extends State<Creationentreprisefour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        actions: [
          Padding(padding: EdgeInsets.only(right: 350),child: Image.asset("assets/bambo.png"),),
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 30,left: 60),child: Row(

            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF6C6C6C),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF6C6C6C),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF6C6C6C),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),


            ],
          ),),
          Padding(padding: EdgeInsets.only(right: 190,top: 20),child: Text("Autres informations",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),),

          Padding(padding: EdgeInsets.only(left:35,top: 20),child: Text("Renseignez les informations correct de votre entreprise",style: TextStyle(
            fontSize: 18,

          ),),),
          SizedBox(height: 20,),
          Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(title: Text("Taille de l'entreprise")),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(title: Text("Secteur d'activité")),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(title: Text("Domaine d'activité")),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(title: Text("Type de piece juridique")),
          ),
          SizedBox(height: 20,),
          SizedBox(
              width: 400,
              child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: Icon(Icons.cloud_upload),
                hintText: "Type de piece juridique"
            ),
          ),),
          SizedBox(height: 40,),
          Row(
            children: [

              Padding(padding: EdgeInsets.only(left: 100),child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Creationentreprisersix(email : widget.email)));
                },
                child: Padding(padding: EdgeInsets.only(top: 30,left: 50),child: Container(height: 50,width: 150,
                  decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Suivant",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ),
                ),),
              ),),

            ],
          ),
        ],
      ),
    );
  }
}
