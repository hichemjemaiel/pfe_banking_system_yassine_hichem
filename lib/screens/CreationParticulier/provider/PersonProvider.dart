import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/service/PersonService.dart';

import '../model/PresonModel.dart';

class PersonProvider extends ChangeNotifier {
  PersonService personService = PersonService();
  PersonModel? savedPerson;
  String? nom;
  String? prenom;
  int? age;
  String? number;
  String? email;
  String? jour;
  String? mois;
  String? annee;
  String? selectedCountry;
  String? gender;
  String? address;
  String? ville;
  String? error;
  String? role;

  void setPersonInfo({
    required String nom,
    required String prenom,
    required int age,
    required String number,
    required String email,
    required String jour,
    required String mois,
    required String annee,
    required String selectedCountry,
    required String gender,
    String? role,
  }) {
    this.nom = nom;
    this.prenom = prenom;
    this.age = age;
    this.number = number;
    this.email = email;
    this.jour = jour;
    this.mois = mois;
    this.annee = annee;
    this.selectedCountry = selectedCountry;
    this.gender = gender;
    this.role = role ?? "USER";
    notifyListeners();
  }

  void setAddressInfo({
    required String ville
  }) {
    this.ville = ville;
    this.address = "$ville";
    notifyListeners();
  }

  Future<bool> validateEmail(String email)async{
    try{
      final emailExists = await personService.verifyEmailExistence(email);
      if(!emailExists){
        error = "email already exists";
        notifyListeners();
        return false;
      }
      return true;
    }catch(e){
      print("Error validating email ! ${e}");
      error = e.toString();
      return false;
    }
  }

  Future<bool> validatePhone(String phone)async{
    try{
      final phoneExists = await personService.verifyPhoneExistence(phone);
      if(!phoneExists){
        error = "phone already exists";
        return false;
      }
      return true;
    }catch(e){
      print("Error validating error ! ${e}");
      error = e.toString();
      return false;
    }
  }
  Future<void> savePerson() async {
    try{
      if (nom != null && prenom != null && age != null && number != null &&
          email != null && jour != null && mois != null && annee != null &&
          selectedCountry != null && gender != null && address != null) {
        PersonModel person = PersonModel(
            address: address!,
            country: selectedCountry!,
            sexe: gender!,
            dateOfBirth: "$jour-$mois-$annee",
            phoneNumber: number!,
            firstName: prenom!,
            lastName: nom!,
            age: age!,
            email: email!,
            role :role ?? "USER");
          final result = await personService.addPerson(person);
          if (result != null) {
            savedPerson = result;
            print("Person created with ID : ${result.id}");
          }

          notifyListeners();
        }
      } catch (e) {
        print("Error creating Person Account");
        error = e.toString();
        print("Error");
      }
    }

    Future<void> updatePerson(String email,PersonModel person)async{
      try{
        print("updating person info : ");
        final result = await personService.updatePerson(email, person);
        if(result != null){
          savedPerson = result;
          notifyListeners();
        }
      }catch(e){
        print("Error in updating person in Provider ${e}");
      }
    }
  }



