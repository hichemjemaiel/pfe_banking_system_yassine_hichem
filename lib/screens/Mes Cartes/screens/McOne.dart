import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/model/CardDto.dart';
import 'package:pfe_banking_system/screens/Depot/provider/CardDtoProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/CardProvider.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/model/DechargeCardDTO.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/model/RechargeCardDTO.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/provider/DechargeCardDTOProvider.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/screens/Mctwo.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rctone.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';
import '../provider/RechargeCardDTOProvider.dart';

class Mcone extends StatefulWidget {
  int? id ;
  Mcone({super.key, required this.id});

  @override
  State<Mcone> createState() => _MconeState();
}

class _MconeState extends State<Mcone> {
  bool clicked = false;
  int myIndex = 0;
  int ind = 0;
  PageController pageController = PageController();

  // Function to format card number with spaces
  String formatCardNumber(String cardNumber) {
    // Remove any existing spaces
    String cleanNumber = cardNumber.replaceAll(' ', '');

    // Add space every 4 digits
    String formatted = '';
    for (int i = 0; i < cleanNumber.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += cleanNumber[i];
    }

    return formatted;
  }

  @override
  void initState() {
    Provider.of<CardDtoProvider>(context,listen: false).getAllCardsToClient(widget.id!);
    loadRecharges(0);
    loadDecharges(0);
    super.initState();
  }
  Future<void> loadRecharges(int ind )async{
    await Provider.of<RechargeCardDTOProvider>(context,listen: false).getAllRecharges(ind+1);
  }

