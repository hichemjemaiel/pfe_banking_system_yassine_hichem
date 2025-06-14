import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dten.dart';

class Dnine extends StatefulWidget {
  const Dnine({super.key});

  @override
  State<Dnine> createState() => _DnineState();
}

class _DnineState extends State<Dnine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        centerTitle: true,
        title: Text("Versement a la banque"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text("  Choisissez la banque de votre choix pour\n          afficher le RIB ou vous devez faire\n                           le versement",style: TextStyle(
              fontSize: 20
            ),),
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height-100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dten()));
                    },
                    child: Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20,),
                          Image.asset("assets/imone.png"),
                          SizedBox(width: 20,),
                          Text("BICIG",style: TextStyle(
                              fontSize: 20
                          ),),
                          SizedBox(width: 200,),
                          Icon(Icons.arrow_forward_ios,),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Image.asset("assets/imone.png"),
                        SizedBox(width: 20,),
                        Text("BICIG",style: TextStyle(
                            fontSize: 20
                        ),),
                        SizedBox(width: 200,),
                        Icon(Icons.arrow_forward_ios,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Image.asset("assets/imone.png"),
                        SizedBox(width: 20,),
                        Text("BICIG",style: TextStyle(
                            fontSize: 20
                        ),),
                        SizedBox(width: 200,),
                        Icon(Icons.arrow_forward_ios,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Image.asset("assets/imone.png"),
                        SizedBox(width: 20,),
                        Text("BICIG",style: TextStyle(
                            fontSize: 20
                        ),),
                        SizedBox(width: 200,),
                        Icon(Icons.arrow_forward_ios,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Image.asset("assets/imone.png"),
                        SizedBox(width: 20,),
                        Text("BICIG",style: TextStyle(
                            fontSize: 20
                        ),),
                        SizedBox(width: 200,),
                        Icon(Icons.arrow_forward_ios,),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
