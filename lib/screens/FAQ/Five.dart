import 'package:flutter/material.dart';

class Five extends StatefulWidget {
  const Five({super.key});

  @override
  State<Five> createState() => _FiveState();
}

class _FiveState extends State<Five> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Aides"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top:40,left: 20),child: Container(
            width: 400,
            height: 70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                SizedBox(width: 40,),
                Icon(Icons.search),
                SizedBox(width: 20,),
                Text("Trouver une réponse",style: TextStyle(fontSize: 20),),
              ],
            ),
          ),),
          SizedBox(height: 50,),
          Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:Row(

                children: [
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Question Fréquentes",style: TextStyle(fontSize: 20),),),
                      Padding(padding: EdgeInsets.only(right: 80),child: Text("29 articles",style: TextStyle(fontSize: 18),),),
                    ],
                  ),
                  SizedBox(width: 140,),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
          ),),
          Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:Row(

                children: [
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Question Fréquentes",style: TextStyle(fontSize: 20),),),
                      Padding(padding: EdgeInsets.only(right: 80),child: Text("29 articles",style: TextStyle(fontSize: 18),),),
                    ],
                  ),
                  SizedBox(width: 140,),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
          ),),
          Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:Row(

                children: [
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Question Fréquentes",style: TextStyle(fontSize: 20),),),
                      Padding(padding: EdgeInsets.only(right: 80),child: Text("29 articles",style: TextStyle(fontSize: 18),),),
                    ],
                  ),
                  SizedBox(width: 140,),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
          ),),
          Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Container(
              width: 400,
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
              ),
              child:Row(

                children: [
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Question Fréquentes",style: TextStyle(fontSize: 20),),),
                      Padding(padding: EdgeInsets.only(right: 80),child: Text("29 articles",style: TextStyle(fontSize: 18),),),
                    ],
                  ),
                  SizedBox(width: 140,),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
          ),),
        ],
      ),
    );
  }
}
