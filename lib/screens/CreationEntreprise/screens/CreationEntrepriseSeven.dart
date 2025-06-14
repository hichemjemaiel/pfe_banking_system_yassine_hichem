import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreatioEntrepriseeight.dart';

import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntrepriseNine.dart';
import 'package:provider/provider.dart';

import '../../OTP/provider/OtpProvider.dart';

class Creationentrepriseseven extends StatefulWidget {
  String agencyIndex;
  String email;
   Creationentrepriseseven({super.key, required this.agencyIndex, required  this.email});

  @override
  State<Creationentrepriseseven> createState() => _CreationentreprisesevenState();
}

class _CreationentreprisesevenState extends State<Creationentrepriseseven> {
  bool isAccepted = false;
  String? otpCode;
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
      body: Column(
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
                    color: Color(0xFF6C6C6C),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),


            ],
          ),),
          Padding(padding: EdgeInsets.only(top: 20),child: Text("Conditions Générales",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),),
          SizedBox(height: 20,),
          Icon(Icons.health_and_safety,size: 30,),
          SizedBox(height: 20,),

          Padding(padding: EdgeInsets.only(top: 10,left: 40),child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer a bibendum tellus. Suspendisse vitae orci quis felis tempor pellentesque sed id elit. Aenean mauris dui, iaculis nec ipsum in, ullamcorper ultrices sem. Sed nec consectetur nibh. Vivamus quam diam, vehicula ut feugiat congue, consectetur eu ante. Etiam vitae mattis est, sit amet scelerisque felis. In ullamcorper sapien nunc, et maximus lorem fringilla non.",style: TextStyle(
              fontSize: 18
          ),),),
          SizedBox(height: 40,),
          InkWell(
            onTap: (){
              setState(() {
                isAccepted = !isAccepted;
              });
            },
            child: Container(
              width: 330,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isAccepted ? Color(0xFF4A9E1F) : Colors.white
              ),
              child: Center(
                child: Text("J'accepte les conditions\ngénérales de vente et d'utilisation",style: TextStyle(
                    fontSize: 20
                ),),
              ),
            ),
          ),
          SizedBox(height: 50,),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 90),child: InkWell(
                onTap: ()async{
                  if(isAccepted){
                    await Provider.of<OtpProvider>(context,listen: false).generateOtp("+21698698739");
                    otpCode = await Provider.of<OtpProvider>(context,listen: false).otpCode;
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CreationEntrepriseeight(agencyIndex : widget.agencyIndex,email:widget.email,otpCode : otpCode)));
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
      ),
    );
  }
}
