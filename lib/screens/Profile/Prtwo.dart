import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/ClientDtoProvider.dart';
import 'package:pfe_banking_system/screens/Profile/Prone.dart';
import 'package:provider/provider.dart';

class Prtwo extends StatefulWidget {
  String email;
   Prtwo({super.key, required  this.email});

  @override
  State<Prtwo> createState() => _PrtwoState();
}

class _PrtwoState extends State<Prtwo> {
  @override
  void initState() {
    Provider.of<ClientDTOProvider>(context,listen: false).getClientByEmail(widget.email);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ClientModelDTO? client = Provider.of<ClientDTOProvider>(context).client;
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Information Personnelles"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                          child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("${client!.firstName}",style: TextStyle(fontSize: 20),),),

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
                        child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("${client!.lastName}",style: TextStyle(fontSize: 20),),),
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
                        child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("${client!.phoneNumber}",style: TextStyle(fontSize: 20),),),
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
                        child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("${client!.email}",style: TextStyle(fontSize: 20),),),
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
                        child: Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Text("${client!.address}",style: TextStyle(fontSize: 20),),),
                      ),
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Prone(email: widget.email,)));
                        },
                        child: Container(
                          width: 300,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text("Modifier",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),
                          ),
                        ),
                      ),
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
        ),
      ),
    );
  }
}