  Future<void> loadDecharges(int ind)async{
    await Provider.of<DechargeCardDTOProvider>(context,listen: false).getAllDecharges(ind+1);
  }
  @override
  Widget build(BuildContext context) {
    List<CardDtoModel> cards = Provider.of<CardDtoProvider>(context).cards;
    List<RechargeCardDTO> recharges = Provider.of<RechargeCardDTOProvider>(context).recharges;
    List<DechargeCardDTO> decharges  = Provider.of<DechargeCardDTOProvider>(context).decharges;
    // Add check for empty cards list
    if (cards.isEmpty) {
      return Scaffold(
        bottomNavigationBar: Bar(
            myIndex: myIndex,
            onTap: (index){
              setState(() {
                myIndex = index;
              });
            }
        ),
        backgroundColor: Color(0xFFF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          title: Text("Mes cartes"),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Mctwo(id : widget.id)));
              },
              child: Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.add_circle_outline, color: Colors.green, size: 30,),),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: Color(0xFF4A9E1F)),
              SizedBox(height: 20),
              Text("Chargement de vos cartes...", style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      );
    }

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
        title: Text("Mes cartes"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Mctwo(id : widget.id)));
            },
            child: Padding(padding: EdgeInsets.only(right: 20), child: Icon(Icons.add_circle_outline, color: Colors.green, size: 30,),),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 300,
                width: 1000,
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) async{
                      setState(() {
                        ind = index;
                      });
                      loadRecharges(ind);
                      loadDecharges(ind);
                    },
                    itemCount: cards.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context , int index){

                      return cards[index].status == "Verrouille"
                          ? Padding(
                          padding: EdgeInsets.all(20),
                          child: Stack(
                            children: [
                              // Main card container (grayed out)
                              Container(
                                width: 450,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400], // Grayed out background
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.grey.withOpacity(0.7),
                                      BlendMode.saturation,
                                    ),
                                    child: Image.asset(
                                      "assets/card.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              // Card details (grayed out)
                              Positioned(
                                top: 150,
                                left: 30,
                                child: Text(
                                  "•••• •••• •••• ••••",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300],
                                    fontSize: 20,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 80,
                                left: 30,
                                child: Container(
                                  width: 70,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 80,
                                left: 320,
                                child: Icon(
                                  Icons.wifi,
                                  size: 30,
                                  color: Colors.grey[300],
                                ),
                              ),

                              Positioned(
                                top: 180,
                                left: 30,
                                child: Text(
                                  "Expire ••/••",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 20,
                                left: 310,
                                child: Text(
                                  "Eco",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 213,
                                left: 20,
                                child: Text(
                                  "•••• ••••",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[300],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 190,
                                left: 290,
                                child: Container(
                                  width: 70,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "VISA",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Lock overlay with semi-transparent background
                              Container(
                                width: 450,
                                height: 250,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),

                              // Lock icon and text in center
                              Positioned.fill(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.9),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.lock,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: Text(
                                        "CARTE VERROUILLÉE",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Contactez votre banque",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ) :Padding(padding: EdgeInsets.all(20),child: Stack(
                        children: [Container(
                          width: 450,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "assets/card.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                          Positioned(
                              top: 150,
                              left: 30,
                              child: Text("${formatCardNumber(cards[index].number)}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
                          Positioned(
                              top: 80,
                              left: 30,
                              child: Container(
                                width: 70,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                              )),
                          Positioned(
                              top: 80,
                              left: 320,
                              child: Icon(Icons.wifi,size: 30,color: Colors.white,)),
                          Positioned(
                              top: 180,
                              left: 30,
                              child: Text("Expire ${cards[index].expirationDate}",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),
                          Positioned(
                              top: 20,
                              left: 310,
                              child: Text("Eco",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                          Positioned(
                              top: 213,
                              left: 20,
                              child: Text("${cards[index].name}",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),)),
                          Positioned(
                              top: 190,
                              left: 290,
                              child: Container(
                                width: 70,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Center(
                                  child: Text("VISA",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                ),
                              )),

                        ],
                      ));
                    }),
              ),

              Padding(padding: EdgeInsets.only(top: 40,left: 120),child: Row(
                children: [
                  !clicked?  Text("***********",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),): Text("${cards[ind].balance} XAF",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      setState(() {
                        !clicked ? clicked = true : clicked = false;
                      });
                    },
                    child: !clicked ? Icon(Icons.remove_red_eye_outlined,size: 30,) :Icon(Icons.remove_red_eye,size: 30,),
                  )
                ],
              ),),
              Container(
                width: 400,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ExpansionTile(title: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 10),child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.credit_card,color: Colors.white,),
                      ),
                    ),),
                    SizedBox(width: 5,),
                    Padding(padding: EdgeInsets.only(top: 8,left: 10),child: Column(
                      children: [
                        Text("Informations de la carte",style: TextStyle(fontSize: 20),),
                        Text("Détails de la carte Orabank",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                      ],
                    ),),

                  ],
                ),children: [
                  Text("Nom du porteur                ${cards[ind].name}",style: TextStyle(fontSize: 20),),
                  Text("-------------------------------------",style: TextStyle(fontSize: 30),),
                  Text("Numéro de la carte:  **** ${cards[ind].number.length > 4 ? cards[ind].number.substring(cards[ind].number.length - 4) : cards[ind].number}",style: TextStyle(fontSize: 20),),
                  Text("-------------------------------------",style: TextStyle(fontSize: 30),),
                  Text("Date d'expiration:              ${cards[ind].expirationDate}",style: TextStyle(fontSize: 20),),
                  Text("-------------------------------------",style: TextStyle(fontSize: 30),),

                  Text("Type de carte:           ${cards[ind].type}",style: TextStyle(fontSize: 20),),
                  SizedBox(height: 20,),
                ],),
              ),
              SizedBox(height: 20,),
              Container(
                width: 400,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ExpansionTile(title: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 5),child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.info,color: Colors.white,),
                      ),
                    ),),
                    SizedBox(width: 5,),
                    Padding(padding: EdgeInsets.only(top: 8,left: 10),child: Column(
                      children: [
                        Text("Action sur la carte     ",style: TextStyle(fontSize: 20),),
                        Text("Les actions sur ma carte",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                      ],
                    ),),


                  ],
                ),children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Rctone(id: widget.id!)));
                    },
                    child: Padding(padding: EdgeInsets.only(left: 20),child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 20,top: 20),child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF4A9E1F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(Icons.credit_card,color: Colors.white,),
                          ),
                        ),),
                        SizedBox(width: 5,),
                        Padding(padding: EdgeInsets.only(top: 8,left: 10),child: Column(
                          children: [
                            Text("Recharger ma carte        ",style: TextStyle(fontSize: 20),),
                            Text("Recharger ma carte Orbank",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                          ],
                        ),),
                        SizedBox(width: 50,),

                      ],
                    ),),
                  ),
                  InkWell(
                    onTap: (){
                      showAdaptiveDialog(context: context, builder:(BuildContext context){
                        return AlertDialog(
                          content: Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Etes vous sur de vouloir\nverouiller la carte Orabank ?",
                                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 50,left: 40),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);

                                          // Show loading snackbar
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(width: 16),
                                                  Text("Verrouillage de la carte..."),
                                                ],
                                              ),
                                              duration: Duration(seconds: 3),
                                              backgroundColor: Colors.orange,
                                            ),
                                          );

                                          try {
                                            // Call API to lock the card
                                            await Provider.of<CardProvider>(context, listen: false).setCardStatus(ind + 1);

                                            // Refresh cards data from server
                                            await Provider.of<CardDtoProvider>(context, listen: false).getAllCardsToClient(widget.id!);

                                            // Show success message
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.check_circle, color: Colors.white),
                                                    SizedBox(width: 10),
                                                    Text("Carte verrouillée avec succès"),
                                                  ],
                                                ),
                                                backgroundColor: Colors.green,
                                                duration: Duration(seconds: 2),
                                              ),
                                            );

                                          } catch (e) {
                                            // Show error message
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.error, color: Colors.white),
                                                    SizedBox(width: 10),
                                                    Text("Erreur lors du verrouillage"),
                                                  ],
                                                ),
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                            print("Error locking card: $e");
                                          }
                                        },
                                        child: Container(
                                            width: 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Text("Oui", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            width: 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Text("Non", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xFF4A9E1F),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(Icons.close,color: Colors.white,),
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Padding(
                            padding: EdgeInsets.only(top: 8,left: 10),
                            child: Column(
                              children: [
                                Text("Verrouiller la carte             ",style: TextStyle(fontSize: 20),),
                                Text("Bloquez de facon temporaire",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                              ],
                            ),
                          ),
                          SizedBox(width: 50,),
                        ],
                      ),
                    ),
                  ),
                  // Replace the existing delete confirmation dialog section with this updated version:

                  // Replace the delete section in your ExpansionTile children with this:

                  InkWell(
                    onTap: (){
                      showAdaptiveDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(
                          content: Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Text(
                                    "Etes vous sur de vouloir\nsupprimer la carte Orabank ?",
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 50, left: 40),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          Navigator.pop(context);

                                          // Show loading snackbar
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(width: 16),
                                                  Text("Suppression de la carte..."),
                                                ],
                                              ),
                                              duration: Duration(seconds: 3),
                                              backgroundColor: Colors.red,
                                            ),
                                          );

                                          try {
                                            // Get the card ID to delete
                                            int? cardId = cards[ind].id;

                                            if (cardId != null) {
                                              // Use CardProvider to delete the card
                                              bool deleteSuccess = await Provider.of<CardProvider>(context, listen: false).deleteCard(cardId);

                                              if (deleteSuccess) {
                                                // Refresh the CardDtoProvider to get updated list from server
                                                await Provider.of<CardDtoProvider>(context, listen: false).getAllCardsToClient(widget.id!);

                                                // Get the updated cards list
                                                List<CardDtoModel> updatedCards = Provider.of<CardDtoProvider>(context, listen: false).cards;

                                                // Handle page navigation after deletion
                                                if (updatedCards.isEmpty) {
                                                  // No cards left, you might want to navigate back or show empty state
                                                  setState(() {
                                                    ind = 0;
                                                  });
                                                } else if (ind >= updatedCards.length) {
                                                  // If current index is beyond the new list length, go to the last card
                                                  setState(() {
                                                    ind = updatedCards.length - 1;
                                                  });
                                                  pageController.animateToPage(
                                                    ind,
                                                    duration: Duration(milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                }

                                                // Reload recharges and decharges for the current card
                                                if (updatedCards.isNotEmpty) {
                                                  loadRecharges(ind);
                                                  loadDecharges(ind);
                                                }

                                                // Show success message
                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Row(
                                                      children: [
                                                        Icon(Icons.check_circle, color: Colors.white),
                                                        SizedBox(width: 10),
                                                        Text("Carte supprimée avec succès"),
                                                      ],
                                                    ),
                                                    backgroundColor: Colors.green,
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                );
                                              } else {
                                                // Show error message if delete failed
                                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Row(
                                                      children: [
                                                        Icon(Icons.error, color: Colors.white),
                                                        SizedBox(width: 10),
                                                        Text("Échec de la suppression de la carte"),
                                                      ],
                                                    ),
                                                    backgroundColor: Colors.red,
                                                    duration: Duration(seconds: 3),
                                                  ),
                                                );
                                              }
                                            } else {
                                              // Show error if card ID is null
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Row(
                                                    children: [
                                                      Icon(Icons.error, color: Colors.white),
                                                      SizedBox(width: 10),
                                                      Text("Erreur: ID de carte invalide"),
                                                    ],
                                                  ),
                                                  backgroundColor: Colors.red,
                                                  duration: Duration(seconds: 3),
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            // Show error message for any exceptions
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.error, color: Colors.white),
                                                    SizedBox(width: 10),
                                                    Text("Erreur lors de la suppression"),
                                                  ],
                                                ),
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 3),
                                              ),
                                            );
                                            print("Error deleting card: $e");
                                          }
                                        },
                                        child: Container(
                                            width: 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Text("Oui", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                            width: 100,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Center(
                                              child: Text("Non", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)),
                                            )
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20, top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(width: 10,), // Increased spacing
                          Expanded( // Use Expanded to prevent overflow
                            child: Padding(
                              padding: EdgeInsets.only(top: 8, left: 5), // Reduced left padding
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
                                children: [
                                  Text(
                                    "Supprimer la carte",
                                    style: TextStyle(fontSize: 20, color: Colors.red),
                                    overflow: TextOverflow.ellipsis, // Handle overflow
                                  ),
                                  Text(
                                    "Supprimer votre carte Orabank",
                                    style: TextStyle(fontSize: 16, color: Colors.grey[500]), // Reduced font size
                                    overflow: TextOverflow.ellipsis, // Handle overflow
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )

                ],),

              ),
              SizedBox(height: 20,),
              Container(
                width: 400,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ExpansionTile(title: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 1),child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(Icons.credit_card,color: Colors.white,),
                      ),
                    ),),
                    SizedBox(width: 10,),
                    Padding(padding: EdgeInsets.only(top: 8),child: Column(
                      children: [
                        Text("Historique des transactions",style: TextStyle(fontSize: 20),),
                        Text("Mes récentes transactions      ",style: TextStyle(fontSize: 18,color: Colors.grey[500]),)
                      ],
                    ),),


                  ],
                ),children: [
                  SizedBox(
                    height: 100,
                    child: recharges.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "Aucune transaction disponible",
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      itemCount: recharges.length,
                      itemBuilder: (BuildContext context, int index) {
                        // Use the loop index, not the card index
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add_circle, size: 40, color: Color(0xFF4A9E1F)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10, left: 2),
                                        child: Text(
                                          "Recharge de carte | ${recharges[index].banque} **${cards.isNotEmpty && ind < cards.length ? cards[ind].number.substring(cards[ind].number.length > 4 ? cards[ind].number.length - 4 : 0) : 'XXXX'}",
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10, top: 5, left: 2),
                                        child: Text(
                                          "${recharges[index].montant} XAF ${recharges[index].date} a ${recharges[index].time}H",
                                          style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: decharges.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info_outline, size: 50, color: Colors.grey),
                          SizedBox(height: 10),
                          Text(
                            "Aucune transaction disponible",
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      itemCount: decharges.length,
                      itemBuilder: (BuildContext context, int index) {
                        final decharge = decharges[index];
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.remove_circle, size: 40, color: Colors.red), // Changed to remove_circle for decharge
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 10, left: 2),
                                        child: Text(
                                          "Decharge de carte | ${decharge.banque ?? 'Unknown'} **${cards.isNotEmpty && ind < cards.length ? cards[ind].number.substring(cards[ind].number.length > 4 ? cards[ind].number.length - 4 : 0) : 'XXXX'}",
                                          style: TextStyle(fontSize: 16),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 10, top: 5, left: 2),
                                        child: Text(
                                          "${decharge.montant ?? 0} XAF ${decharge.date ?? 'N/A'} a ${decharge.time ?? 'N/A'}H",
                                          style: TextStyle(fontSize: 18, color: Colors.grey[400]),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )

                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}