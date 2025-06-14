import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/Auth.dart';
import 'package:pfe_banking_system/screens/authentication/model/LoginRequest.dart';
import 'package:pfe_banking_system/screens/authentication/model/RegisterRequest.dart';
import 'package:pfe_banking_system/screens/authentication/proivder/AuthProvider.dart';
import 'package:provider/provider.dart';

class Psthree extends StatefulWidget {
  String? email;
  Psthree({super.key, required this.email});

  @override
  State<Psthree> createState() => _PsthreeState();
}

class _PsthreeState extends State<Psthree> {
  var key = GlobalKey<FormState>();
  bool clicked = false;

  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();

  String? selectedQuestion1;
  String? selectedQuestion2;

  final List<String> securityQuestions = [
    "Quel est le nom de votre premier animal de compagnie?",
    "Dans quelle ville êtes-vous né(e)?",
    "Quel est le nom de jeune fille de votre mère?",
    "Quel était le nom de votre école primaire?",
    "Quel est votre plat préféré?",
    "Quel est le nom de votre meilleur ami d'enfance?"
  ];

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
        child: Form(
          key: key,
          child: Padding(padding: EdgeInsets.only(left: 25),child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 40),child: Text("Création d'un noveau mot de passe",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),),
              SizedBox(height: 20,),
              Text("Ce mot de pass, une fois créer il vous sera\n         demandé pour vous connecter",style: TextStyle(
                  fontSize: 20
              ),),
              SizedBox(height: 40,),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: password1,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Enter a passowrd";
                    }
                    if(value.length<6){
                      return "Password must contain at least 6 characters";
                    }
                    return null;
                  },
                  obscureText: !clicked ? true : false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Créer un noveau mot de passe",
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            !clicked ? clicked = true : clicked = false;
                          });
                        },
                        child: !clicked ? Icon(Icons.remove_red_eye_outlined) :Icon(Icons.remove_red_eye),
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
                    if(password2.text!=password1.text){
                      return "Repeat the same password";
                    }
                    return null;
                  },
                  obscureText: !clicked ? true : false,
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
                            !clicked ? clicked = true : clicked = false;
                          });
                        },
                        child: !clicked ? Icon(Icons.remove_red_eye_outlined) :Icon(Icons.remove_red_eye),
                      )
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("Condition : 6 Chiffres *",style: TextStyle(
                fontSize: 20,
              ),),
              Padding(padding: EdgeInsets.only(right: 180,top: 20),child: Text("Première question secrète",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),),
              SizedBox(height: 20,),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ExpansionTile(
                  title: Text(selectedQuestion1 ?? "Cliquez pour sélectionner"),
                  children: securityQuestions.map((question) {
                    return ListTile(
                      title: Text(question),
                      onTap: () {
                        setState(() {
                          selectedQuestion1 = question;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: answer1,
                  validator: (value) {
                    if (selectedQuestion1 != null && (value == null || value.isEmpty)) {
                      return "Veuillez répondre à la question";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Votre réponse à la première question"
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(padding: EdgeInsets.only(right: 170,top: 10),child: Text("Deuxième question secrète",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),),
              SizedBox(height: 20,),
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ExpansionTile(
                  title: Text(selectedQuestion2 ?? "Cliquez pour sélectionner"),
                  children: securityQuestions.where((question) => question != selectedQuestion1).map((question) {
                    return ListTile(
                      title: Text(question),
                      onTap: () {
                        setState(() {
                          selectedQuestion2 = question;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: answer2,
                  validator: (value) {
                    if (selectedQuestion2 != null && (value == null || value.isEmpty)) {
                      return "Veuillez répondre à la question";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Votre réponse à la deuxième question"
                  ),
                ),
              ),
              InkWell(
                onTap: ()async{
                  if(key.currentState!.validate()){
                    if(selectedQuestion1 == null || selectedQuestion2 == null) {
                      _showToast("Veuillez sélectionner les deux questions de sécurité");
                      return;
                    }

                    LoginRequest request = LoginRequest(email: widget.email!, password: password1.text);
                    await Provider.of<AuthProvider>(context,listen: false).resetPassword(request);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Auth()));
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
          ),),),
      ),
    );
  }
}