import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';

class QrScan extends StatefulWidget {
  const QrScan({super.key});

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bar(myIndex: myIndex, onTap: (index){
        setState(() {
          myIndex = index;
        });
      }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Qr Code"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(left: 260,top: 20),child: Container(
            width: 160,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(Icons.document_scanner_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Scanner un Qr",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),),
          SizedBox(
            height: 100,
          ),
          Icon(Icons.person_pin,size: 80,),
          Container(
            width: double.infinity,
            height:558,
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(40)
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 50),child: Text("Partagez ce code QR pour recevoir\nde l'argent sur votre compte.",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),),
                Padding(padding: EdgeInsets.only(top: 20),child: Image.asset("assets/qr.png",scale: 2.5,),),
                Padding(padding: EdgeInsets.only(top: 50,left: 15),child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20),child: Container(
                      height: 50,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 20),child: Icon(Icons.share,color: Colors.white,),),
                            SizedBox(width: 5,),
                            Text("Partager",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),),
                    Padding(padding: EdgeInsets.only(left: 20),child: Container(
                      height: 50,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 20),child: Icon(Icons.download,color: Colors.white,),),
                            SizedBox(width: 5,),
                            Text("Sauvegarder",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ),
                    ),),
                  ],
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
