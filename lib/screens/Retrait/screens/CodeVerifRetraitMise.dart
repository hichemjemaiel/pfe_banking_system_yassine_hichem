import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/TransactionCertifMise.dart';
import 'package:provider/provider.dart';

import '../../TransactionsCertif.dart';
import '../../OTP/provider/OtpProvider.dart';
import '../provider/WithdrawlOpProvider.dart';

class Codeverifretraitmise extends StatefulWidget {
  String montant;
  String BankId;
  String creditnum;
  String namecreditnum;
  String? otpCode;
  String accountRIB;
  String accountType;

  Codeverifretraitmise({
    super.key,
    required this.otpCode,
    required this.montant,
    required this.BankId,
    required this.creditnum,
    required this.namecreditnum,
    required this.accountRIB,
    required this.accountType,
  });

  @override
  State<Codeverifretraitmise> createState() => _CodeverifretraitmiseState();
}

class _CodeverifretraitmiseState extends State<Codeverifretraitmise> {
  String? BankOpId;
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
  int _timeLeft = 60; // 1 minute in seconds
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
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

  void _startTimer() {
    _canResend = false;
    _timeLeft = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  void _resendOTP() async {
    if (_canResend) {
      // Clear all OTP fields
      o1.clear();
      o2.clear();
      o3.clear();
      o4.clear();
      o5.clear();
      o6.clear();

      // Focus on first field
      FocusScope.of(context).requestFocus(f1);

      // Generate new OTP
      await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21646491524");
      widget.otpCode = await Provider.of<OtpProvider>(context, listen: false).otpCode;

      // Restart timer
      _startTimer();

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Nouveau code OTP envoyé"),
            backgroundColor: Color(0xFF4A9E1F),
          )
      );
    }
  }

  void _onOtpChanged(String value, TextEditingController current, FocusNode? nextFocus, FocusNode? previousFocus) {
    if (value.length == 1) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      }
    } else if (value.isEmpty) {
      if (previousFocus != null) {
        FocusScope.of(context).requestFocus(previousFocus);
      }
    }
  }

  bool _isOtpComplete() {
    return o1.text.isNotEmpty &&
        o2.text.isNotEmpty &&
        o3.text.isNotEmpty &&
        o4.text.isNotEmpty &&
        o5.text.isNotEmpty &&
        o6.text.isNotEmpty;
  }

  String _getEnteredOtp() {
    return o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;
  }

  void _validateOtp() async {
    if (_isOtpComplete()) {
      String enteredOtp = _getEnteredOtp();

      // Extract OTP code from the generated string using regex
      String? actualOtpCode = widget.otpCode;
      if (actualOtpCode != null) {
        // Extract 6-digit number from the string
        RegExp regExp = RegExp(r'\d{6}');
        Match? match = regExp.firstMatch(actualOtpCode);
        if (match != null) {
          actualOtpCode = match.group(0);
        }
      }

      // Debug: Print both OTPs for comparison
      print("Entered OTP: '$enteredOtp'");
      print("Generated OTP: '${widget.otpCode}'");
      print("Cleaned OTP: '$actualOtpCode'");
      print("OTP Length - Entered: ${enteredOtp.length}, Generated: ${widget.otpCode?.length}, Cleaned: ${actualOtpCode?.length}");

      // Check if entered OTP matches the generated OTP
      // Temporary: Also accept "123456" for testing purposes
      if (enteredOtp == actualOtpCode || enteredOtp == "123456") {
        DateTime now = DateTime.now();

        Provider.of<WithdrawlOpProvider>(context, listen: false).setMontant(montant: int.parse(widget.montant));
        Provider.of<WithdrawlOpProvider>(context, listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
        Provider.of<WithdrawlOpProvider>(context, listen: false).setStatus();
        Provider.of<WithdrawlOpProvider>(context, listen: false).setCreditNum(creditnum: widget.creditnum);
        Provider.of<WithdrawlOpProvider>(context, listen: false).setNameCreditNum(namecreditnum: widget.namecreditnum);

        await Provider.of<WithdrawlOpProvider>(context, listen: false).saveWithdrawlOp();
        final WithdrawlOp = await Provider.of<WithdrawlOpProvider>(context, listen: false).withdrawlOp;

        if (WithdrawlOp != null) {
          setState(() {
            BankOpId = WithdrawlOp.id.toString();
          });
          print("Withdrawl Op created ${BankOpId}");

          await Provider.of<WithdrawlOpProvider>(context, listen: false).addWithdarwlOpToBankingAccount(BankOpId!, widget.BankId);

          // Navigate to success screen with transaction data
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionscertifMiseD(
                    montant: widget.montant,
                    creditnum: widget.creditnum,
                    namecreditnum: widget.namecreditnum,
                    accountRIB: widget.accountRIB,
                    accountType: widget.accountType,
                    transactionId: BankOpId,
                    date: "${now.day}-${now.month}-${now.year}",
                  )
              )
          );
        }
      } else {
        // Show detailed error message for debugging
        String errorMsg = widget.otpCode == null
            ? "Code OTP non généré"
            : "Code OTP incorrect (Entré: '$enteredOtp', Attendu: '${widget.otpCode}')";

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 5),
            )
        );

        // Clear all fields and focus on first
        o1.clear();
        o2.clear();
        o3.clear();
        o4.clear();
        o5.clear();
        o6.clear();
        FocusScope.of(context).requestFocus(f1);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Veuillez saisir le code OTP complet"),
            backgroundColor: Colors.orange,
          )
      );
    }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height + 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                children: [
                  Image.asset("assets/otp.jpg", scale: 5),
                  SizedBox(height: 20),
                  // Debug: Show generated OTP (remove in production)
                  if (widget.otpCode != null)
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Text(
                        "Debug - Generated OTP: ${widget.otpCode}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  Text(
                    "Entrez votre code de vérification\n    (OTP) pour confirmer votre\n                    transaction",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  SizedBox(height: 20),
                  // Timer Display
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _timeLeft > 0 ? Color(0xFF4A9E1F) : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _timeLeft > 0 ? "Temps restant: ${_formatTime(_timeLeft)}" : "Code expiré",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOtpField(o1, f1, f2, null),
                      _buildOtpField(o2, f2, f3, f1),
                      _buildOtpField(o3, f3, f4, f2),
                      _buildOtpField(o4, f4, f5, f3),
                      _buildOtpField(o5, f5, f6, f4),
                      _buildOtpField(o6, f6, null, f5),
                    ],
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: _isOtpComplete() && _timeLeft > 0 ? _validateOtp : null,
                    child: Container(
                      width: 350,
                      height: 50,
                      decoration: BoxDecoration(
                          color: _isOtpComplete() && _timeLeft > 0
                              ? Color(0xFF4A9E1F)
                              : Colors.grey,
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
                          onTap: _canResend ? _resendOTP : null,
                          child: Text(
                            "Renvoyer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _canResend ? Color(0xFF4A9E1F) : Colors.grey,
                              decoration: _canResend ? TextDecoration.underline : null,
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

  Widget _buildOtpField(TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus, FocusNode? previousFocus) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        onChanged: (value) {
          _onOtpChanged(value, controller, nextFocus, previousFocus);
          setState(() {}); // Refresh to update button state
        },
      ),
    );
  }
}