import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/DepositAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/PersonProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/SavingAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticuliernine.dart';
import 'package:pfe_banking_system/screens/OTP/provider/OtpProvider.dart';
import 'package:provider/provider.dart';
import '../provider/LesDeuxAccountProvider.dart';

class Creationparticuliereight extends StatefulWidget {
  String agencyIndex;
  String email;
  String? otpCode;

  Creationparticuliereight({
    super.key,
    required this.agencyIndex,
    required this.email,
    required this.otpCode
  });

  @override
  State<Creationparticuliereight> createState() => _CreationparticuliereightState();
}

class _CreationparticuliereightState extends State<Creationparticuliereight> {
  String? bankingAccountId;
  String? personId;
  String? accountTypeId;

  // Timer variables
  Timer? _timer;
  int _seconds = 60; // 1 minute
  bool _isTimerActive = true;

  // OTP Controllers
  TextEditingController o1 = TextEditingController();
  TextEditingController o2 = TextEditingController();
  TextEditingController o3 = TextEditingController();
  TextEditingController o4 = TextEditingController();
  TextEditingController o5 = TextEditingController();
  TextEditingController o6 = TextEditingController();

  // Focus nodes for OTP fields
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  @override
  void initState() {
    super.initState();
    _startTimer();

    // Set up listeners for auto-focus
    _setupOtpListeners();
  }

  void _setupOtpListeners() {
    o1.addListener(() => _onOtpChanged(o1, f2));
    o2.addListener(() => _onOtpChanged(o2, f3));
    o3.addListener(() => _onOtpChanged(o3, f4));
    o4.addListener(() => _onOtpChanged(o4, f5));
    o5.addListener(() => _onOtpChanged(o5, f6));
    o6.addListener(() => _onOtpChanged(o6, null));
  }

