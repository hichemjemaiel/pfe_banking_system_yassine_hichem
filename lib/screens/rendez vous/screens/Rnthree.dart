import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/AgencyProvider.dart';
import 'package:pfe_banking_system/screens/MainScreen.dart';
import 'package:pfe_banking_system/screens/TransactionsCertif.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/model/RendezVousModel.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/provider/RendezVousProvider.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/screens/RnOne.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
class Rnthree extends StatefulWidget {
  int? id;
  String email;
   Rnthree({super.key,  this.id, required this.email});

  @override
  State<Rnthree> createState() => _RnthreeState();
}

class _RnthreeState extends State<Rnthree> {
  int ind = -1;
  int inde = -1;
  int myIndex = 0;
  DateTime? selectedDate;
  TextEditingController objet = TextEditingController();
  TextEditingController commentaire = TextEditingController();
  String? rdzId;
  var key = GlobalKey<FormState>();
  Future<void> pickDate(BuildContext context)async{
    DateTime? picked = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    setState(() {
      selectedDate = picked;
    });
  }
  @override
  void initState() {
    Provider.of<AgencyProvider>(context,listen: false).getAllAgencies();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    List<AgencyModel> agencies = Provider.of<AgencyProvider>(context).agencies;
    List<String> times = ["8:00","8:30","9:30","14:00","14,30","16:00"];

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
        title: Text("Prendre un rendez-vous"),
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
                  height: MediaQuery.of(context).size.height+350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(right: 250,top: 20),child: Text("Agence",style: TextStyle(
                          fontSize: 20
                      ),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,

                        decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: ExpansionTile(title: Text(ind == -1 ? "Cliquer pour séléctionner" : "agency : ${agencies[ind].id}"),children: [
                          SizedBox(
                            height: 300,
                            child: ListView.builder(
                                itemCount: agencies.length,
                                itemBuilder : (BuildContext context, int index){
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        ind = index;

                                      });

                                    },
                                    child: Padding(padding: EdgeInsets.only(top: 10),child: Container(
                                      width: 400,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFF2F2F2),
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Center(
                                        child: Padding(padding: EdgeInsets.only(right: 250),child: Container(
                                          width: 400,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: Color(0xFFF2F2F2),
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: Center(
                                            child: Text("agency : ${agencies[index].id}"),
                                          ),
                                        ),),
                                      ),
                                    ),),
                                  );
                                }),
                          )
                        ],),

                      ),
                      Padding(padding: EdgeInsets.only(right: 200,top: 20),child: Text("Date souhaité",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),

                        ),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(selectedDate == null ?"Cliquer pour choisir la date": "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}",style: TextStyle(fontSize:20 ),),
                                Padding(padding: EdgeInsets.only(right: 20),child: InkWell(
                                  onTap: (){
                                    pickDate(context);
                                  },
                                  child: Icon(Icons.calendar_month,color: Colors.green,),
                                ),)
                              ],
                            )
                        ),
                      ),

                      Padding(padding: EdgeInsets.only(right: 280,top: 20),child: Text("Horaire",style: TextStyle(fontSize: 20),),),
                      Padding(padding: EdgeInsets.only(right: 280,top: 20),child: Text("Matin",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                inde = 0;
                              });
                            },
                            child:  Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: inde == 0 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("08:00",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                inde = 1;
                              });
                            },
                            child:  Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: inde == 1 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("08:30",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                inde = 2;
                              });
                            },
                            child:  Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: inde == 2 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("09:30",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(right: 260,top: 20),child: Text("Apres Midi",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                inde = 3;
                              });
                            },
                            child:  Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: inde == 3 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("14:00",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                inde = 4;
                              });
                            },
                            child:  Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: inde == 4 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("14:30",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                inde = 5;
                              });
                            },
                            child:  Container(
                              width: 120,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: inde == 5 ? Color(0xFF4A9E1F) :Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Text("16:00",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(padding: EdgeInsets.only(right: 250),child: Text("Objet",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: objet,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "this field must not be null";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                hintText: "Cliquer pour saisir"
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(padding: EdgeInsets.only(right: 250),child: Text("Commentaire",style: TextStyle(fontSize: 20),),),
                      SizedBox(height: 20,),
                      Container(
                        width: 400,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: commentaire,
                            validator: (value){
                              if(value == null || value.isEmpty){
                                return "this field must not be null";
                              }
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                hintText: "Cliquez pour saisir votre commantaire"
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      // In your Rnthree.dart file, fix the validation button onTap method:

                      InkWell(
                        onTap: () async {
                          if(key.currentState!.validate() && inde != -1 && selectedDate != null && ind != -1){
                            try {
                              // Set all the values
                              Provider.of<RendezVousProvider>(context, listen: false).setDate(
                                  date: "${selectedDate?.day}-${selectedDate?.month}-${selectedDate?.year}"
                              );
                              Provider.of<RendezVousProvider>(context, listen: false).setTime(
                                  time: times[inde]
                              );
                              Provider.of<RendezVousProvider>(context, listen: false).setObject(
                                  objet: objet.text
                              );
                              Provider.of<RendezVousProvider>(context, listen: false).setCommentaire(
                                  commentaire: commentaire.text
                              );
                              Provider.of<RendezVousProvider>(context, listen: false).setStatus();

                              // Save the rendez-vous
                              await Provider.of<RendezVousProvider>(context, listen: false).saveRendezVous();

                              // Get the created rendez-vous
                              final rendezVous = Provider.of<RendezVousProvider>(context, listen: false).rendezVous;

                              if(rendezVous != null && rendezVous.id != null){
                                String rdzId = rendezVous.id.toString();

                                // FIXED: Use 'ind' instead of 'inde' for agency selection
                                await Provider.of<RendezVousProvider>(context, listen: false).addAgencyToRendezVous(
                                    rdzId,
                                    agencies[ind].id.toString() // Changed from agencies[inde] to agencies[ind]
                                );

                                await Provider.of<RendezVousProvider>(context, listen: false).addRendezVousToClient(
                                    rdzId,
                                    widget.id.toString()
                                );

                                // Navigate to next screen
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Rnone(id: widget.id,email: widget.email,))
                                );
                              } else {
                                print("Failed to create rendez-vous or get ID");
                                // Show error message to user
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Erreur lors de la création du rendez-vous"))
                                );
                              }
                            } catch (e) {
                              print("Error in validation process: $e");
                              // Show error message to user
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Une erreur s'est produite"))
                              );
                            }
                          } else {
                            // Show validation error
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Veuillez remplir tous les champs requis"))
                            );
                          }
                        },
                        child: Container(
                          width: 300,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              "Valider",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),),
      )
    );
  }
}
