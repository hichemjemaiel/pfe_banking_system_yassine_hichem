import 'package:flutter/material.dart';

class Gbudget extends StatefulWidget {
  const Gbudget({super.key});

  @override
  State<Gbudget> createState() => _GbudgetState();
}

class _GbudgetState extends State<Gbudget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Gérer mes budgets"),
        centerTitle: true,
      ),
      body: Padding(padding: EdgeInsets.only(top: 30),child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(padding: EdgeInsets.only(top: 20),child: Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 50,top: 20),child: Image.asset("assets/shop.png",color: Colors.blue,scale: 1.5,),),
                Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Shopping"),),
                Padding(padding: EdgeInsets.only(left: 100),child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Text("0 XAF"),),
                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                      width: 150,
                      height: 5,
                      child:  ClipRRect(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: 0.5,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),),
                  ],
                ),),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 50,top: 20),child: Image.asset("assets/car.png",color: Colors.purpleAccent,scale: 1.5,),),
                Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Transport"),),
                Padding(padding: EdgeInsets.only(left: 100),child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Text("0 XAF"),),
                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                      width: 150,
                      height: 5,
                      child:  ClipRRect(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: 0.5,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),),
                  ],
                ),),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 50,top: 20),child: Image.asset("assets/house.png",color: Colors.orange,scale: 1.5,),),
                Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Epargne  "),),
                Padding(padding: EdgeInsets.only(left: 100),child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Text("0 XAF"),),
                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                      width: 150,
                      height: 5,
                      child:  ClipRRect(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: 0.5,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),),
                  ],
                ),),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 50,top: 20),child: Image.asset("assets/plus.png",color: Colors.red,scale: 1.5,),),
                Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Soins        "),),
                Padding(padding: EdgeInsets.only(left: 100),child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Text("0 XAF"),),
                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                      width: 150,
                      height: 5,
                      child:  ClipRRect(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: 0.5,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),),
                  ],
                ),),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 50,top: 20),child: Image.asset("assets/group.png",color: Colors.brown,scale: 1.5,),),
                Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Famille     "),),
                Padding(padding: EdgeInsets.only(left: 100),child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Text("0 XAF"),),
                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                      width: 150,
                      height: 5,
                      child:  ClipRRect(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: 0.5,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),),
                  ],
                ),),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 50,top: 20),child: Image.asset("assets/expense.png",color: Colors.green,scale: 1.5,),),
                Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Text("Espèces    "),),
                Padding(padding: EdgeInsets.only(left: 100),child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 100),child: Text("0 XAF"),),
                    Padding(padding: EdgeInsets.only(top: 10),child: Container(
                      width: 150,
                      height: 5,
                      child:  ClipRRect(
                        child: LinearProgressIndicator(
                          minHeight: 6,
                          value: 0.5,
                          backgroundColor: Colors.grey.shade300,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                      ),
                    ),),
                  ],
                ),),
              ],
            ),
            SizedBox(height: 80,),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                  color: Color(0xFF4A9E1F),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Center(
                child: Text("Confirmer",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),),
              ),
            )
          ],
        ),),
      ),),
    );
  }
}
