import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/DepositAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/PersonProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/SavingAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticuliernine.dart';
import 'package:pfe_banking_system/screens/OTP/provider/OtpProvider.dart';
import 'package:pfe_banking_system/screens/Reset%20password/screens/Psthree.dart';
import 'package:pfe_banking_system/screens/Reset%20password/model/MailSenderRequest.dart';
import 'package:pfe_banking_system/screens/Reset%20password/provider/MailSenderProvider.dart';
import 'package:provider/provider.dart';

class Pstwo extends StatefulWidget {
  String? email;
  String? otpCode;
  Pstwo({super.key, required this.otpCode, required this.email});

  @override
  State<Pstwo> createState() => _PstwoState();
}

class _PstwoState extends State<Pstwo> {
  TextEditingController o1 = TextEditingController();
  TextEditingController o2 = TextEditingController();
  TextEditingController o3 = TextEditingController();
  TextEditingController o4 = TextEditingController();
  TextEditingController o5 = TextEditingController();
  TextEditingController o6 = TextEditingController();

  // Focus nodes for auto-navigation
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  // Timer variables
  Timer? _timer;
  int _remainingSeconds = 60; // 1 minute = 60 seconds
  bool _canResendCode = false;
  bool _isResending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();

    // Add listeners to controllers for auto-navigation
    o1.addListener(() => _onTextChanged(o1, f2));
    o2.addListener(() => _onTextChanged(o2, f3));
    o3.addListener(() => _onTextChanged(o3, f4));
    o4.addListener(() => _onTextChanged(o4, f5));
    o5.addListener(() => _onTextChanged(o5, f6));
    o6.addListener(() => _onTextChanged(o6, null));
  }

  void _startTimer() {
    _remainingSeconds = 60;
    _canResendCode = false;
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _canResendCode = true;
          timer.cancel();
        }
      });
    });
  }

  void _onTextChanged(TextEditingController controller, FocusNode? nextFocus) {
    if (controller.text.length == 1) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      } else {
        // Last field, unfocus
        FocusScope.of(context).unfocus();
      }
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showToast(String message, {bool isError = true}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> _resendCode() async {
    if (!_canResendCode || _isResending) return;

    setState(() {
      _isResending = true;
    });

    try {
      // Clear existing OTP fields
      o1.clear();
      o2.clear();
      o3.clear();
      o4.clear();
      o5.clear();
      o6.clear();

      // Send new OTP
      MailSenderRequest request = MailSenderRequest(
          toEmail: widget.email!,
          subject: "OTP"
      );

      await Provider.of<MailSenderProvider>(context, listen: false).sendMail(request);
      final newOtpCode = await Provider.of<MailSenderProvider>(context, listen: false).otpCode;

      // Update the OTP code
      widget.otpCode = newOtpCode;

      // Restart timer
      _startTimer();

      // Focus on first field
      FocusScope.of(context).requestFocus(f1);

      _showToast("Un nouveau code a été envoyé!", isError: false);
    } catch (e) {
      _showToast("Erreur lors de l'envoi du code. Veuillez réessayer.");
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  Widget _buildOTPField(TextEditingController controller, FocusNode focusNode) {
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
        onChanged: (value) {
          if (value.length == 1) {
            // Move to next field automatically handled by listener
          } else if (value.isEmpty) {
            // Handle backspace - move to previous field
            _moveToPreviousField(focusNode);
          }
        },
      ),
    );
  }

  void _moveToPreviousField(FocusNode currentFocus) {
    if (currentFocus == f2) {
      FocusScope.of(context).requestFocus(f1);
    } else if (currentFocus == f3) {
      FocusScope.of(context).requestFocus(f2);
    } else if (currentFocus == f4) {
      FocusScope.of(context).requestFocus(f3);
    } else if (currentFocus == f5) {
      FocusScope.of(context).requestFocus(f4);
    } else if (currentFocus == f6) {
      FocusScope.of(context).requestFocus(f5);
    }
  }

  void _verifyOTP() {
    final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

    if (code.length != 6) {
      _showToast("Veuillez entrer le code complet");
      return;
    }

    if (code == widget.otpCode) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Psthree(email: widget.email))
      );
    } else {
      _showToast("Code incorrect. Veuillez réessayer.");
      // Clear fields and focus on first
      o1.clear();
      o2.clear();
      o3.clear();
      o4.clear();
      o5.clear();
      o6.clear();
      FocusScope.of(context).requestFocus(f1);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
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
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "Validation",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            _formatTime(_remainingSeconds),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: _remainingSeconds > 0 ? Color(0xFF4A9E04) : Colors.red,
            ),
          ),
          SizedBox(height: 20),
          Text(
            _remainingSeconds > 0
                ? "Votre code expirera dans quelques minutes\n                   Entrez vite le code"
                : "Le code a expiré\n       Demandez un nouveau code",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 40),
          Text(
            "Entrez votre code de vérification",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOTPField(o1, f1),
              _buildOTPField(o2, f2),
              _buildOTPField(o3, f3),
              _buildOTPField(o4, f4),
              _buildOTPField(o5, f5),
              _buildOTPField(o6, f6),
            ],
          ),
          SizedBox(height: 40),
          Text(
            "    Un message avec un code de vérification a été\n  envoyé au ${widget.email}. Entrez le code pour continuer",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 40),
          InkWell(
            onTap: _canResendCode && !_isResending ? _resendCode : null,
            child: Text(
              _isResending
                  ? "Envoi en cours..."
                  : (_canResendCode
                  ? "Vous n'avez pas reçu de code\n            de vérification? Renvoyer"
                  : "Vous n'avez pas reçu de code\n            de vérification?"),
              style: TextStyle(
                  fontSize: 18,
                  color: _canResendCode && !_isResending
                      ? Color(0xFF2A5EA1)
                      : Colors.grey,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 100),
                child: InkWell(
                  onTap: _verifyOTP,
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
                              color: Colors.white
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