import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/provider/CardProvider.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/screens/Mcthree.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';

class Mctwo extends StatefulWidget {
  int? id ;
   Mctwo({super.key, required this.id});

  @override
  State<Mctwo> createState() => _MctwoState();
}

class _MctwoState extends State<Mctwo> {
  var key =GlobalKey<FormState>();
  int ind =-1;
  String? type;
  String? cardId;
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController expirationDate = TextEditingController();

  void showCarte(BuildContext context){
    showModalBottomSheet(context: context, builder: (BuildContext){
      return Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 40,left: 20),child: Row(
              children: [
                Text("Sélectionner le type de carte ",style: TextStyle(fontSize: 20),),
                SizedBox(width: 100,),
                Icon(Icons.done,size: 30,),
              ],
            ),),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                setState(() {
                  ind = 0;
                });
                Navigator.pop(context);
              },
              child: Container(
                width: 400,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20),child: Text("Carte Uba",style: TextStyle(fontSize: 18),),),
                    SizedBox(width: 250,),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(40)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                setState(() {
                  ind =1;
                });
                Navigator.pop(context);
              },
              child: Container(
                width: 400,
                height: 70,
                decoration: BoxDecoration(
                  color: Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20),child: Text("Carte Orabank",style: TextStyle(fontSize: 18),),),
                    SizedBox(width: 210,),
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(40)
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    int myIndex = 0;
    return Scaffold(
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (index){
            setState(() {
              myIndex = index;
            });
          }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Rattacher une carte"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height+100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Type de carte",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      showCarte(context);
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
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("Cliquer pour séléctionner",style: TextStyle(fontSize: 15),),),
                          SizedBox(width: 150,),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Nom du porteur",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: name,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "This filed must not be null";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),
                            hintText: "Cliquer pour saisir"
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 200,top: 40),child: Text("Numéro de la carte",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: number,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "This field must not be null";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),
                            hintText: "Cliquer pour saisir"
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 210,top: 40),child: Text("Date d'expiration",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: expirationDate,
                        validator: (value){
                          if(value == null || value.isEmpty){
                            return "This filed must not be null";
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none
                            ),
                            hintText: "MM / AAAA"
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 300,top: 40),child: Text("CVC",style: TextStyle(fontSize: 20),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none
                          ),
                          hintText: "Cliquer pour saisir",
                          suffixIcon: Icon(Icons.remove_red_eye),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),
                  InkWell(
                    onTap: () async{
                      if(key.currentState!.validate() && ind !=-1){
                        ind ==0 ? type ="Carte Uba" : ind ==1 ? type ="Carte Orabank" : type = "";
                        Provider.of<CardProvider>(context,listen: false).setType(type: type!);
                        Provider.of<CardProvider>(context,listen: false).setName(name: name.text);
                        Provider.of<CardProvider>(context,listen: false).setNumber(number: number.text);
                        Provider.of<CardProvider>(context,listen: false).setExpirationDate(expirationDate: expirationDate.text);
                        Provider.of<CardProvider>(context,listen: false).setStatus(status: "ACTIVE");
                        await Provider.of<CardProvider>(context,listen: false).saveCard();
                        final card = await Provider.of<CardProvider>(context,listen: false).card;
                        if(card != null){
                          setState(() {
                            cardId = card.id.toString();
                          });
                        }
                        await Provider.of<CardProvider>(context,listen: false).addCardToClient(cardId!, widget.id.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Mcthree(id : widget.id!)));
                      }

                    },
                    child:  Container(
                      width: 300,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("Valider",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),),
      ),
    );
  }
}
