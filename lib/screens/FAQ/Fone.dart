import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/FAQ/Five.dart';
import 'package:pfe_banking_system/screens/FAQ/Fthree.dart';
import 'package:pfe_banking_system/screens/FAQ/Ftwo.dart';

class Fone extends StatefulWidget {
  const Fone({super.key});

  @override
  State<Fone> createState() => _FoneState();
}

class _FoneState extends State<Fone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4A9E1F),
      appBar: AppBar(
        backgroundColor: Color(0xFF4A9E1F),

        actions: [
          Padding(padding: EdgeInsets.only(right: 250),child: Row(
            children: [
              Container(
                width: 60,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)
                ),
              ),
              Container(
                width: 60,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)
                ),
              ),Container(
                width: 60,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)
                ),
              ),
            ],
          ),),

        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(right: 200,top: 30),child: Text("Bonjour",style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),),
         Padding(padding: EdgeInsets.only(top: 10,left: 20),child:  Text("Comment pouvons-nous\nvous aider",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.white),),),
          SizedBox(height: 20,),
         Padding(padding: EdgeInsets.only(left: 23,top: 10),child:  Container(
           width: 400,
           height: 200,
           decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10)
           ),
           child: Column(
             children: [
               InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Ftwo()));
                 },
                 child: Container(
                   width: 400,
                   height: 100,
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: [
                       Text("Conversation",style: TextStyle(fontSize: 20),),
                       Icon(Icons.message,color: Colors.red,),
                     ],
                   ),
                 ),
               ),

               Container(
                 width: 400,
                 height: 100,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Text("Aide",style: TextStyle(fontSize: 20),),
                     Icon(Icons.question_mark_rounded,color: Colors.green,),
                   ],
                 ),
               ),
             ],
           ),
         ),),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Fthree()));
            },
            child: Padding(padding: EdgeInsets.only(left: 20),child: Container(
              width: 400,
              height: 90,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Envoyez-nous un message",style: TextStyle(fontSize: 20),),
                  Icon(Icons.send)
                ],
              ),
            ),),
          ),
          Padding(padding: EdgeInsets.only(top: 20,left: 20),child: Container(
            width: 400,
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
               InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Five()));
                 }
                 ,child:  Padding(padding: EdgeInsets.only(top: 20),child: Container(
                   width: 350,
                   height: 70,
                   decoration: BoxDecoration(
                       color: Colors.grey[200],
                       borderRadius: BorderRadius.circular(10)
                   ),
                   child: Row(

                     children: [
                       SizedBox(width: 10,),
                       Icon(Icons.search,size: 30,),
                       SizedBox(width: 20,),
                       Text("Trouver une réponse",style: TextStyle(fontSize: 20),)
                     ],
                   ),
                 ),),
               ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Comment ouvrir son compte ? ",style: TextStyle(
                      fontSize: 20
                    ),),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Comment effectuer un virement ? ",style: TextStyle(
                        fontSize: 20
                    ),),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Comment effectuer une mise a\ndisposition ? ",style: TextStyle(
                        fontSize: 20
                    ),),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
