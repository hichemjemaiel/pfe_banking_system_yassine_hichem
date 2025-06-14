import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/model/RendezDTO.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/provider/RendezDtoProvider.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/screens/Rnthree.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/screens/Rntwo.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
import '../../CreationParticulier/model/ClientModelDTO.dart';
import '../../CreationParticulier/provider/ClientDtoProvider.dart';

class Rnone extends StatefulWidget {
  int? id ;
  String email;
   Rnone({super.key,  this.id, required this.email});

  @override
  State<Rnone> createState() => _RnoneState();
}

class _RnoneState extends State<Rnone> {
  int ind = 0;
  int myIndex = 0;
  @override
  void initState() {
    Provider.of<RendezDtoProvider>(context,listen: false).getAllRendezVous(widget.id!);
    Provider.of<ClientDTOProvider>(context,listen: false).getClientByEmail(widget.email);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<RendezDTO> rendezVous = Provider.of<RendezDtoProvider>(context).rendezVous;
    ClientModelDTO? client = Provider.of<ClientDTOProvider>(context).client;
    return Scaffold(
        bottomNavigationBar: Bar(
            myIndex: myIndex,
            onTap: (index){
              setState(() {
                myIndex = index;
              });
            }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar:  AppBar(
      backgroundColor: Color(0xFFF2F2F2),
        title: Text("Rendez-vous"),
        centerTitle: true,
        actions: [
          Padding(padding: EdgeInsets.only(right: 20),child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Rnthree(id : widget.id,email : widget.email)));
            },
            child: Icon(Icons.add_circle_outline_rounded,size: 30,color: Colors.green,),
          ),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100,),
            Stack(
              clipBehavior: Clip.none,
              children: [


                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height-50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),

                  ),
                  child: ind == 1 ? Enattente(context) :Column(
                    children: [
                      SizedBox(height: 100,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (){
                                setState(() {
                                  ind = 0;
                                });
                              }
                              ,child: Container(
                                width: 200,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: ind == 0 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text("Fixés",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: (){setState(() {
                                ind = 1;
                              });},
                              child: Container(
                                width: 200,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: ind == 1 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Text("En attente",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                            itemCount: rendezVous.length,
                            itemBuilder: (BuildContext context , int index){
                              return rendezVous[index].status !="En attente" ?Row(
                                children: [
                                  Padding(padding: EdgeInsets.only(top: 20,left: 20),
                                    child: Container(
                                      width: 120,
                                      height: 140,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: Offset(4, 4),
                                            ),
                                          ]
                                      ),

                                      child: Column(
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 90,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 10,),
                                                Text("${getMonthName(int.parse(rendezVous[index].date.split("-")[1]))}",style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green
                                                ),),
                                                Text("${rendezVous[index].date.split("-")[0]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF4A9E1F),
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Text("${rendezVous[index].time}",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),),
                                  Padding(padding: EdgeInsets.only(left: 10,bottom: 40),child:  Column(
                                    children: [
                                      Text("Rendez-vous en agence ${rendezVous[index].agencyId}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                      Padding(padding: EdgeInsets.only(right: 120,top: 5),child:  Row(
                                        children: [
                                          Icon(Icons.location_on,color: Colors.red,size: 30,),
                                          Text("Agence ${rendezVous[index].agencyId}",style: TextStyle(fontSize: 18,color: Colors.grey[500]),),
                                        ],
                                      ),),
                                    ],
                                  ),),
                                ],
                              ):Text("");
                            }),
                      )

                    ],
                  ),
                ),
                Positioned(
                    top: -70,
                    left: 155,
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(80),


                      ),
                      child: Center(
                        child: Text("${client?.firstName[0].toUpperCase()}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      ),
                    )),
              ],
            )
          ],
        ),
      )
    );
  }
  Widget Enattente(BuildContext context){
    List<RendezDTO> rendezVous = Provider.of<RendezDtoProvider>(context).rendezVous;

    return Column(
      children: [
        SizedBox(height: 100,),
        Container(
          width: 400,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    ind = 0;
                  });
                }
                ,child: Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                  color: ind == 0 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text("Fixés",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              ),

              InkWell(
                onTap: (){setState(() {
                  ind = 1;
                });},
                child: Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    color: ind == 1 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("En attente",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 50,),
        SizedBox(
          height: 500,
          child: ListView.builder(
              itemCount: rendezVous.length,
              itemBuilder: (BuildContext context , int index){
                return rendezVous[index].status =="En attente" ?Row(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 20,left: 20),
                      child: Container(
                        width: 120,
                        height: 140,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(4, 4),
                              ),
                            ]
                        ),

                        child: Column(
                          children: [
                            Container(
                              width: 120,
                              height: 90,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 10,),
                                  Text("${getMonthName(int.parse(rendezVous[index].date.split("-")[1]))}",style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green
                                  ),),
                                  Text("${rendezVous[index].date.split("-")[0]}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                                ],
                              ),
                            ),
                            Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Color(0xFF4A9E1F),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("${rendezVous[index].time}",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            )
                          ],
                        ),
                      ),),
                    Padding(padding: EdgeInsets.only(left: 10,bottom: 40),child:  Column(
                      children: [
                        Text("Rendez-vous en agence ${rendezVous[index].agencyId}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Padding(padding: EdgeInsets.only(right: 120,top: 5),child:  Row(
                          children: [
                            Icon(Icons.location_on,color: Colors.red,size: 30,),
                            Text("Agence ${rendezVous[index].agencyId}",style: TextStyle(fontSize: 18,color: Colors.grey[500]),),
                          ],
                        ),),
                      ],
                    ),),
                  ],
                ):Text("");
              }),
        )

      ],
    );
  }
  String getMonthName(int monthNumber) {
    if (monthNumber < 1 || monthNumber > 12) {
      return "Invalid month number";
    }

    switch (monthNumber) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Invalid month number"; // This is redundant due to the initial check but included for completeness
    }
  }
}
