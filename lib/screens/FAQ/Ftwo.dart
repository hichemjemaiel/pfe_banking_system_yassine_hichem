import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/FAQ/Four.dart';
import 'package:pfe_banking_system/screens/FAQ/Fthree.dart';

class Ftwo extends StatefulWidget {
  const Ftwo({super.key});

  @override
  State<Ftwo> createState() => _FtwoState();
}

class _FtwoState extends State<Ftwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Conversations"),
        centerTitle: true,
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),child: InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Fthree()));
          },child: Icon(Icons.edit),),),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 40,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Four()));
            },
            child: Padding(padding: EdgeInsets.only(top: 20,left: 10),child:Container(
              width: 420,
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(40)
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Column(
                    children: [
                      Text("Bonjour Mr Yao comment ....",style: TextStyle(fontSize: 20),),
                      Padding(padding: EdgeInsets.only(right: 80),child: Text("Priscillia il y a 2 min",style: TextStyle(fontSize: 18),),),
                    ],
                  ),),
                  SizedBox(width: 30,),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),),
          ),
          Padding(padding: EdgeInsets.only(top: 20,left: 10),child:Container(
            width: 420,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Column(
                  children: [
                    Text("Bonjour Mr Yao comment ....",style: TextStyle(fontSize: 20),),
                    Padding(padding: EdgeInsets.only(right: 80),child: Text("Priscillia il y a 2 min",style: TextStyle(fontSize: 18),),),
                  ],
                ),),
                SizedBox(width: 30,),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),),
          Padding(padding: EdgeInsets.only(top: 20,left: 10),child:Container(
            width: 420,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Column(
                  children: [
                    Text("Bonjour Mr Yao comment ....",style: TextStyle(fontSize: 20),),
                    Padding(padding: EdgeInsets.only(right: 80),child: Text("Priscillia il y a 2 min",style: TextStyle(fontSize: 18),),),
                  ],
                ),),
                SizedBox(width: 30,),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),),
          Padding(padding: EdgeInsets.only(top: 20,left: 10),child:Container(
            width: 420,
            height: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                SizedBox(width: 15,),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(40)
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10,left: 20),child: Column(
                  children: [
                    Text("Bonjour Mr Yao comment ....",style: TextStyle(fontSize: 20),),
                    Padding(padding: EdgeInsets.only(right: 80),child: Text("Priscillia il y a 2 min",style: TextStyle(fontSize: 18),),),
                  ],
                ),),
                SizedBox(width: 30,),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
