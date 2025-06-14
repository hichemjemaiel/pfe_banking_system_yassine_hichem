// Updated ContactDtoModel.dart with toJson method for updates
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModel.dart';

class BankingAccountDto {
  final int? id;
  final String type;
  final String RIB;
  final String? intitule;

  BankingAccountDto({
    this.id,
    required this.type,
    required this.RIB,
    this.intitule,
  });

  factory BankingAccountDto.fromJson(Map<String, dynamic> json) {
    return BankingAccountDto(
      id: json['id'],
      type: json['type'] ?? '',
      RIB: json['rib'] ?? '',
      intitule: json['intitule'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'rib': RIB,
      'intitule': intitule,
    };
  }
}

class ContactDtoModel {
  final int? id;
  final String nom;
  final String type;
  final String? adresse;
  final String? categorie;
  final List<BankingAccountDto> bankingAccounts;
  final ClientModel? clientModel;

  ContactDtoModel({
    this.id,
    required this.nom,
    required this.type,
    this.adresse,
    this.categorie,
    required this.bankingAccounts,
    this.clientModel,
  });

  factory ContactDtoModel.fromJson(Map<String, dynamic> json) {
    List<BankingAccountDto> accounts = [];

    if (json['bankingAccounts'] != null) {
      accounts = (json['bankingAccounts'] as List)
          .map((account) => BankingAccountDto.fromJson(account))
          .toList();
    }

    return ContactDtoModel(
      id: json['id'],
      nom: json['nom'] ?? '',
      type: json['type'] ?? '',
      adresse: json['adresse'],
      categorie: json['categorie'],
      bankingAccounts: accounts,
      clientModel: json['clientModel'] != null
          ? ClientModel.fromJson(json['clientModel'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'type': type,
      'adresse': adresse,
      'categorie': categorie,
      'bankingAccounts': bankingAccounts.map((account) => account.toJson()).toList(),
      'clientModel': clientModel?.toJson(),
    };
  }

  // Create a copy with updated fields
  ContactDtoModel copyWith({
    int? id,
    String? nom,
    String? type,
    String? adresse,
    String? categorie,
    List<BankingAccountDto>? bankingAccounts,
    ClientModel? clientModel,
  }) {
    return ContactDtoModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      type: type ?? this.type,
      adresse: adresse ?? this.adresse,
      categorie: categorie ?? this.categorie,
      bankingAccounts: bankingAccounts ?? this.bankingAccounts,
      clientModel: clientModel ?? this.clientModel,
    );
  }

  @override
  String toString() {
    return 'ContactDtoModel{id: $id, nom: $nom, type: $type, adresse: $adresse, categorie: $categorie, bankingAccounts: ${bankingAccounts.length}, clientModel: $clientModel}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContactDtoModel &&
        other.id == id &&
        other.nom == nom &&
        other.type == type &&
        other.adresse == adresse &&
        other.categorie == categorie;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    nom.hashCode ^
    type.hashCode ^
    adresse.hashCode ^
    categorie.hashCode;
  }
}