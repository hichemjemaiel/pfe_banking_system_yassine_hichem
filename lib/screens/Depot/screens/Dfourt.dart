import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Dfivet.dart';

class Dfourt extends StatefulWidget {
  const Dfourt({super.key});

  @override
  State<Dfourt> createState() => _DfourtState();
}

class _DfourtState extends State<Dfourt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Versement a la banque"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text("Vous devez maintenant avoir fait le\n       virement sur SFE a la BICIG",style: TextStyle(
              fontSize: 20,
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
                  Padding(padding: EdgeInsets.only(top: 40,right: 200),child: Text("Compte a créditer",style: TextStyle(
                      fontSize: 20
                  ),),),
                  SizedBox(height: 20,),
                  Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Center(
                      child: ExpansionTile(

                          title: Text("Cliquer pour selectionner")),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [

                      SizedBox(width: 10,),
                      Icon(Icons.info,size: 30,color: Colors.green,),
                      SizedBox(width: 10,),
                      Text("Important Assurez-vous d'avoir reçu\nle bordereau de votre virement\nphysiquement ou en photo avant de passer\na l'etape suivante",style: TextStyle(
                          fontSize: 20
                      ),)
                    ],
                  ),
                  SizedBox(height: 80,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 200,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Center(
                          child: Text("Annuler",style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Dfivet()));
                        },
                        child: Container(
                          width: 200,
                          height: 70,
                          decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Continuer",style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
