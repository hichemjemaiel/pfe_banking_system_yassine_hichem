import 'package:flutter/material.dart';

class Qrcode extends StatefulWidget {
  const Qrcode({super.key});

  @override
  State<Qrcode> createState() => _QrcodeState();
}

class _QrcodeState extends State<Qrcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("QR code"),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.download),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 30),child: Container(
            width: 450,
            height: MediaQuery.of(context).size.height-140,
            decoration: BoxDecoration(
                color: Colors.white,
              borderRadius: BorderRadius.circular(40)
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 80),child: Image.asset("assets/qr.png",scale:2.5,),),
                Padding(padding: EdgeInsets.all(30),child: Text("Télécharger ,enregistrer ou partager \nvotre Qr code pour recevoir des\npaiements sur votre compte",style: TextStyle(
                    fontSize: 20
                ),),),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(40)
                          ),child: Icon(Icons.email,color: Colors.white,size:40,),
                        ),
                        Text("E-mail",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(40)
                          ),child: Icon(Icons.copy,color: Colors.white,size:40,),
                        ),
                        Text("Copier",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(40)
                          ),child: Icon(Icons.share,color: Colors.white,size:40,),
                        ),
                        Text("Partager",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),),
        ],
      ),
    );
  }
}
