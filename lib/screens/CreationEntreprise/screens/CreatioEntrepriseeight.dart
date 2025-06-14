import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/provider/MoralPersonProvider.dart';

import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticuliernine.dart';
import 'package:provider/provider.dart';

import '../../CreationParticulier/provider/BankingAccountProvider.dart';
import '../../CreationParticulier/provider/DepositAccountProvider.dart';
import '../../CreationParticulier/provider/LesDeuxAccountProvider.dart';
import '../../CreationParticulier/provider/SavingAccountProvider.dart';
import 'CreationEntrepriseNine.dart';

class CreationEntrepriseeight extends StatefulWidget {
  String agencyIndex;
  String email ;
  String? otpCode;
   CreationEntrepriseeight({
    super.key, required this.agencyIndex, required this.email,required this.otpCode});
  @override
  State<CreationEntrepriseeight> createState() => _CreationEntrepriseeightState();

}

class _CreationEntrepriseeightState extends State<CreationEntrepriseeight> {
  String? bankingAccountId;
  String? personId;
  String? accountTypeId;

  TextEditingController o1 = TextEditingController();
  TextEditingController o2 = TextEditingController();
  TextEditingController o3 = TextEditingController();
  TextEditingController o4 = TextEditingController();
  TextEditingController o5 = TextEditingController();
  TextEditingController o6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        actions: [
          Padding(padding: EdgeInsets.only(right: 350),child: Image.asset("assets/bambo.png"),),
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 30,left: 60),child: Row(

            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),
              Container(
                width: 20,height: 3,
                decoration: BoxDecoration(
                  color: Color(0xFF707070),

                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(20)
                ),
              ),


            ],
          ),),
          Padding(padding: EdgeInsets.only(top: 40),child: Text("Validation",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),),
          SizedBox(height: 20,),
          Text("01 : 00",style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A9E04),
          ),),
          SizedBox(height: 20,),

          Text("Votre code expirera dans quelques minute\n                   Entrez vite le code",style: TextStyle(
              fontSize: 18
          ),),
          SizedBox(height: 40,),
          Text("Entrez votre code de vérification",style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: TextField(
                  controller: o1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: TextField(
                  controller: o2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: TextField(
                  controller: o3,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: TextField(
                  controller: o4,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: TextField(
                  controller: o5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: TextField(
                  controller: o6,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.white,
                      filled: true
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40,),
          Text("    Un message avec un code de vérification a été\n  envoyé au ... ... ...61. Entrez le code pour continuer",style: TextStyle(
            fontSize: 18,
          ),),
          SizedBox(height: 40,),
          Text("Vous n'avez pas reçu de code\n            de vérification?",style: TextStyle(
              fontSize: 18,
              color: Color(0xFF2A5EA1),
              fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 30,),
          Row(
            children: [

              Padding(padding: EdgeInsets.only(left: 90),child: InkWell(
    // Fixed onTap method in CreationEntrepriseeight.dart
                    onTap: () async {
                    try {
                    // Step 1: Save the moral person first
                    await Provider.of<MoralPersonProvider>(context, listen: false).savePerson();
                    final person = Provider.of<MoralPersonProvider>(context, listen: false).Mperson;

                    if (person == null) {
                    print("Error: Person creation failed");
                    return;
                    }

                    setState(() {
                    personId = person.id.toString();
                    });
                    print("Person Id: ${personId}");
                    print("Person email: ${person.email}");
                    print("Person address: ${person.address}");

                    // Step 2: Save account types
                    await Future.wait([
                    Provider.of<DepositAccountProvider>(context, listen: false).saveAccount(),
                    Provider.of<SavingAccountProvider>(context, listen: false).saveAccount(),
                    Provider.of<LesDeuxAccountProvider>(context, listen: false).saveAccount(),
                    ]);

                    // Step 3: Get the account type ID
                    String? currentAccountTypeId;

                    final DAccount = Provider.of<DepositAccountProvider>(context, listen: false).Daccount;
                    if (DAccount != null) {
                    currentAccountTypeId = DAccount.id.toString();
                    print("Deposit Account Id: ${currentAccountTypeId}");
                    print("Deposit Account Type: ${DAccount.pack}");
                    }

                    final SAccount = Provider.of<SavingAccountProvider>(context, listen: false).Saccount;
                    if (SAccount != null) {
                    currentAccountTypeId = SAccount.id.toString();
                    print("Saving Account Id: ${currentAccountTypeId}");
                    print("Saving Account Type: ${SAccount.pack}");
                    }

                    final LAccount = Provider.of<LesDeuxAccountProvider>(context, listen: false).Laccount;
                    if (LAccount != null) {
                    currentAccountTypeId = LAccount.id.toString();
                    print("Les Deux Account Id: ${currentAccountTypeId}");
                    print("Les Deux Account Type: ${LAccount.pack}");
                    }

                    if (currentAccountTypeId == null) {
                    print("Error: No account type was created");
                    return;
                    }

                    setState(() {
                    accountTypeId = currentAccountTypeId;
                    });

                    // Step 4: Create banking account
                    await Provider.of<BankingProvider>(context, listen: false).addBankingAccount();
                    final BAccount = Provider.of<BankingProvider>(context, listen: false).BAccount;

                    if (BAccount == null) {
                    print("Error: Banking account creation failed");
                    return;
                    }

                    setState(() {
                    bankingAccountId = BAccount.id.toString();
                    });
                    print("Banking Account id: ${bankingAccountId}");
                    print("Banking Account RIB: ${BAccount.RIB}");

                    // Step 5: Link banking account to client first (most important)
                    await Provider.of<BankingProvider>(context, listen: false)
                        .addBankingAccountToClient(bankingAccountId!, personId!);

                    // Step 6: Link banking account to account type
                    await Provider.of<BankingProvider>(context, listen: false)
                        .addBankingAccountToAccountType(bankingAccountId!, accountTypeId!);

                    // Step 7: Link banking account to agency
                    await Provider.of<BankingProvider>(context, listen: false)
                        .addBankingAccouuntToAgency(bankingAccountId!, widget.agencyIndex);

                    // Step 8: Verify OTP and navigate
                    final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;
                    if (code == widget.otpCode?.substring(widget.otpCode!.length - 6)) {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => Creationentreprisenine(email: widget.email)
                    )
                    );
                    } else {
                    print("Invalid OTP code");
                    // Show error message to user
                    }

                    } catch (e) {
                    print("Error in account creation process: $e");
                    // Handle error appropriately - show user feedback
                    }
                    },
                child: Padding(padding: EdgeInsets.only(top: 30,left: 50),child: Container(height: 50,width: 150,
                  decoration: BoxDecoration(
                    color: Color(0xFF4A9E1F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text("Suivant",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                  ),
                ),),
              ),),
            ],
          ),

        ],
      ),
    );
  }
}
