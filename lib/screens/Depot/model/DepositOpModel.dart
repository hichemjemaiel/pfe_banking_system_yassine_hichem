import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/model/BankingOperationModel.dart';
import 'package:pfe_banking_system/screens/Depot/model/OperateurModel.dart';

class DepositOpModel extends BankingOperationModel {
  final int montant;
  final String date;
  final String creditnum;
  final Card? card;
  final OperateurModel? operateur;

  DepositOpModel({
    super.id,
    required this.montant,
    required this.date,
    required super.status,
    required this.creditnum,
    this.card,
    this.operateur,
  });

  factory DepositOpModel.fromJson(Map<String, dynamic> json) {
    // Handle the API response format where the actual data might be nested
    // or have different field names
    return DepositOpModel(
      id: json["depositId"] ?? json["id"], // Handle both possible field names
      montant: _parseIntSafely(json["amount"] ?? json["montant"]),
      date: json["date"] ?? "",
      status: json["status"] ?? "En attente",
      creditnum: json["creditnum"] ?? "",
      card: json["card"],
      operateur: json["operateur"],
    );
  }

  // Helper method to safely parse integers
  static int _parseIntSafely(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'montant': montant,
    'date': date,
    'status': status,
    'creditnum': creditnum,
    'card': card,
    'operateur': operateur,
  };
}