import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactModel.dart';
import 'package:pfe_banking_system/screens/Contacts/service/ContactService.dart';

class ContactProvider extends ChangeNotifier{
  String? type ;
  String? nom;
  String? adresse;
  String? categorie;
  String? rib;
  String? intitule;
  ContactModel? contact;
  ContactService service = ContactService();

  void setType({required String type}){
    this.type = type;
    notifyListeners();
  }

  void setNom({required String nom}){
    this.nom = nom;
    notifyListeners();
  }

  void setAdresse({required String adresse}){
    this.adresse = adresse;
    notifyListeners();
  }

  void setCategorie({required String categorie}){
    this.categorie = categorie;
    notifyListeners();
  }

  void setRib({required String rib}){
    this.rib = rib;
    notifyListeners();
  }

  void setIntitule({required String intitule}){
    this.intitule = intitule;
    notifyListeners();
  }

  Future<bool> saveContact() async {
    if(type != null && nom != null && adresse != null && categorie != null && rib != null && intitule != null) {
      try {
        ContactModel contactModel = ContactModel(
            type: type!,
            nom: nom!,
            adresse: adresse!,
            categorie: categorie!,
            rib: rib!,
            intitule: intitule!);

        contact = await service.addContact(contactModel);

        if (contact != null) {
          print("Contact added successfully ${contact!.id}");
          notifyListeners();
          return true;
        } else {
          print("Failed to create contact - service returned null");
          return false;
        }
      } catch(e) {
        print("Error in adding Contact in Provider ${e}");
        contact = null;
        return false;
      }
    } else {
      print("Missing required fields for contact creation");
      return false;
    }
  }

  Future<bool> addContactToClient(String CId, String CLId) async {
    try {
      int clientId = int.parse(CLId);
      int contactId = int.parse(CId);

      print("Adding contact to client: ");
      final result = await service.addContactToClient(contactId, clientId);

      if(result) {
        print("Contact ${contactId} added to client ${clientId} successfully");
        return true;
      } else {
        print("Failed to add contact to client");
        return false;
      }
    } catch(e) {
      print("Error in adding Contact to client in Provider ${e}");
      return false;
    }
  }

  // Method to clear all data after successful operation
  void clearData() {
    type = null;
    nom = null;
    adresse = null;
    categorie = null;
    rib = null;
    intitule = null;
    contact = null;
    notifyListeners();
  }
}