  void _onOtpChanged(TextEditingController controller, FocusNode? nextFocus) {
    if (controller.text.length == 1) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      } else {
        FocusScope.of(context).unfocus();
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 60;
      _isTimerActive = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          _isTimerActive = false;
        });
        timer.cancel();
      }
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _resendOtp() async {
    // Clear existing OTP fields
    o1.clear();
    o2.clear();
    o3.clear();
    o4.clear();
    o5.clear();
    o6.clear();

    // Focus on first field
    FocusScope.of(context).requestFocus(f1);

    // Restart timer
    _startTimer();

    // Generate new OTP
    await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21698698739");
    String? newOtpCode = await Provider.of<OtpProvider>(context, listen: false).otpCode;

    setState(() {
      widget.otpCode = newOtpCode;
    });

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nouveau code OTP envoyé!'),
        backgroundColor: Color(0xFF4A9E1F),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    // Dispose controllers and focus nodes
    o1.dispose();
    o2.dispose();
    o3.dispose();
    o4.dispose();
    o5.dispose();
    o6.dispose();
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();
    super.dispose();
  }

  Widget _buildOtpField(TextEditingController controller, FocusNode focusNode) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Colors.white,
          filled: true,
          counterText: '', // Hide character counter
        ),
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            // Move to next field automatically handled by listener
          } else if (value.isEmpty) {
            // Move to previous field on backspace
            _moveToPreviousField(focusNode);
          }
        },
      ),
    );
  }

  void _moveToPreviousField(FocusNode currentFocus) {
    if (currentFocus == f2) FocusScope.of(context).requestFocus(f1);
    else if (currentFocus == f3) FocusScope.of(context).requestFocus(f2);
    else if (currentFocus == f4) FocusScope.of(context).requestFocus(f3);
    else if (currentFocus == f5) FocusScope.of(context).requestFocus(f4);
    else if (currentFocus == f6) FocusScope.of(context).requestFocus(f5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 350),
            child: Image.asset("assets/bambo.png"),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress indicator
          Padding(
            padding: EdgeInsets.only(top: 30, left: 60),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(20)),
                ),
                Container(
                  width: 20,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Color(0xFF707070),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "Validation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),

          SizedBox(height: 20),

          // Timer display
          Text(
            _formatTime(_seconds),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: _isTimerActive ? Color(0xFF4A9E04) : Colors.red,
            ),
          ),

          SizedBox(height: 20),

          Text(
            _isTimerActive
                ? "Votre code expirera dans quelques secondes\n                   Entrez vite le code"
                : "Un nouveau code a été généré automatiquement\n                    Entrez le nouveau code",
            style: TextStyle(
              fontSize: 18,
              color: _isTimerActive ? Colors.black : Color(0xFF4A9E1F),
            ),
          ),

          SizedBox(height: 40),

          Text(
            "Entrez votre code de vérification",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 50),

          // OTP input fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOtpField(o1, f1),
              _buildOtpField(o2, f2),
              _buildOtpField(o3, f3),
              _buildOtpField(o4, f4),
              _buildOtpField(o5, f5),
              _buildOtpField(o6, f6),
            ],
          ),

          SizedBox(height: 40),

          Text(
            "    Un message avec un code de vérification a été\n  envoyé au ... ... ...61. Entrez le code pour continuer",
            style: TextStyle(fontSize: 18),
          ),

          SizedBox(height: 40),

          // Resend OTP button
          InkWell(
            onTap: _isTimerActive ? null : _resendOtp,
            child: Text(
              _isTimerActive
                  ? "Le code sera regénéré automatiquement\n            quand le timer expire"
                  : "Vous n'avez pas reçu de code\n            de vérification?",
              style: TextStyle(
                fontSize: 18,
                color: _isTimerActive ? Colors.grey : Color(0xFF2A5EA1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 30),

          // Submit button
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 100),
                child: InkWell(
                  onTap: () async {
                    final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

                    if (code.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Veuillez entrer le code complet'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!_isTimerActive) {
                      // Clear OTP fields when timer expires to force user to enter new code
                      o1.clear();
                      o2.clear();
                      o3.clear();
                      o4.clear();
                      o5.clear();
                      o6.clear();
                      FocusScope.of(context).requestFocus(f1);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Veuillez entrer le nouveau code généré automatiquement.'),
                          backgroundColor: Color(0xFF4A9E1F),
                        ),
                      );
                      return;
                    }

                    if (code == widget.otpCode?.substring(widget.otpCode!.length - 6)) {
                      // Show loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                      try {
                        await Provider.of<PersonProvider>(context, listen: false).savePerson();
                        final person = await Provider.of<PersonProvider>(context, listen: false).savedPerson;
                        if (person != null) {
                          setState(() {
                            personId = person.id.toString();
                          });
                          print("Person Id: ${personId}");
                          print("Person email: ${person.email}");
                          print("Person address: ${person.address}");
                        }

                        await Future.wait([
                          Provider.of<DepositAccountProvider>(context, listen: false).saveAccount(),
                          Provider.of<SavingAccountProvider>(context, listen: false).saveAccount(),
                          Provider.of<LesDeuxAccountProvider>(context, listen: false).saveAccount(),
                        ]);

                        final DAccount = Provider.of<DepositAccountProvider>(context, listen: false).Daccount;
                        if (DAccount != null) {
                          setState(() {
                            accountTypeId = DAccount.id.toString();
                          });
                          print("Deposit Account Id: ${accountTypeId}");
                          print("Deposit Account Type: ${DAccount.pack}");
                        }

                        final SAccount = Provider.of<SavingAccountProvider>(context, listen: false).Saccount;
                        if (SAccount != null) {
                          setState(() {
                            accountTypeId = SAccount.id.toString();
                          });
                          print("Saving Account Id: ${accountTypeId}");
                          print("Saving Account Type: ${SAccount.pack}");
                        }

                        final LAccount = Provider.of<LesDeuxAccountProvider>(context, listen: false).Laccount;
                        if (LAccount != null) {
                          setState(() {
                            accountTypeId = LAccount.id.toString();
                          });
                          print("Les Deux Account Id: ${accountTypeId}");
                          print("Les Deux Account Type: ${LAccount.pack}");
                        }

                        await Provider.of<BankingProvider>(context, listen: false).addBankingAccount();
                        final BAccount = Provider.of<BankingProvider>(context, listen: false).BAccount;
                        if (BAccount != null) {
                          setState(() {
                            bankingAccountId = BAccount.id.toString();
                          });
                          print("Banking Account id: ${bankingAccountId}");
                          print("Banking Account RIB: ${BAccount.RIB}");
                        }

                        await Future.wait([
                          Provider.of<BankingProvider>(context, listen: false).addBankingAccountToClient(bankingAccountId!, personId),
                          Provider.of<BankingProvider>(context, listen: false).addBankingAccountToAccountType(bankingAccountId!, accountTypeId!),
                        ]);

                        Provider.of<BankingProvider>(context, listen: false).addBankingAccouuntToAgency(bankingAccountId!, widget.agencyIndex);

                        // Close loading dialog
                        Navigator.of(context).pop();

                        // Navigate to next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Creationparticuliernine(email: widget.email),
                          ),
                        );
                      } catch (e) {
                        // Close loading dialog
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erreur lors de la création du compte'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Code OTP incorrect'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 50),
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Suivant",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}