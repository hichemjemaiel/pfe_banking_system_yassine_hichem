import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/provider/MoralPersonProvider.dart';


import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntrepriseFour.dart';
import 'package:provider/provider.dart';

import '../../MapScreen.dart';

class Creationentreprisethree extends StatefulWidget {
  String email;
   Creationentreprisethree({super.key, required this.email});

  @override
  State<Creationentreprisethree> createState() => _CreationentreprisethreeState();
}

class _CreationentreprisethreeState extends State<Creationentreprisethree> {
  TextEditingController villeController = TextEditingController();
  TextEditingController quartierController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController ref = TextEditingController();
  TextEditingController BP = TextEditingController();
  TextEditingController number =TextEditingController();
  var Key = GlobalKey<FormState>();
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height+200,
          child: Form(
            key:  Key,
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


                  ],
                ),),
                Padding(padding: EdgeInsets.only(right: 160,top: 20),child: Text("Adresse de l'entreprise",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),),
                Padding(padding: EdgeInsets.only(right: 25),child: Text("Renseigner les informations correct de votre entrprise"),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),child: ExpansionTile(leading : Icon(Icons.flag),title: Text("Pays de résidence"),),
                ),),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapScreen()),
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      setState(() {
                        latitudeController.text = result["latitude"].toString();
                        longitudeController.text = result["longitude"].toString();
                        villeController.text = result["ville"] ?? "Unknown";
                        quartierController.text = result["quartier"] ?? "Unknown";
                      });
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Color(0xFF4A9E1F)),
                        SizedBox(width: 10),
                        Text(
                          "Localiser ma position",
                          style: TextStyle(
                            color: Color(0xFF4A9E1F),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: villeController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Ville"
                  ),
                ),),
                SizedBox(height: 20,),
                Padding(padding: EdgeInsets.only(left: 10),child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 200,
                      child:TextFormField(
                        controller: latitudeController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "This field must not be null";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Latitude"
                        ),
                      ),),
                    SizedBox(width: 200,
                      child:TextFormField(
                        controller: longitudeController,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "this field must not be null";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Longitude"
                        ),
                      ),),
                  ],
                ),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: quartierController,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Quartier"
                  ),
                ),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: ref,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Référence de votre adresse"
                  ),
                ),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: BP,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "BP"
                  ),
                ),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: number,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Numéro de téléphone de l'association"
                  ),
                ),),
                SizedBox(height: 20,),
                Row(
                  children: [

                    Padding(padding:EdgeInsets.only(left: 100),child: InkWell(
                      onTap: (){
                        if(Key.currentState!.validate()){
                          Provider.of<MoralPersonProvider>(context,listen: false).setAddress(
                              ville: villeController.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Creationentreprisefour(email : widget.email)));
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
                ),
              ],
            ),),
        )
      )
    );
  }
}
