import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/TransportProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/AddShopping.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/BudgetEpargne.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/BudgetTransport.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/addEpargne.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/addTransport.dart';
import 'package:provider/provider.dart';

import 'BudgetShopping.dart';

class Transport extends StatefulWidget {
  int? id;
  Transport({super.key,  this.id});

  @override
  State<Transport> createState() => _TransportState();
}

class _TransportState extends State<Transport> {
  @override
  void initState() {
    Provider.of<TransportProviderDTO>(context,listen: false).getAllTransports(widget.id!);
    super.initState();
  }

  // Helper method to format date and time
  String formatDateTime(String date, String time) {
    return "$date à $time";
  }

  // Helper method to format amount
  String formatAmount(int amount) {
    return "-$amount FCFA";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TransportProviderDTO>(
      builder: (context, transportProvider, child) {
        List<TransportDTO> transports = transportProvider.transports;

        return Scaffold(
          backgroundColor: Color(0xFFF2F2F2),
          appBar: AppBar(
            backgroundColor: Color(0xFFF2F2F2),
            title: Text("Statistiques"),
            centerTitle: true,
            actions: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => addTransport(id : widget.id!)));
                },
                child:  Padding(padding: EdgeInsets.only(right: 20),child: Icon(Icons.add,size: 30,),),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 50,top: 40),child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Image.asset("assets/car.png",scale: 1.5,),
                      ),
                    ),),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(right: 70,top: 60),child: Text("Transport",style: TextStyle(
                            fontSize: 18
                        ),),),
                        Padding(padding: EdgeInsets.only(right: 50),child: Text("50 000 XAF",style: TextStyle(
                            fontSize: 18
                        ),),),
                        SizedBox(height: 10,),
                        Padding(padding: EdgeInsets.only(left: 30),child:  InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetTransport()));
                          },
                          child: Text("+ Définir un budget",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 18),),
                        ),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height-300,
                  decoration: BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      // Show message when no transport data available
                      if (transports.isEmpty)
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.directions_car_outlined,
                                  size: 80,
                                  color: Colors.grey[400],
                                ),
                                SizedBox(height: 16),
                                Text(
                                  "Aucun transport enregistré",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Ajoutez votre premier transport",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      // Display the list of transports
                      else
                        Expanded(
                          child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              itemCount: transports.length,
                              itemBuilder: (BuildContext context , int index){
                                TransportDTO transport = transports[index];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: InkWell(
                                    onTap: () {
                                      // Add navigation to transport details if needed
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TransportDetails(transport: transport)));
                                    },
                                    child: Container(
                                      width: 400,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 1,
                                            blurRadius: 3,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            Icon(Icons.remove_circle,color: Colors.red,size: 40,),
                                            SizedBox(width: 15),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    transport.name, // Transport name/destination
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    formatDateTime(transport.date, transport.time), // Date and time
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  formatAmount(transport.amount), // Transport cost
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}