import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/TransactionVerifRAgence.dart';
import 'package:provider/provider.dart';

import '../../TransactionsCertif.dart';
import '../../OTP/provider/OtpProvider.dart';
import '../provider/WithdrawlOpProvider.dart';

class Codeverifretraitagence extends StatefulWidget {
  int montant;
  int agencyId;
  int BankingId;
  String? otpCode;
  String? agencyName;
  String? accountRIB;

  Codeverifretraitagence({
    super.key,
    required this.otpCode,
    required this.montant,
    required this.agencyId,
    required this.BankingId,
    this.agencyName,
    this.accountRIB,
  });

  @override
  State<Codeverifretraitagence> createState() => _CodeverifretraitagenceState();
}

class _CodeverifretraitagenceState extends State<Codeverifretraitagence> {
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
  int _secondsRemaining = 60; // 1 minute countdown
  bool _isTimerActive = true;
  String? _currentOtpCode;

  @override
  void initState() {
    super.initState();
    _currentOtpCode = widget.otpCode;
    _startTimer();

    // Auto-focus on first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      f1.requestFocus();
    });
  }

  void _startTimer() {
    _isTimerActive = true;
    _secondsRemaining = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _isTimerActive = false;
          _timer?.cancel();
        }
      });
    });
  }

  void _resendOTP() async {
    try {
      // Generate new OTP
      await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21694399332");
      String? newOtpCode = Provider.of<OtpProvider>(context, listen: false).otpCode;

      setState(() {
        _currentOtpCode = newOtpCode;
        // Clear all input fields
        o1.clear();
        o2.clear();
        o3.clear();
        o4.clear();
        o5.clear();
        o6.clear();
      });

      // Restart timer
      _startTimer();

      // Focus on first field
      f1.requestFocus();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nouveau code OTP envoyé!"),
          backgroundColor: Color(0xFF4A9E1F),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur lors de l'envoi de l'OTP. Veuillez réessayer."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  Widget _buildOTPField(TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
          // Clear field when tapped
          controller.clear();
        },
      ),
    );
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
    DateTime now = DateTime.now();

    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Code de vérification (OTP)"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 173,
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
                        ? "Code expire dans: ${_formatTime(_secondsRemaining)}"
                        : "Code expiré",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildOTPField(o1, f1, f2),
                    _buildOTPField(o2, f2, f3),
                    _buildOTPField(o3, f3, f4),
                    _buildOTPField(o4, f4, f5),
                    _buildOTPField(o5, f5, f6),
                    _buildOTPField(o6, f6, null),
                  ],
                ),

                SizedBox(height: 50),

                // Validate Button
                InkWell(
                  onTap: () async {
                    final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

                    if (code.length != 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Veuillez saisir les 6 chiffres du code OTP"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (!_isTimerActive) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Le code OTP a expiré. Veuillez demander un nouveau code."),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    if (code == _currentOtpCode?.substring(_currentOtpCode!.length - 6)) {
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
                        Provider.of<WithdrawlOpProvider>(context, listen: false).setMontant(montant: widget.montant);
                        Provider.of<WithdrawlOpProvider>(context, listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                        Provider.of<WithdrawlOpProvider>(context, listen: false).setStatus();
                        Provider.of<WithdrawlOpProvider>(context, listen: false).setCreditNum(creditnum: "");
                        Provider.of<WithdrawlOpProvider>(context, listen: false).setNameCreditNum(namecreditnum: "");
                        await Provider.of<WithdrawlOpProvider>(context, listen: false).saveWithdrawlOp();

                        final WithdrawlOp = await Provider.of<WithdrawlOpProvider>(context, listen: false).withdrawlOp;
                        if (WithdrawlOp != null) {
                          setState(() {
                            BankOpId = WithdrawlOp.id.toString();
                          });
                        }

                        await Provider.of<BankingOpProvider>(context, listen: false).addBankingOperationToAgency(BankOpId!, widget.agencyId.toString());
                        await Provider.of<WithdrawlOpProvider>(context, listen: false).addWithdarwlOpToBankingAccount(BankOpId!, widget.BankingId.toString());

                        // Close loading dialog
                        Navigator.pop(context);

                        // Navigate to success screen with transaction data
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TransactionscertifRAgence(
                                  montant: widget.montant,
                                  agencyName: widget.agencyName ?? "Agency ${widget.agencyId}",
                                  accountRIB: widget.accountRIB ?? "Compte ID: ${widget.BankingId}",
                                  transactionReference: BankOpId ?? "En cours...",
                                  transactionDate: DateTime.now(),
                                  operationType: "Retrait en Agence",
                                )
                            )
                        );
                      } catch (e) {
                        // Close loading dialog
                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Erreur lors du traitement. Veuillez réessayer."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Code OTP incorrect. Veuillez réessayer."),
                          backgroundColor: Colors.red,
                        ),
                      );

                      // Clear all fields and focus on first
                      o1.clear();
                      o2.clear();
                      o3.clear();
                      o4.clear();
                      o5.clear();
                      o6.clear();
                      f1.requestFocus();
                    }
                  },
                  child: Container(
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
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
                        onTap: _isTimerActive ? null : _resendOTP,
                        child: Text(
                          "Renvoyer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: _isTimerActive ? Colors.grey : Color(0xFF4A9E1F),
                            decoration: _isTimerActive ? null : TextDecoration.underline,
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
    );
  }
}