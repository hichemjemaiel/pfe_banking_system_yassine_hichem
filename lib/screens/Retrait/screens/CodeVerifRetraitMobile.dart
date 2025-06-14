import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../TransactionsCertif.dart';
import '../../OTP/provider/OtpProvider.dart';
import '../provider/WithdrawlOpProvider.dart';
import 'TransactioncertifMobile.dart';

class Codeverifretraitmobile extends StatefulWidget {
  String montant;
  String opId;
  String BankId;
  String creditnum;
  String namecreditnum;
  String? otpCode;

  Codeverifretraitmobile({
    super.key,
    required this.otpCode,
    required this.montant,
    required this.opId,
    required this.BankId,
    required this.creditnum,
    required this.namecreditnum
  });

  @override
  State<Codeverifretraitmobile> createState() => _CodeverifretraitmobileState();
}

class _CodeverifretraitmobileState extends State<Codeverifretraitmobile> {
  String? BankOpId;
  Timer? _timer;
  int _timeLeft = 60; // 1 minute in seconds
  bool _isTimerActive = true;
  bool _isResending = false;

  // Controllers for OTP input
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
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
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

  void _startTimer() {
    setState(() {
      _timeLeft = 60;
      _isTimerActive = true;
    });

    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
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
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _resendOTP() async {
    if (_isResending) return;

    setState(() {
      _isResending = true;
    });

    try {
      // Generate new OTP
      await Provider.of<OtpProvider>(context, listen: false)
          .generateOtp("+21646491524");

      // Get the new OTP code
      final newOtpCode = await Provider.of<OtpProvider>(context, listen: false)
          .otpCode;

      // Update the widget's OTP code
      setState(() {
        widget.otpCode = newOtpCode;
      });

      // Clear all input fields
      _clearAllFields();

      // Restart timer
      _startTimer();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nouveau code OTP envoyé!'),
          backgroundColor: Color(0xFF4A9E1F),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'envoi du code. Veuillez réessayer.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() {
        _isResending = false;
      });
    }
  }

  void _clearAllFields() {
    o1.clear();
    o2.clear();
    o3.clear();
    o4.clear();
    o5.clear();
    o6.clear();
    f1.requestFocus();
  }

  void _onOTPChanged(String value, TextEditingController current, FocusNode? nextFocus, FocusNode? previousFocus) {
    if (value.length == 1) {
      // Move to next field
      if (nextFocus != null) {
        nextFocus.requestFocus();
      }
    } else if (value.isEmpty) {
      // Move to previous field
      if (previousFocus != null) {
        previousFocus.requestFocus();
      }
    }
  }

  Widget _buildOTPField(TextEditingController controller, FocusNode focusNode, FocusNode? nextFocus, FocusNode? previousFocus) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          counterText: '',
          contentPadding: EdgeInsets.all(0),
        ),
        onChanged: (value) {
          _onOTPChanged(value, controller, nextFocus, previousFocus);
        },
      ),
    );
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
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Image.asset("assets/otp.jpg", scale: 5),
                  SizedBox(height: 20),
                  Text(
                    "Entrez votre code de vérification\n    (OTP) pour confirmer votre\n                    transaction",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20),

                  // Timer Display
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _isTimerActive ? Color(0xFF4A9E1F) : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _isTimerActive
                          ? "Temps restant: ${_formatTime(_timeLeft)}"
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
                    onTap: _isTimerActive ? () async {
                      final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

                      if (code.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Veuillez saisir le code complet à 6 chiffres'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (code == widget.otpCode?.substring(widget.otpCode!.length - 6)) {
                        // Stop timer
                        _timer?.cancel();

                        // Process transaction
                        Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .setMontant(montant: int.parse(widget.montant));
                        Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .setDate(date: "${now.day}-${now.month}-${now.year}");
                        Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .setStatus();
                        Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .setCreditNum(creditnum: widget.creditnum);
                        Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .setNameCreditNum(namecreditnum: widget.namecreditnum);

                        await Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .saveWithdrawlOp();

                        final WithdrawlOp = await Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .withdrawlOp;

                        if (WithdrawlOp != null) {
                          setState(() {
                            BankOpId = WithdrawlOp.id.toString();
                          });
                        }

                        await Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .addOperateurToWithdarwlOp(BankOpId!, widget.opId);
                        await Provider.of<WithdrawlOpProvider>(context, listen: false)
                            .addWithdarwlOpToBankingAccount(BankOpId!, widget.BankId);

                        // Replace the navigation part in your Codeverifretraitmobile widget
// In the onTap function of the "Valider" button, replace the Navigator.push with:

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionscertifM(
                              montant: widget.montant,
                              operatorName: "Nom de l'opérateur", // You'll need to pass this from the previous screen
                              creditNumber: widget.creditnum,
                              ownerName: widget.namecreditnum,
                              accountType: "Type de compte", // You'll need to pass this from the previous screen
                              accountRIB: "RIB du compte", // You'll need to pass this from the previous screen
                              transactionDate: DateTime.now(),
                              transactionType: "Retrait Mobile Money",
                              commission: double.parse(widget.montant) * 0.02, // 2% commission
                              totalAmount: double.parse(widget.montant) + (double.parse(widget.montant) * 0.02),
                              transactionReference: BankOpId, // Use the generated BankOpId as reference
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Code OTP incorrect. Veuillez réessayer.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        _clearAllFields();
                      }
                    } : null,
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                        color: _isTimerActive ? Color(0xFF4A9E1F) : Colors.grey,
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
                          onTap: !_isTimerActive && !_isResending ? _resendOTP : null,
                          child: Text(
                            _isResending ? "Envoi..." : "Renvoyer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: !_isTimerActive && !_isResending
                                  ? Color(0xFF4A9E1F)
                                  : Colors.grey,
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
        ),
      ),
    );
  }
}