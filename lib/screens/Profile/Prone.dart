import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/PresonModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/ClientDtoProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/PersonProvider.dart';
import 'package:provider/provider.dart';

import '../Bar.dart';

class Prone extends StatefulWidget {
  String email ;
   Prone({super.key, required  this.email});

  @override
  State<Prone> createState() => _ProneState();
}

class _ProneState extends State<Prone> {
  int myIndex = 0;
  var key = GlobalKey<FormState>();
  TextEditingController nom = TextEditingController();
  TextEditingController pernom  =TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController adresse = TextEditingController();
  @override
  void initState() {
    Provider.of<ClientDTOProvider>(context,listen: false).getClientByEmail(widget.email);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ClientModelDTO? client = Provider.of<ClientDTOProvider>(context).client;
    return Scaffold(
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (index){
            setState(() {
              myIndex = index;
            });
          }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Modification"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
          children: [
            SizedBox(height: 80,),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height-100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 100,),
                      Padding(padding: EdgeInsets.only(right: 300,top: 10),child: Text("Nom",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: nom,
                            validator: (value){
                              if(value ==  null || value.isEmpty){
                                return "This field must not be null";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "${client!.firstName}"
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 300,top: 10),child: Text("Prenom",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: pernom,
                            validator: (value){
                              if(value  == null || value.isEmpty){
                                return "This Field must not be null";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "${client!.lastName}"
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 180,top: 10),child: Text("Numéro de téléphone",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: number,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "This Field must not be null";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none
                                ),
                                hintText: "${client!.phoneNumber}",
                                suffixIcon: Icon(Icons.edit)
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 300,top: 10),child: Text("E-mail",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: email,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "This field must not be null";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none
                              ),
                              hintText: "${client!.email}",
                              suffixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 300,top: 10),child: Text("Adresse",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: adresse,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "This field must not be null";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none
                              ),
                              hintText: "${client!.address}",
                              suffixIcon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: ()async{
                          if(key.currentState!.validate()){
                            PersonModel person = PersonModel(
                                email: email.text,
                                role: "USER",
                                address: adresse.text ,
                                country: client.country,
                                sexe: client.sexe,
                                dateOfBirth: client.dateOfBirth,
                                phoneNumber: number.text,
                                firstName: nom.text,
                                lastName: pernom.text,
                                age: client.age);

                            await Provider.of<PersonProvider>(context,listen: false).updatePerson(widget.email, person);
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Prone(email: widget.email)));
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text("Mettre a jour",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: -50,
                    left: 170,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow:[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(4,4)
                            )
                          ]
                      ),
                      child: Center(
                        child: Text("${client!.firstName[0].toUpperCase()}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                      ),
                    ))
              ],
            )
          ],
        ),),
      ),
    );
  }
}
