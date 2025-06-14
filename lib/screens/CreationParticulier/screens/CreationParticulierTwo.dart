import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/PersonProvider.dart';



import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticulier.dart';

import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticulierSix.dart';

import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticuliereight.dart';
import 'package:pfe_banking_system/screens/MapScreen.dart';
import 'package:provider/provider.dart';

class Creationparticuliertwo extends StatefulWidget {

  String email;
   Creationparticuliertwo({super.key, required this.email});

  @override
  State<Creationparticuliertwo> createState() => _CreationparticuliertwoState();
}

class _CreationparticuliertwoState extends State<Creationparticuliertwo> {
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
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 350),
            child: Image.asset("assets/bambo.png"),
          ),
        ],
      ),
      body: Form(
        key: Key,
        child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 240, top: 20),
            child: Text(
              "Adresse légale",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 400,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ExpansionTile(
                leading: Icon(Icons.flag),
                title: Text("Pays de résidence"),
              ),
            ),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          SizedBox(
            width: 400,
            child: TextFormField(

              validator: (value){
                if(value == null || value.isEmpty){
                  return "This filed must not be null";
                }
              },
              controller: villeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Ville",
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "This field must not be null";
                      }
                    },
                    controller: latitudeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Latitude",
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "This field must not be null";
                      }
                    },
                    controller: longitudeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Longitude",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 400,
            child: TextFormField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This field must not be null";
                }
              },
              controller: quartierController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Quartier",
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 400,
            child: TextFormField(
              controller: ref,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This field must not be null";
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Référence de votre adresse",
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 400,
            child: TextFormField(
              controller: BP,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This field must not be null";
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "BP",
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 400,
            child: TextFormField(
              controller: number,
              validator: (value){
                if(value == null || value.isEmpty){
                  return "This field must not be null";
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Numéro de téléphone de l'association",
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [

              Padding(padding: EdgeInsets.only(left: 90),child: InkWell(
                onTap: () {
                  if(Key.currentState!.validate()){
                    Provider.of<PersonProvider>(context,listen: false).setAddressInfo(
                        ville: villeController.text);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Creationparticuliersix(email : widget.email)));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 50),
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Suivant",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),),

            ],
          )
        ],
      ),),
    );
  }
}
