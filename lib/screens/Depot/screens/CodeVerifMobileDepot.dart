import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../TransactionsCertif.dart';
import '../provider/DepositOpProvider.dart';
import '../../OTP/provider/OtpProvider.dart';
import 'TransactionVerifMobileMoney.dart';

class Codeverifmobiledepot extends StatefulWidget {
  String? otpCode;
  final String? amount;
  final String? operatorName;
  final String? creditNumber;
  final String? accountType;
  final String? accountRIB;

  Codeverifmobiledepot({
    super.key,
    required this.otpCode,
    this.amount,
    this.operatorName,
    this.creditNumber,
    this.accountType,
    this.accountRIB,
  });

  @override
  State<Codeverifmobiledepot> createState() => _CodeverifmobiledepotState();
}

class _CodeverifmobiledepotState extends State<Codeverifmobiledepot> {
  String? BankOpId;

  // OTP Controllers
  TextEditingController o1 = TextEditingController();
  TextEditingController o2 = TextEditingController();
  TextEditingController o3 = TextEditingController();
  TextEditingController o4 = TextEditingController();
  TextEditingController o5 = TextEditingController();
  TextEditingController o6 = TextEditingController();

  // Focus Nodes for OTP fields
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  // Timer variables
  Timer? _timer;
  int _timeLeft = 60; // 1 minute in seconds
  bool _canResendOTP = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
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

  void _startTimer() {
    _canResendOTP = false;
    _timeLeft = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _canResendOTP = true;
          _timer?.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _resendOTP() async {
    if (_canResendOTP) {
      try {
        // Clear existing OTP fields
        _clearOTPFields();

        // Regenerate OTP
        await Provider.of<OtpProvider>(context, listen: false)
            .generateOtp("+21694399332");

        // Get new OTP code
        String? newOtpCode = Provider.of<OtpProvider>(context, listen: false).otpCode;

        // Update the widget's OTP code
        setState(() {
          widget.otpCode = newOtpCode;
        });

        // Restart timer
        _startTimer();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Nouveau code OTP envoyé!"),
            backgroundColor: Color(0xFF4A9E1F),
          ),
        );
      } catch (e) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de l'envoi du code OTP"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _clearOTPFields() {
    o1.clear();
    o2.clear();
    o3.clear();
    o4.clear();
    o5.clear();
    o6.clear();
    f1.requestFocus();
  }

  void _verifyOTP() {
    final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez saisir le code complet à 6 chiffres"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (code == widget.otpCode?.substring(widget.otpCode!.length - 6)) {
      _timer?.cancel();

      // Create transaction data to pass to certificate screen
      final transactionData = TransactionData(
        amount: widget.amount ?? "0",
        operatorName: widget.operatorName ?? "Mobile Money",
        creditNumber: widget.creditNumber ?? "",
        accountType: widget.accountType ?? "Compte",
        accountRIB: widget.accountRIB ?? "",
        transactionReference: DateTime.now().millisecondsSinceEpoch.toString().substring(3),
        transactionDate: DateTime.now(),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  TransactionscertifMoney(transactionData: transactionData)
          )
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Code OTP incorrect"),
          backgroundColor: Colors.red,
        ),
      );
      _clearOTPFields();
    }
  }

  Widget _buildOTPField(TextEditingController controller, FocusNode focusNode, FocusNode? nextFocusNode, FocusNode? previousFocusNode) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
          counterText: '',
        ),
        onChanged: (value) {
          if (value.length == 1) {
            // Move to next field
            if (nextFocusNode != null) {
              nextFocusNode.requestFocus();
            } else {
              // Last field, unfocus
              focusNode.unfocus();
            }
          } else if (value.isEmpty && previousFocusNode != null) {
            // Move to previous field when backspace is pressed
            previousFocusNode.requestFocus();
          }
        },
        onTap: () {
          // Clear the field when tapped
          controller.clear();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Code de vérification (OTP)"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: Column(
        children: [
          SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height +100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              children: [
                Image.asset("assets/otp.jpg", scale: 5),
                SizedBox(height: 20),
                Text(
                  "Entrez votre code de vérification\n    (OTP) pour confirmer votre\n                    transaction",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 30),

                // Timer Display
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: _timeLeft > 0 ? Color(0xFF4A9E1F) : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _timeLeft > 0
                        ? "Temps restant: ${_formatTime(_timeLeft)}"
                        : "Temps expiré",
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
                    _buildOTPField(o1, f1, f2, null),
                    _buildOTPField(o2, f2, f3, f1),
                    _buildOTPField(o3, f3, f4, f2),
                    _buildOTPField(o4, f4, f5, f3),
                    _buildOTPField(o5, f5, f6, f4),
                    _buildOTPField(o6, f6, null, f5),
                  ],
                ),

                SizedBox(height: 50),

                // Validate Button
                InkWell(
                  onTap: _verifyOTP,
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF4A9E1F),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Valider",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40),

                // Resend OTP Section
                Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Row(
                    children: [
                      Text(
                        "Vous n'avez pas reçu d'OTP? ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: _canResendOTP ? _resendOTP : null,
                        child: Text(
                          "Renvoyer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: _canResendOTP
                                ? Color(0xFF4A9E1F)
                                : Colors.grey,
                            decoration: _canResendOTP
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),),
    );
  }
}