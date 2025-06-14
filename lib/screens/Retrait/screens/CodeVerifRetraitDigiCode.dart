import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:provider/provider.dart';

import '../../TransactionsCertif.dart';
import '../../OTP/provider/OtpProvider.dart';
import '../provider/WithdrawlOpProvider.dart';
import 'TransactionVerifDigi.dart';

class Codeverifretraitdigicode extends StatefulWidget {
  String? otpCode;
  String BankId;
  String montant;
  String namecreditnum;
  String? motif;
  String? compteDebiteur;
  String? frais;

  Codeverifretraitdigicode({
    super.key,
    required this.otpCode,
    required this.montant,
    required this.BankId,
    required this.namecreditnum,
    this.motif,
    this.compteDebiteur,
    this.frais,
  });

  @override
  State<Codeverifretraitdigicode> createState() => _CodeverifretraitdigicodeState();
}

class _CodeverifretraitdigicodeState extends State<Codeverifretraitdigicode> {
  String? BankOpId;
  late Timer _timer;
  int _timerSeconds = 60; // 1 minute countdown
  bool _isTimerActive = true;
  bool _isResendEnabled = false;

  // OTP Controllers
  TextEditingController o1 = TextEditingController();
  TextEditingController o2 = TextEditingController();
  TextEditingController o3 = TextEditingController();
  TextEditingController o4 = TextEditingController();
  TextEditingController o5 = TextEditingController();
  TextEditingController o6 = TextEditingController();

  // Focus nodes for automatic navigation
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _isTimerActive = true;
    _isResendEnabled = false;
    _timerSeconds = 60;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _isTimerActive = false;
          _isResendEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  void resendOTP() async {
    // Clear all OTP fields
    clearOTPFields();

    // Generate new OTP
    await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21646491524");
    String? newOtpCode = await Provider.of<OtpProvider>(context, listen: false).otpCode;

    setState(() {
      widget.otpCode = newOtpCode;
    });

    // Restart timer
    startTimer();

    // Show confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Nouveau code OTP envoyé!"),
        backgroundColor: Color(0xFF4A9E1F),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void clearOTPFields() {
    o1.clear();
    o2.clear();
    o3.clear();
    o4.clear();
    o5.clear();
    o6.clear();
    f1.requestFocus();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget buildOTPField(TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF4A9E1F), width: 3),
          ),
          counterText: "",
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            // Move to next field
            if (nextFocus != null) {
              nextFocus.requestFocus();
            } else {
              // Last field, remove focus
              currentFocus.unfocus();
            }
          }
        },
        onTap: () {
          // Clear the field when tapped for better UX
          controller.clear();
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();

    // Dispose controllers
    o1.dispose();
    o2.dispose();
    o3.dispose();
    o4.dispose();
    o5.dispose();
    o6.dispose();

    // Dispose focus nodes
    f1.dispose();
    f2.dispose();
    f3.dispose();
    f4.dispose();
    f5.dispose();
    f6.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Code de vérification (OTP)"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height +100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Image.asset("assets/otp.jpg", scale: 5),
                  SizedBox(height: 20),
                  Text(
                    "Entrez votre code de vérification\n    (OTP) pour confirmer votre\n                    transaction",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 30),

                  // Timer Display
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _isTimerActive ? Color(0xFF4A9E1F) : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _isTimerActive
                          ? "Code expire dans: ${formatTime(_timerSeconds)}"
                          : "Code expiré",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // OTP Input Fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildOTPField(o1, f1, f2),
                      buildOTPField(o2, f2, f3),
                      buildOTPField(o3, f3, f4),
                      buildOTPField(o4, f4, f5),
                      buildOTPField(o5, f5, f6),
                      buildOTPField(o6, f6, null),
                    ],
                  ),

                  SizedBox(height: 50),

                  // Validate Button
                  InkWell(
                    onTap: _isTimerActive ? () async {
                      final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

                      if (code.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Veuillez entrer le code complet à 6 chiffres"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (code == widget.otpCode?.substring(widget.otpCode!.length - 6)) {
                        // Show loading indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A9E1F)),
                              ),
                            );
                          },
                        );

                        try {
                          Provider.of<WithdrawlOpProvider>(context, listen: false).setMontant(montant: int.parse(widget.montant));
                          Provider.of<WithdrawlOpProvider>(context, listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                          Provider.of<WithdrawlOpProvider>(context, listen: false).setStatus();
                          Provider.of<WithdrawlOpProvider>(context, listen: false).setNameCreditNum(namecreditnum: widget.namecreditnum);
                          Provider.of<WithdrawlOpProvider>(context, listen: false).setCreditNum(creditnum: "");

                          await Provider.of<WithdrawlOpProvider>(context, listen: false).saveWithdrawlOp();
                          final WithdrawlOp = await Provider.of<WithdrawlOpProvider>(context, listen: false).withdrawlOp;

                          if (WithdrawlOp != null) {
                            setState(() {
                              BankOpId = WithdrawlOp.id.toString();
                            });
                          }

                          await Provider.of<WithdrawlOpProvider>(context, listen: false).addWithdarwlOpToBankingAccount(BankOpId!, widget.BankId);

                          // Close loading dialog
                          Navigator.pop(context);

                          // Navigate to success screen with transaction data
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TransactionscertifDi(
                                    montant: widget.montant,
                                    beneficiaire: widget.namecreditnum,
                                    compteDebiteur: widget.compteDebiteur,
                                    motif: widget.motif,
                                    dateTransaction: DateTime.now(),
                                    reference: BankOpId,
                                    frais: widget.frais,
                                    typeOperation: "Retrait",
                                  )
                              )
                          );

                        } catch (error) {
                          // Close loading dialog
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Erreur lors du traitement de la transaction"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        // Invalid OTP
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Code OTP incorrect. Veuillez réessayer."),
                            backgroundColor: Colors.red,
                          ),
                        );

                        // Clear fields and focus on first field
                        clearOTPFields();
                      }
                    } : null,
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                          color: _isTimerActive ? Color(0xFF4A9E1F) : Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Text(
                          "Valider",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 40),

                  // Resend OTP Section
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 60),
                    child: Row(
                      children: [
                        Text(
                          "Vous n'avez pas reçu d'OTP? ",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        InkWell(
                          onTap: _isResendEnabled ? resendOTP : null,
                          child: Text(
                            "Renvoyer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _isResendEnabled ? Color(0xFF4A9E1F) : Colors.grey,
                              decoration: _isResendEnabled ? TextDecoration.underline : null,
                            ),
                          ),
                        )
                      ],
                    ),
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