import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Deightt.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dsevent.dart';

class Dsixt extends StatefulWidget {
  int? id;
   Dsixt({super.key,  this.id});

  @override
  State<Dsixt> createState() => _DsixtState();
}

class _DsixtState extends State<Dsixt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Depot via carte"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          SizedBox(height: 40,),
          Text("Choisissez un canal pour faire le dépot",style: TextStyle(
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
                SizedBox(height: 50,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Dsevent(id : widget.id)));
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
                        SizedBox(width: 10,),
                        Image.asset("assets/imone.png"),
                        SizedBox(width: 10,),
                        Text("UBA Gabon",style: TextStyle(fontSize: 20),),
                        SizedBox(width: 160,),
                        Icon(Icons.arrow_forward_ios,)
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
                      SizedBox(width: 10,),
                      Image.asset("assets/imone.png"),
                      SizedBox(width: 10,),
                      Text("UBA Gabon",style: TextStyle(fontSize: 20),),
                      SizedBox(width: 160,),
                      Icon(Icons.arrow_forward_ios,)
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Deightt()));
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
                        SizedBox(width: 10,),
                        Image.asset("assets/imone.png"),
                        SizedBox(width: 10,),
                        Text("Visa / MasterCard",style: TextStyle(fontSize: 20),),
                        SizedBox(width: 100,),
                        Icon(Icons.arrow_forward_ios,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),),
    );
  }
}
