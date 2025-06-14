import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/provider/MoralPersonProvider.dart';


import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntrepriseTwo.dart';
import 'package:provider/provider.dart';

class Creationentreprise extends StatefulWidget {
  const Creationentreprise({super.key});

  @override
  State<Creationentreprise> createState() => _CreationentrepriseState();
}

class _CreationentrepriseState extends State<Creationentreprise> {
  var MoralKey = GlobalKey<FormState>();
  TextEditingController nom =TextEditingController();
  TextEditingController prenom = TextEditingController();

  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController jour = TextEditingController();
  TextEditingController mois = TextEditingController();
  TextEditingController annee = TextEditingController();
  int index = -1;
  String selectedCountry="Country";

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
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height*100,
          child: Form(
            key: MoralKey,
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

                          borderRadius: BorderRadius.circular(10),
                          color: index ==0 ? Color(0xFF4A9E1F) : Colors.white
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
                        index =1;
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          color: index == 1 ? Color(0xFF4A9E1F) : Colors.white
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
                    hintText: "Nom"
                ),
              ),),
              SizedBox(height: 20,),
              SizedBox(width: 400,child: TextFormField(
                controller: prenom,
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
                    hintText: "Prénom"
                ),
              ),),
              SizedBox(height: 20,),

              Row(
                children: [
                  Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
                    width: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ExpansionTile(leading: Icon(Icons.flag),title:Text(selectedCountry),children: [
                      ListTile(
                        onTap:(){
                          setState(() {
                            selectedCountry = "Gabon";
                          });
                        },
                        leading:Icon(Icons.flag) ,
                        title: Text("Gabon +241"),
                      ),
                      ListTile(
                        onTap: (){
                          setState(() {
                            selectedCountry = "Tunisia";
                          });
                        },
                        leading: Icon(Icons.flag),
                        title: Text("Tunisia +216"),
                      )
                    ],),
                  ),),
                  Padding(padding: EdgeInsets.only(top: 20,left: 5),child: SizedBox(width: 240,child: TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "this field must not be null";
                      }
                    },
                    controller: number,
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
                controller:email ,
                validator: (value){
                  if(value == null || value.isEmpty ){
                    return "this field must not be null";
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
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "this field must not be null";
                        }
                      },
                      controller: mois,
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
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "this field must not be null";
                        }
                      },
                      controller: annee,
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
              Container(
                width: 420,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: ExpansionTile(title: Text("Ou avez-vous entendu parler d'SFE?")),
              ),
              Row(

                children: [

                  Padding(padding: EdgeInsets.only(left:90,top: 10),child: InkWell(
                    onTap: () async{
                      if( index != -1){
                        final validateEmail = await Provider.of<MoralPersonProvider>(context,listen: false).validateEmail(email.text);
                        final validatePhone = await Provider.of<MoralPersonProvider>(context,listen: false).validatePhone(number.text);
                        if(MoralKey.currentState!.validate()){
                          if(validateEmail && validatePhone){
                            Provider.of<MoralPersonProvider>(context,listen: false).setPersonInfo(
                                nom: nom.text,
                                prenom: prenom.text,
                                selectedCountry: selectedCountry,
                                gender: index ==0 ? "Male" :"Female",
                                number: number.text,
                                email: email.text,
                                jour: jour.text,
                                mois: mois.text,
                                annee: annee.text);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Creationentreprisetwo(email : email.text)));
                          }else{
                            if(!validateEmail){
                              _showToast("Email already exists");
                            }
                            if(!validatePhone){
                              _showToast("Phone already exists");
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
              ),
            ],
          ),),
        )
      )
    );
  }
}
