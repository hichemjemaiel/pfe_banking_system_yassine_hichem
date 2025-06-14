import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/Auth.dart';
import 'package:pfe_banking_system/screens/authentication/model/LoginRequest.dart'; // Changed import
import 'package:pfe_banking_system/screens/authentication/proivder/AuthProvider.dart';
import 'package:provider/provider.dart';

class Creationentreprisenine extends StatefulWidget {
  String email;
  Creationentreprisenine({super.key, required this.email});

  @override
  State<Creationentreprisenine> createState() => _CreationentreprisenineState();
}

class _CreationentreprisenineState extends State<Creationentreprisenine> {
  var key = GlobalKey<FormState>();
  bool clicked = false ;

  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();

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
        child: Form(
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
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ],
              ),),
              Padding(padding: EdgeInsets.only(top: 40),child: Text("Création de mot de passe",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),),
              SizedBox(height: 20,),
              Text("Ce mot de passe, une fois créé, il vous sera\n         demandé pour vous connecter",style: TextStyle(
                  fontSize: 20
              ),),
              SizedBox(height: 40,),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: password1,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Enter a password";
                    }
                    if(value.length<6){
                      return "Password must contain at least 6 characters";
                    }
                    return null;
                  },
                  obscureText: !clicked,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Créer un mot de passe",
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            clicked = !clicked;
                          });
                        },
                        child: Icon(clicked ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),

              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: password2,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Enter a password";
                    }
                    if(value.length<6){
                      return "Password must contain at least 6 characters";
                    }
                    if(password2.text != password1.text){
                      return "Repeat the same password";
                    }
                    return null;
                  },
                  obscureText: !clicked,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Confirmer votre mot de passe",
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            clicked = !clicked;
                          });
                        },
                        child: Icon(clicked ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Condition : 6 Chiffres *",style: TextStyle(
                fontSize: 20,
              ),),
              Padding(padding: EdgeInsets.only(right: 220,top: 20),child: Text("Question secrète",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),),
              SizedBox(height: 40,),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(title: Text("Cliquez pour sélectionner")),
              ),
              SizedBox(height: 30,),
              SizedBox(width: 400,child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Cliquez pour saisir la réponse"
                ),
              ),),
              SizedBox(height: 30,),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(title: Text("Cliquez pour sélectionner")),
              ),
              InkWell(
                onTap: ()async{
                  if(key.currentState!.validate()){
                    // Changed: Use LoginRequest and setPassword instead of RegisterRequest and register
                    LoginRequest request = LoginRequest(email: widget.email, password: password1.text);
                    final success = await Provider.of<AuthProvider>(context,listen: false).setPassword(request);

                    if (success) {
                      // Password set successful
                      if (context.mounted) {
                        Fluttertoast.showToast(
                          msg: 'Password set successfully! Please login.',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auth()));
                      }
                    } else {
                      // Show error
                      if (context.mounted) {
                        Fluttertoast.showToast(
                          msg: Provider.of<AuthProvider>(context,listen: false).error ?? 'Failed to set password',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        Provider.of<AuthProvider>(context,listen: false).clearError();
                      }
                    }
                  }
                },
                child: Padding(padding: EdgeInsets.only(top: 30,right: 5),child: Container(height: 70,width: 300,
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
              ),
            ],
          ),),
      ),
    );
  }
}