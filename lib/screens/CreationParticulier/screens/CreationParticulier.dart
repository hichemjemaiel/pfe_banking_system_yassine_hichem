import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/PersonProvider.dart';

import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticulierTwo.dart';
import 'package:provider/provider.dart';

class Creationparticulier extends StatefulWidget {
  const Creationparticulier({super.key});

  @override
  State<Creationparticulier> createState() => _CreationparticulierState();
}

class _CreationparticulierState extends State<Creationparticulier> {
  int index = 0;

  String selectedCountry="Country";
  var PersonKey = GlobalKey<FormState>();
  TextEditingController nom =TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController jour = TextEditingController();
  TextEditingController mois = TextEditingController();
  TextEditingController annee = TextEditingController();

  void _showToast(String message, {bool isError = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Widget to create Tunisia flag
  Widget tunisiaFlag() {
    return Container(
      width: 24,
      height: 16,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Stack(
        children: [
          // Red background
          Container(
            width: 24,
            height: 16,
            color: Color(0xFFE70013),
          ),
          // White circle
          Center(
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Color(0xFFE70013),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.star,
                      color: Color(0xFFE70013),
                      size: 4,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to create Gabon flag
  Widget gabonFlag() {
    return Container(
      width: 24,
      height: 17,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Column(
        children: [
          // Green stripe
          Container(
            width: 24,
            height: 5.33,
            color: Color(0xFF009E60),
          ),
          // Yellow stripe
          Container(
            width: 24,
            height: 5.33,
            color: Color(0xFFFCD116),
          ),
          // Blue stripe
          Container(
            width: 24,
            height: 5.33,
            color: Color(0xFF3A75C4),
          ),
        ],
      ),
    );
  }

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
          child:
          Form(
            key: PersonKey,
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
                Padding(padding: EdgeInsets.only(top: 20,right: 150),child: Text("Informations personelles",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),),),
                Padding(padding: EdgeInsets.only(right: 50,top: 10 ),child: Text("Pour commencer , nous avons besoin de\nquelquesinformation",style: TextStyle(
                    fontSize: 18
                ),),),
                Padding(padding: EdgeInsets.only(top: 20,left: 50),child: Row(
                  children: [

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          index = 0;
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: index ==0 ? Colors.green :Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Monsieur",style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                    SizedBox(width: 30,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          index = 1;
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            color: index ==1 ? Colors.green :Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Madame",style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ],
                ),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: nom,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "This field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Nom"
                  ),
                ),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: prenom,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "This field must not be null";
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Prénom"
                  ),
                ),),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: age,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "this field must be null";
                    }
                    final intValue = int.tryParse(value);
                    if(intValue == null){
                      return "this field must be a number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Age",

                  ),
                ),),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ExpansionTile(
                        leading: selectedCountry == "Country" ? Icon(Icons.flag) :
                        selectedCountry == "Tunisia" ? tunisiaFlag() : gabonFlag(),
                        title: Text(selectedCountry),
                        children: [
                          ListTile(
                            onTap:(){
                              setState(() {
                                selectedCountry = "Gabon";
                              });
                            },
                            leading: gabonFlag(),
                            title: Text("Gabon +241"),
                          ),
                          ListTile(
                            onTap: (){
                              setState(() {
                                selectedCountry = "Tunisia";
                              });
                            },
                            leading: tunisiaFlag(),
                            title: Text("Tunisia +216"),
                          )
                        ],
                      ),
                    ),),
                    Padding(padding: EdgeInsets.only(top: 20,left: 5),child: SizedBox(width: 240,child: TextFormField(
                      controller: number,
                      validator: (value){
                        if(value == null || value.isEmpty ){
                          return "This field must not be null";
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "00 00 00"
                      ),
                    ),),),
                  ],
                ),
                SizedBox(height: 20,),
                SizedBox(width: 400,child: TextFormField(
                  controller: email,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "This field must not be null";

                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "E-mail"
                  ),
                ),),
                Padding(padding: EdgeInsets.only(right: 200,top: 20),child: Text("Date de naissance",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
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
                          if(value == null || value.isEmpty  ){
                            return "This field must not be null";
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
                            return "This field must not be null";
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
                            return "This field must not be null";
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
                Row(
                  children: [

                    Padding(padding: EdgeInsets.only(left: 90),child: InkWell(
                      onTap: () async{
                        if(index != -1){
                          final EmailValid = await Provider.of<PersonProvider>(context,listen: false).validateEmail(email.text);
                          final PhoneValid = await Provider.of<PersonProvider>(context,listen: false).validatePhone(number.text);
                          if(PersonKey.currentState!.validate()){
                            if(EmailValid && PhoneValid){
                              Provider.of<PersonProvider>(context, listen: false).setPersonInfo(
                                  nom: nom.text,
                                  prenom: prenom.text,
                                  age: int.parse(age.text),
                                  number: number.text,
                                  email: email.text,
                                  jour: jour.text,
                                  mois: mois.text,
                                  annee: annee.text,
                                  selectedCountry: selectedCountry,
                                  gender: index == 0 ? "Male" : "Female");

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Creationparticuliertwo(email: email.text)));
                            }else{
                              if(!EmailValid){
                                _showToast("Email already exists");
                              }
                              if (!PhoneValid) {
                                _showToast("Phone number already exists");
                              }
                            }



                          }

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
        )
    );
  }


}