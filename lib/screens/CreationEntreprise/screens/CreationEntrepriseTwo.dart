import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/provider/MoralPersonProvider.dart';


import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntrepriseThree.dart';
import 'package:provider/provider.dart';
class Creationentreprisetwo extends StatefulWidget {
  String email;
   Creationentreprisetwo({super.key, required this.email});

  @override
  State<Creationentreprisetwo> createState() => _CreationentreprisetwoState();
}

class _CreationentreprisetwoState extends State<Creationentreprisetwo> {
  var key = GlobalKey<FormState>();
  TextEditingController jour = TextEditingController();
  TextEditingController mois = TextEditingController();
  TextEditingController annee= TextEditingController();
  TextEditingController abr = TextEditingController();
  TextEditingController RCCM =TextEditingController();
  TextEditingController NIF = TextEditingController();
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
      body: Form(
        key: key,
        child: Column(
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
          Padding(padding: EdgeInsets.only(right: 140,top: 30),child: Text("Information de l'entreprise",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),),
          SizedBox(height: 20,),
          Container(
            width: 400,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(title: Text("Raison social")),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(title: Text("Forme Juridique")),
          ),
          SizedBox(height: 20,),
          Container(
            width: 400,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: ExpansionTile(title: Text("Catégorie")),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: 400,
            child: TextFormField(
              controller: abr,
              validator: (value){
                if(value == null || value.isEmpty){
                  return  "this field must not be null";
                }
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  ),
                  hintText: "Abréviation",
                  filled: true,
                  fillColor: Colors.white              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(right: 220,top: 20),child: Text("Date de création",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 120,
                child: TextFormField(
                  controller: jour,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }

                  },
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Jour"
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: TextFormField(
                  controller: mois,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }

                  },
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Mois"
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: TextFormField(
                  controller: annee,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Année"
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: RCCM,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Code RCCM"
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: TextFormField(
                  controller: NIF,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Code NIF"
                  ),
                ),
              ),

            ],
          ),
          SizedBox(height: 40,),
          Row(
            children: [

              Padding(padding: EdgeInsets.only(left: 100),child: InkWell(
                onTap: (){
                  if(key.currentState!.validate()){
                    Provider.of<MoralPersonProvider>(context,listen: false).setCreationDate(
                        cJour: jour.text,
                        cMois: mois.text,
                        cAnnee: annee.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Creationentreprisethree(email : widget.email)));
                  }

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
          )
        ],
      ),),
    );
  }
}
