import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/model/MoralPersonModel.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/service/MoralPersonService.dart';

class MoralPersonProvider extends ChangeNotifier {
  MoralPersonService moralPersonService = MoralPersonService();
  MoralPersonModel? Mperson;
  String? nom;
  String? prenom;
  String? gender;
  String? selectedCountry;
  String? number;
  String? email;
  String? jour;
  String? mois;
  String? annee;
  String? cJour;
  String? cMois;
  String? cAnnee;
  String? address;
  String? ville;
  String? error;
  String? role;
  void setPersonInfo({
    required String nom,
    required String prenom,
    required String selectedCountry,
    required String gender,
    required String number,
    required email,
    required jour,
    required mois,
    required annee,
    String? role
  }) {
    this.nom = nom;
    this.prenom = prenom;
    this.gender = gender;
    this.selectedCountry = selectedCountry;
    this.number = number;
    this.email = email;
    this.jour = jour;
    this.mois = mois;
    this.annee =annee;
    this.role = role ?? "USER";
    notifyListeners();
  }

  void setCreationDate({
    required String cJour,
    required String cMois,
    required String cAnnee
  }) {
    this.cJour = cJour;
    this.cMois = cMois;
    this.cAnnee = cAnnee;
    notifyListeners();
  }

  void setAddress({
    required String ville
  }) {
    this.ville = ville;
    this.address = ville;
    notifyListeners();
  }
  Future<bool> validateEmail(String email)async{
    try{
      final EmailExists = await moralPersonService.verifyEmailExistence(email);
      if(!EmailExists){
          error = "Email already exists";
          notifyListeners();
          return false;
      }
      return true;
    }catch(e){
      print("Error validating email ${e}");
      error = e.toString();
      return false;
    }
  }

  Future<bool> validatePhone(String phone) async{
    try{
      final PhoneExists= await moralPersonService.verifyPhoneExistence(phone);
      if(!PhoneExists){
        error = "phone already exists";
        notifyListeners();
        return false;
      }
      return true;
    }catch(e){
      print("Error in validating phone ${e}");
      error = e.toString();
      return false;
    }
  }
  Future<void> savePerson() async {
    try {
      if (
      nom != null && prenom != null && gender != null
          && selectedCountry != null && number != null
          && email != null && jour != null && mois != null
          && annee != null && cJour != null && cMois != null
          && cAnnee != null && address != null && ville != null) {
        MoralPersonModel moralPerson = MoralPersonModel(
            address: address!,
            country: selectedCountry!,
            sexe: gender!,
            dateOfBirth: "$jour-$mois-$annee",
            phoneNumber: number!,
            firstName: prenom!,
            lastName: nom!,
            dateOfCreation: "${cJour}-${cMois}-${cAnnee}",
            email: email!,
           role: role ?? "USER"
        );
        final result = await moralPersonService.addMoralPerson(moralPerson);
        if (result != null) {
          Mperson = result;
          print("Moral person created with ID : ${result.id}");
        }

        else{
          print("Moral person is null in the provider");
      }
        notifyListeners();
      }
    } catch (e) {
      print("Error in creating moral person Account");
      print("Error");
    }
  }
}