import 'package:flutter/material.dart';

class EditPack extends StatefulWidget {
  const EditPack({super.key});

  @override
  State<EditPack> createState() => _EditPackState();
}

class _EditPackState extends State<EditPack> {


  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(padding: EdgeInsets.only(top: 600),child: Container(
        height: 450,
        width: 500,
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50),child: Image.asset("assets/pone.png",scale: 1.5,),),
            Padding(padding: EdgeInsets.only(top: 30),child: Text("Vous etes sur le point\nde modifier votre package.\nSouhaitez-vous poursuivre ?",style: TextStyle(
                fontSize: 20
            ),),),
            Padding(padding: EdgeInsets.only(top: 50,left: 60),child:
            Row(
              children: [
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child:
                    Text("Oui",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(
                    child:
                    Text("No",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ),
                ),
              ],
            ),),
          ],
        ),
      ),),
    );
  }
}
