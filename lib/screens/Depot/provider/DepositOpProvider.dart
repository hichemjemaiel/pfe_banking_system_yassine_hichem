import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/model/DepositOpModel.dart';
import 'package:pfe_banking_system/screens/Depot/service/DepositOpService.dart';

class DepositOpProvider extends ChangeNotifier {
  DepositOpService depositOpService = DepositOpService();
  DepositOpModel? depositOpModel;
  int? montant;
  String? date;
  String? status;
  String? creditnum;
  String? errorMessage;
  bool isLoading = false;

  void setMontant({required int montant}) {
    this.montant = montant;
    notifyListeners();
  }

  void setDate({required String date}) {
    this.date = date;
    notifyListeners();
  }

  void setStatus() {
    this.status = "En attente";
  }

  void setCreditNum({required String creditnum}) {
    this.creditnum = creditnum;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  Future<void> saveDepositOp() async {
    if (montant != null && date != null && status != null) {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      DepositOpModel depositOp = DepositOpModel(
        montant: montant!,
        date: date!,
        status: status!,
        creditnum: creditnum ?? "", // Provide default empty string
      );

      try {
        final result = await depositOpService.addDepositOp(depositOp);
        if (result != null) {
          depositOpModel = result;
          print("Deposit Op created with ID : ${result.id}");
          clearError();
        } else {
          setError("Failed to create deposit operation");
        }
      } catch (e) {
        print("Error creating Deposit Op: $e");
        setError("Error creating Deposit Op: ${e.toString()}");
      } finally {
        isLoading = false;
        notifyListeners();
      }
    } else {
      setError("Missing required fields: montant, date, or status");
    }
  }

  Future<bool> addCardToDepositOp(String depositId, String cardId) async {
    try {
      int dId = int.parse(depositId);
      int cId = int.parse(cardId);
      final result = await depositOpService.addCardToDepositOp(dId, cId);
      if (result) {
        print("Successful linking");
        print("Deposit Op $dId linked to Card $cId successfully");
        return true;
      }
      return false;
    } catch (e) {
      print("Error in linking: $e");
      setError("Error linking card: ${e.toString()}");
      return false;
    }
  }

  Future<bool> addOperateurToDepositOp(String depositId, String operateurId) async {
    try {
      int dId = int.parse(depositId);
      int oId = int.parse(operateurId);
      final result = await depositOpService.addOperateurToDepositOp(dId, oId);
      if (result) {
        print("Successful linking");
        print("Deposit Op $dId linked to $oId successfully");
        return true;
      }
      return false;
    } catch (e) {
      print("Error in linking: $e");
      setError("Error linking operateur: ${e.toString()}");
      return false;
    }
  }

  Future<bool> addDepositOpToBankingAccount(String depositId, String bankingAccountId) async {
    try {
      int dId = int.parse(depositId);
      int bId = int.parse(bankingAccountId);
      final result = await depositOpService.addDepositOpToBankingAccount(dId, bId);
      if (result) {
        print("Successful linking");
        print("Deposit Op $dId linked to $bId successfully");
        return true;
      }
      return false;
    } catch (e) {
      print("Error in linking: $e");
      setError("Error linking banking account: ${e.toString()}");
      return false;
    }
  }
}