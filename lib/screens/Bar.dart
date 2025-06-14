// Define the Bar widget outside of _MainScreenState
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/chat/UserSelectionScreen.dart';
import 'package:pfe_banking_system/screens/MainScreen.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/screens/McOne.dart';
import 'package:pfe_banking_system/screens/Virement/screens/ChoixVirement.dart';
import 'package:pfe_banking_system/screens/historique/screens/Hone.dart';

class Bar extends StatelessWidget {
  final int myIndex;
  final Function(int) onTap;
  int? id;
  String? email ;
   Bar({Key? key, required this.myIndex, required this.onTap, this.id,  this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      currentIndex: myIndex,
      items: [
        BottomNavigationBarItem(
          label: "Accueil",
          icon: InkWell(
            onTap: (){
              if (email != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(email: email!)));
              }
            },
            child: Image.asset(
              "assets/acceuil.png",
              scale: 2,
              color: myIndex == 0 ? Color(0xFF4A9E1F) : Colors.black,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: "Historique",
          icon: InkWell(
            onTap: (){
              if(id != null ){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>Hone(id: id!,) ));
              }

            },
            child: Image.asset(
              "assets/historique.png",
              scale: 2,
              color: myIndex == 1 ? Color(0xFF4A9E1F) : Colors.black,
            ),
          )
        ),
        BottomNavigationBarItem(

          label: "Cartes",
          icon: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Mcone(id: 1,)));
            },
            child: Icon(Icons.credit_card),
          )
        ),
        BottomNavigationBarItem(
          label: "Messagerie",
          icon: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserSelectionScreen()));
            },
            child: Icon(Icons.message),
          )
        ),
        BottomNavigationBarItem(
          label: "virements",
          icon: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Choixvirement(id: id!,) ));
            },
            child: Image.asset(
              "assets/mny.png",
              scale: 2,
              color: myIndex == 4 ? Color(0xFF4A9E1F) : Colors.black,
            ),
          )
        ),
      ],
    );
  }
}