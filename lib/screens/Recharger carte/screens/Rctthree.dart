import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../TransactionsCertif.dart';
import '../../OTP/provider/OtpProvider.dart';
import '../provider/RechargeCardProvider.dart';
import 'TransactionVertifCard.dart';

class Rctthree extends StatefulWidget {
  String montant;
  String? otpCode;
  String nom;
  String card;
  int ind3;
  String debitRib;

  Rctthree({
    super.key,
    required this.otpCode,
    required this.montant,
    required this.nom,
    required this.card,
    required this.ind3,
    required this.debitRib
  });

  @override
  State<Rctthree> createState() => _RctthreeState();
}

class _RctthreeState extends State<Rctthree> {
  String? BankOpId;
  String? rechargeId;

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

  // Timer variables
  Timer? _timer;
  int _timeLeft = 60; // 1 minute countdown
  bool _canResend = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
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

  void _startCountdown() {
    setState(() {
      _timeLeft = 60;
      _canResend = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        setState(() {
          _canResend = true;
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

  Future<void> _resendOTP() async {
    if (!_canResend || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Generate new OTP
      await Provider.of<OtpProvider>(context, listen: false)
          .generateOtp("+21698698739");

      // Get the new OTP code
      final newOtpCode = Provider.of<OtpProvider>(context, listen: false).otpCode;

      if (newOtpCode != null) {
        setState(() {
          widget.otpCode = newOtpCode;
          // Clear all OTP fields
          o1.clear();
          o2.clear();
          o3.clear();
          o4.clear();
          o5.clear();
          o6.clear();
        });

        // Restart countdown
        _startCountdown();

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Nouveau code OTP envoyé"),
              backgroundColor: Color(0xFF4A9E1F),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de l'envoi de l'OTP: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildOTPField(
      TextEditingController controller,
      FocusNode focusNode,
      FocusNode? nextFocusNode,
      FocusNode? previousFocusNode,
      ) {
    return SizedBox(
      width: 60,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF4A9E1F), width: 2),
          ),
        ),
        onChanged: (value) {
          if (value.isNotEmpty && nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          } else if (value.isEmpty && previousFocusNode != null) {
            FocusScope.of(context).requestFocus(previousFocusNode);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text("Code de vérification (OTP)"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height +100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset("assets/otp.jpg", scale: 5),
                    const SizedBox(height: 20),
                    const Text(
                      "Entrez votre code de vérification\n    (OTP) pour confirmer votre\n                    transaction",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 30),

                    // Countdown Timer
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: _timeLeft > 0 ? const Color(0xFF4A9E1F) : Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _timeLeft > 0
                            ? "Code expire dans: ${_formatTime(_timeLeft)}"
                            : "Code expiré",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

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

                    const SizedBox(height: 50),

                    // Validate Button
                    InkWell(
                      onTap: _isLoading ? null : () async {
                        final String code = o1.text + o2.text + o3.text + o4.text + o5.text + o6.text;

                        if (code.length != 6) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Veuillez entrer le code complet"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (code == widget.otpCode?.substring(widget.otpCode!.length - 6)) {
                          setState(() {
                            _isLoading = true;
                          });

                          try {
                            final rechargeProvider = Provider.of<RechargerCardProvider>(context, listen: false);

                            // Validate all required data before proceeding
                            if (widget.debitRib.isEmpty) {
                              throw Exception("RIB de débit manquant");
                            }
                            if (widget.nom.trim().isEmpty) {
                              throw Exception("Nom du porteur manquant");
                            }
                            if (widget.card.isEmpty) {
                              throw Exception("ID de carte manquant");
                            }

                            final amount = int.tryParse(widget.montant);
                            if (amount == null || amount <= 0) {
                              throw Exception("Montant invalide");
                            }

                            // Set all required fields in the provider
                            rechargeProvider.setDebitRib(debitRib: widget.debitRib);

                            String bankName = "";
                            switch (widget.ind3) {
                              case 0:
                                bankName = "UBA GABON";
                                break;
                              case 1:
                                bankName = "ORABANK GABON";
                                break;
                              case 2:
                                bankName = "ECOBANK GABON";
                                break;
                              default:
                                throw Exception("Banque non sélectionnée");
                            }
                            rechargeProvider.setBanque(banque: bankName);
                            rechargeProvider.setName(nom: widget.nom.trim());
                            rechargeProvider.setMontant(montant: amount);

                            // Save the recharge card
                            await rechargeProvider.saveRechargeCard();

                            // Get the created recharge and validate it
                            final recharge = rechargeProvider.rechargeCard;

                            if (recharge == null) {
                              throw Exception("Échec de la création de la recharge");
                            }

                            if (recharge.id == null) {
                              throw Exception("ID de recharge manquant dans la réponse du serveur");
                            }

                            // Set the recharge ID for use in the next step
                            setState(() {
                              rechargeId = recharge.id.toString();
                            });

                            print("Recharge created successfully with ID: $rechargeId");

                            // Add the recharge to the card
                            await rechargeProvider.addRechargeToCard(rechargeId!, widget.card);

                            // Navigate to success screen
                            if (mounted) {
                              // Updated navigation section in Rctthree.dart
// Replace the existing navigation call in the OTP validation success block

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionscertifCard(
                                    montant: widget.montant,
                                    creditRib: widget.card, // The card being credited
                                    cardNumber: widget.card, // You might want to get the actual card number from provider
                                    cardHolderName: widget.nom,
                                    banque: widget.ind3 == 0
                                        ? "UBA GABON"
                                        : widget.ind3 == 1
                                        ? "ORABANK GABON"
                                        : widget.ind3 == 2
                                        ? "ECOBANK GABON"
                                        : "N/A",
                                    operationType: "Recharge de carte",
                                    reference: rechargeId, // Using the recharge ID as reference
                                    transactionDate: DateTime.now(),
                                  ),
                                ),
                              );
                            }
                          } catch (e) {
                            print("Detailed error in OTP validation: $e");
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Erreur lors de la transaction: $e"),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 5),
                                ),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isLoading = false;
                              });
                            }
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Code OTP incorrect"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: _isLoading ? Colors.grey : const Color(0xFF4A9E1F),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
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

                    // Resend OTP Section
                    Padding(
                      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Vous n'avez pas reçu d'OTP? ",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: _canResend && !_isLoading ? _resendOTP : null,
                            child: Text(
                              "Renvoyer",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: _canResend && !_isLoading
                                    ? const Color(0xFF4A9E1F)
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}