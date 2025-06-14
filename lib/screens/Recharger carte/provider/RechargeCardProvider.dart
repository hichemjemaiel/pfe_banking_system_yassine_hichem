import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/model/RechargeCardModel.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/service/RechargeCardService.dart';

class RechargerCardProvider extends ChangeNotifier {
  String? debitRib;
  String? banque;
  String? nom;
  int? montant;
  String? date;
  String? time;
  RechargeCardModel? rechargeCard;
  RechargerCardService service = RechargerCardService();
  bool _isLoading = false;
  String? _error;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;

  void setDebitRib({required String debitRib}) {
    this.debitRib = debitRib;
    _error = null;
    notifyListeners();
  }

  void setBanque({required String banque}) {
    this.banque = banque;
    _error = null;
    notifyListeners();
  }

  void setName({required String nom}) {
    this.nom = nom;
    _error = null;
    notifyListeners();
  }

  void setMontant({required int montant}) {
    this.montant = montant;
    _error = null;
    notifyListeners();
  }

  void setDate({required String date}) {
    this.date = date;
    _error = null;
    notifyListeners();
  }

  void setTime({required String time}) {
    this.time = time;
    _error = null;
    notifyListeners();
  }

  Future<void> saveRechargeCard() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Validate required fields
      if (debitRib == null || debitRib!.isEmpty) {
        throw Exception("RIB de débit requis");
      }
      if (banque == null || banque!.isEmpty) {
        throw Exception("Banque requise");
      }
      if (nom == null || nom!.isEmpty) {
        throw Exception("Nom requis");
      }
      if (montant == null || montant! <= 0) {
        throw Exception("Montant valide requis");
      }

      // Set current date and time if not already set
      DateTime now = DateTime.now();
      if (date == null) {
        date = "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
      }
      if (time == null) {
        time = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
      }

      print("Creating recharge with data:");
      print("DebitRib: $debitRib");
      print("Banque: $banque");
      print("Nom: $nom");
      print("Montant: $montant");
      print("Date: $date");
      print("Time: $time");

      RechargeCardModel rechargeCardModel = RechargeCardModel(
        debitRib: debitRib!,
        banque: banque!,
        nom: nom!,
        montant: montant!,
        date: date!,
        time: time!,
      );

      final result = await service.addRecharge(rechargeCardModel);

      if (result != null) {
        rechargeCard = result;
        print("Recharge Card created successfully with ID: ${rechargeCard?.id}");

        // Verify the ID is not null
        if (rechargeCard?.id == null) {
          throw Exception("Réponse du serveur invalide - ID de recharge manquant");
        }
      } else {
        throw Exception("Échec de la création de la recharge - réponse nulle");
      }
    } catch (e) {
      _error = e.toString();
      print("Error in creating Recharge card in Provider: $e");
      rechargeCard = null; // Reset on error
      rethrow; // Re-throw to let the UI handle it
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addRechargeToCard(String RId, String CId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Validate inputs
      if (RId.isEmpty) {
        throw Exception("ID de recharge invalide");
      }
      if (CId.isEmpty) {
        throw Exception("ID de carte invalide");
      }

      final rechargeId = int.tryParse(RId);
      final cardId = int.tryParse(CId);

      if (rechargeId == null) {
        throw Exception("ID de recharge invalide: $RId");
      }
      if (cardId == null) {
        throw Exception("ID de carte invalide: $CId");
      }

      print("Adding recharge $rechargeId to card $cardId");
      final result = await service.addRechargeToCard(rechargeId, cardId);

      if (result) {
        print("Recharge $rechargeId added successfully to card $cardId");
      } else {
        throw Exception("Échec de l'ajout de la recharge à la carte");
      }
    } catch (e) {
      _error = e.toString();
      print("Error in adding recharge to card in Provider: $e");
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to clear all data
  void clear() {
    debitRib = null;
    banque = null;
    nom = null;
    montant = null;
    date = null;
    time = null;
    rechargeCard = null;
    _error = null;
    _isLoading = false;
    notifyListeners();
  }
}