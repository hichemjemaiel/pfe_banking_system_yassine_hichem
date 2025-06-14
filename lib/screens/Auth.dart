import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/CreateAccount.dart';
import 'package:pfe_banking_system/screens/MainScreen.dart';
import 'package:pfe_banking_system/screens/Reset%20password/screens/Psone.dart';
import 'package:pfe_banking_system/screens/authentication/model/LoginRequest.dart';
import 'package:provider/provider.dart';

import 'CreationParticulier/screens/CreationParticulier.dart';
import 'authentication/model/User.dart';
import 'authentication/proivder/AuthProvider.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool clicked = false;
  var key = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController passsword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
      ),
      body: Form(
        key: key,
        child: Column(
        children: [
          Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Image.asset("assets/bam.png"),),
          Padding(padding: EdgeInsets.only(top: 120,left: 25),child: SizedBox(width: 400,height: 80,child: TextFormField(
            controller: email,
            validator: (value){
              if(value == null || value.isEmpty ){
                return "Please Enter your email";
              }if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.person),
                prefixIconColor: Colors.grey,
                suffixIcon:Icon(Icons.qr_code_scanner,color: Color(0xFF4A9E1F),),
                hintText: "Entrez votre identifiant",
                hintStyle: TextStyle(color: Colors.grey)
            ),
          ),),),

          Padding(padding: EdgeInsets.only(top: 10,left: 25),child: SizedBox(width: 400,height: 80,child: TextFormField(
            controller: passsword,
            validator: (value){
              if(value == null || value.isEmpty){
                return "Please enter your password";
              }if(value.length<6){
                return "Password must be at least 6 characters";
              }
            },
            obscureText: clicked == false ? true : false,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.vpn_key_sharp),
                prefixIconColor: Colors.grey,
                suffixIcon:InkWell(
                  onTap: (){
                    setState(() {
                      clicked == false ? clicked = true : clicked = false;
                    });
                  },
                  child: clicked == false ? Icon(Icons.remove_red_eye_outlined,color: Color(0xFF4A9E1F),) : Icon(Icons.remove_red_eye,color: Color(0xFF4A9E1F),),
                ),

                hintText: "Entrez votre mot de passe",
                hintStyle: TextStyle(color: Colors.grey)
            ),
          ),),),
          Padding(padding: EdgeInsets.only(top: 30,left: 15),child: InkWell(
            onTap: ()async{
              if(key.currentState!.validate()){
                LoginRequest request = LoginRequest(email: email.text, password: passsword.text);
                final success = await Provider.of<AuthProvider>(context,listen: false).login(request);
                if(success){
                  if (context.mounted) {

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) =>  MainScreen(email : email.text)),
                    );
                  }
                }else {
                  // Show error
                  if (context.mounted) {
                    Fluttertoast.showToast(
                      msg:  Provider.of<AuthProvider>(context,listen: false).error ?? 'Login failed',
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
            child: Container(
              width: 350,
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0xFF4A9E1F),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Connexion",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25
                ),),
              ),
            ),
          ),),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Psone()));
            },
            child: Padding(padding: EdgeInsets.only(top: 50,left: 10),child: Text("Mot de passe ou ID oublié ?",style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 20,
                color: Colors.grey
            ),),),
          ),
          Padding(padding: EdgeInsets.only(left: 85,top: 20),child: Row(
            children: [
              Text("Pas de compte?",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Createaccount()));
                },
                child: Text("Créer un compte",style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                    color: Color(0xFF4A9E1F),
                    fontWeight: FontWeight.bold
                ),),
              )
            ],
          ),),
        ],
      ),),
    );
  }
}
