import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/Auth.dart';
import 'package:pfe_banking_system/screens/authentication/model/LoginRequest.dart';
import 'package:pfe_banking_system/screens/authentication/proivder/AuthProvider.dart';
import 'package:provider/provider.dart';

class Creationparticuliernine extends StatefulWidget {
  String email;
  Creationparticuliernine({super.key, required this.email});

  @override
  State<Creationparticuliernine> createState() => _CreationparticuliernineState();
}

class _CreationparticuliernineState extends State<Creationparticuliernine> {
  var key = GlobalKey<FormState>();
  bool clicked = false;

  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();

  String? selectedQuestion1;
  String? selectedQuestion2;
  String selectedQuestion1Text = "Cliquez pour sélectionner";
  String selectedQuestion2Text = "Cliquez pour sélectionner";

  // Secret questions list
  final List<Map<String, String>> secretQuestions = [
    {"id": "mother_maiden_name", "question": "Quel est le nom de jeune fille de votre mère?"},
    {"id": "birth_city", "question": "Dans quelle ville êtes-vous né(e)?"},
    {"id": "first_school", "question": "Quel était le nom de votre première école?"},
    {"id": "childhood_nickname", "question": "Quel était votre surnom d'enfance?"},
    {"id": "first_pet", "question": "Quel était le nom de votre premier animal de compagnie?"},
    {"id": "favorite_teacher", "question": "Quel était le nom de votre professeur préféré?"},
    {"id": "paternal_grandfather", "question": "Quel est le prénom de votre grand-père paternel?"},
    {"id": "mother_birth_city", "question": "Dans quelle ville votre mère est-elle née?"},
    {"id": "favorite_book", "question": "Quel est le titre de votre livre préféré?"},
    {"id": "dream_destination", "question": "Quelle est votre destination de voyage de rêve?"},
  ];

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

              // First Secret Question
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(
                  title: Text(selectedQuestion1Text),
                  children: secretQuestions.map((question) {
                    return ListTile(
                      title: Text(question["question"]!),
                      onTap: () {
                        setState(() {
                          selectedQuestion1 = question["id"];
                          selectedQuestion1Text = question["question"]!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20),

              // First Answer Field
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: answer1,
                  validator: (value) {
                    if (selectedQuestion1 == null) {
                      return "Veuillez sélectionner une question secrète";
                    }
                    if (value == null || value.isEmpty) {
                      return "Veuillez saisir la réponse";
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
                      hintText: "Cliquez pour saisir la réponse"
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Second Secret Question
              Container(
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ExpansionTile(
                  title: Text(selectedQuestion2Text),
                  children: secretQuestions.where((question) => question["id"] != selectedQuestion1).map((question) {
                    return ListTile(
                      title: Text(question["question"]!),
                      onTap: () {
                        setState(() {
                          selectedQuestion2 = question["id"];
                          selectedQuestion2Text = question["question"]!;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20),

              // Second Answer Field
              SizedBox(
                width: 400,
                child: TextFormField(
                  controller: answer2,
                  validator: (value) {
                    if (selectedQuestion2 == null) {
                      return "Veuillez sélectionner une deuxième question secrète";
                    }
                    if (value == null || value.isEmpty) {
                      return "Veuillez saisir la réponse";
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
                      hintText: "Cliquez pour saisir la réponse"
                  ),
                ),
              ),

              InkWell(
                onTap: ()async{
                  if(key.currentState!.validate()){
                    // You can now use the secret questions data:
                    // selectedQuestion1, answer1.text, selectedQuestion2, answer2.text

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