import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/Reset%20password/model/MailSenderRequest.dart';
import 'package:pfe_banking_system/screens/Reset%20password/provider/MailSenderProvider.dart';
import 'package:pfe_banking_system/screens/Reset%20password/screens/Pstwo.dart';
import 'package:provider/provider.dart';

class Psone extends StatefulWidget {
  const Psone({super.key});

  @override
  State<Psone> createState() => _PsoneState();
}

class _PsoneState extends State<Psone> {
  var key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
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
        title: Text("Oublié Mot de passe"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              SizedBox(height: 40,),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height+800,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 150,),
                        Padding(padding: EdgeInsets.only(right: 200,top: 20),child:  Text("Entrez votre Email",style: TextStyle(fontSize : 20),),),
                        SizedBox(height: 20,),
                        Container(
                          width: 400,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: email,
                              validator: (value){
                                if(value == null || value.isEmpty){
                                  return "This filed must not be null";
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide.none
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "example@gmail.com"
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
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
                        SizedBox(height: 30,),
                        InkWell(
                          onTap: ()async{
                            if(key.currentState!.validate()){
                              if(selectedQuestion1 == null || selectedQuestion2 == null) {
                                _showToast("Veuillez sélectionner les deux questions de sécurité");
                                return;
                              }

                              final result = await Provider.of<MailSenderProvider>(context,listen: false).userExistence(email.text);
                              if(result){
                                MailSenderRequest request = MailSenderRequest(toEmail: email.text, subject: "OTP");
                                await Provider.of<MailSenderProvider>(context,listen: false).sendMail(request);
                                final OtpCode = await Provider.of<MailSenderProvider>(context,listen: false).otpCode;
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Pstwo(otpCode: OtpCode,email : email.text)));
                              }else{
                                _showToast("Email not found");
                              }
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
                              child: Text("Continuer",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                            ),
                          ),
                        ),

                        Padding(padding: EdgeInsets.only(top: 40,left: 70),child: Row(
                          children: [
                            Text("Retour au Menu principale? ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            Text("Retour",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Color(0xFF4A9E1F),),)
                          ],
                        ),),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -40,
                    left: 170,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(70),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(4, 4)
                            ),
                          ]
                      ),
                      child: Center(
                        child: Icon(Icons.shield,size:50,),
                      ),
                    ),),
                ],
              )
            ],
          ),),
      ),
    );
  }
}