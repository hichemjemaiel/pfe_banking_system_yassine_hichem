import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20vers%20autre%20compte/TransactionCertifV.dart';
import 'package:provider/provider.dart';
import '../../../OTP/provider/OtpProvider.dart';
import '../../../TransactionsCertif.dart';
import '../../provider/TransferOpProvider.dart';

class Codeverifecobank extends StatefulWidget {
  String montant;
  String namecreditnum;
  String? otpCode;
  String senderRIB;
  String receiverRIB;
  String BankId;

  Codeverifecobank({
    super.key,
    required this.otpCode,
    required this.montant,
    required this.BankId,
    required this.namecreditnum,
    required this.senderRIB,
    required this.receiverRIB,
  });

  @override
  State<Codeverifecobank> createState() => _CodeverifecobankState();
}

class _CodeverifecobankState extends State<Codeverifecobank> {
  String? BankOpId;
  TextEditingController o1 = TextEditingController();
  TextEditingController o2 = TextEditingController();
  TextEditingController o3 = TextEditingController();
  TextEditingController o4 = TextEditingController();
  TextEditingController o5 = TextEditingController();
  TextEditingController o6 = TextEditingController();

  // Focus nodes for OTP input
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();
  FocusNode f6 = FocusNode();

  // Timer variables
  Timer? _timer;
  int _remainingTime = 60; // 1 minute in seconds
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
    _remainingTime = 60;
    _canResend = false;
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _canResend = true;
          timer.cancel();
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
      // Clear current OTP inputs
      o1.clear();
      o2.clear();
      o3.clear();
      o4.clear();
      o5.clear();
      o6.clear();

      // Focus on first input
      FocusScope.of(context).requestFocus(f1);

      // Generate new OTP
      await Provider.of<OtpProvider>(context, listen: false).generateOtp("+21698698739");
      String? newOtpCode = Provider.of<OtpProvider>(context, listen: false).otpCode;

      setState(() {
        widget.otpCode = newOtpCode;
      });

      // Restart timer
      _startTimer();

      // Show confirmation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Nouveau code OTP envoyé!"),
          backgroundColor: Color(0xFF4A9E1F),
        ),
      );
    }
  }

  void _onChanged(String value, TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus) {
    if (value.length == 1) {
      if (nextFocus != null) {
        FocusScope.of(context).requestFocus(nextFocus);
      } else {
        currentFocus.unfocus();
      }
    } else if (value.isEmpty) {
      // Handle backspace - move to previous field
      if (controller == o2) FocusScope.of(context).requestFocus(f1);
      else if (controller == o3) FocusScope.of(context).requestFocus(f2);
      else if (controller == o4) FocusScope.of(context).requestFocus(f3);
      else if (controller == o5) FocusScope.of(context).requestFocus(f4);
      else if (controller == o6) FocusScope.of(context).requestFocus(f5);
    }
  }

  Widget _buildOTPField(TextEditingController controller, FocusNode focusNode, FocusNode? nextFocus) {
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
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
        ),
        onChanged: (value) => _onChanged(value, controller, focusNode, nextFocus),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height + 100,
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
                  // Timer display
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _remainingTime > 0 ? Color(0xFF4A9E1F) : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _remainingTime > 0
                          ? "Temps restant: ${_formatTime(_remainingTime)}"
                          : "Code expiré",
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
                      _buildOTPField(o1, f1, f2),
                      _buildOTPField(o2, f2, f3),
                      _buildOTPField(o3, f3, f4),
                      _buildOTPField(o4, f4, f5),
                      _buildOTPField(o5, f5, f6),
                      _buildOTPField(o6, f6, null),
                    ],
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () async {
                      final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

                      // Validate OTP length
                      if (code.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Veuillez saisir le code complet à 6 chiffres"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Check if timer expired
                      if (_remainingTime <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Le code OTP a expiré. Veuillez demander un nouveau code."),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (code == widget.otpCode?.substring(widget.otpCode!.length - 6)) {
                        DateTime now = DateTime.now();
                        Provider.of<TransferOpProvider>(context, listen: false).setMontant(montant: int.parse(widget.montant));
                        Provider.of<TransferOpProvider>(context, listen: false).setDate(date: "${now.day}-${now.month}-${now.year}");
                        Provider.of<TransferOpProvider>(context, listen: false).setStatus();
                        Provider.of<TransferOpProvider>(context, listen: false).setSenderRIB(senderRIB: widget.senderRIB);
                        Provider.of<TransferOpProvider>(context, listen: false).setReceiverRIB(receiverRIB: widget.receiverRIB);
                        Provider.of<TransferOpProvider>(context, listen: false).setNameCreditNum(namecreditnum: widget.namecreditnum);
                        await Provider.of<TransferOpProvider>(context, listen: false).saveTransferOp();
                        final TransferOp = await Provider.of<TransferOpProvider>(context, listen: false).transferModel;
                        if (TransferOp != null) {
                          setState(() {
                            BankOpId = TransferOp.id.toString();
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionscertifV(
                                operationType: "Transfert",
                                montant: TransferOp.montant.toString(),
                                date: TransferOp.date,
                                reference: BankOpId!,
                                motifs: "Autres",
                              ),
                            ),
                          );
                        }
                        await Provider.of<TransferOpProvider>(context, listen: false).addTransferOpToBankingAccount(BankOpId!, widget.BankId);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Code OTP incorrect. Veuillez réessayer."),
                            backgroundColor: Colors.red,
                          ),
                        );

                        // Clear fields and focus on first
                        o1.clear();
                        o2.clear();
                        o3.clear();
                        o4.clear();
                        o5.clear();
                        o6.clear();
                        FocusScope.of(context).requestFocus(f1);
                      }
                    },
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
                  Padding(
                    padding: EdgeInsets.only(top: 40, left: 60),
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
                          onTap: _resendOTP,
                          child: Text(
                            "Renvoyer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _canResend ? Color(0xFF4A9E1F) : Colors.grey,
                              decoration: _canResend ? TextDecoration.underline : null,
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