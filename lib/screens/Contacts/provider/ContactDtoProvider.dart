// Updated ContactDtoProvider.dart with Delete and Update operations
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactDtoModel.dart';
import 'package:pfe_banking_system/screens/Contacts/service/ContactService.dart';

class ContactDtoProvider extends ChangeNotifier {
  List<ContactDtoModel>? contacts;
  ContactDtoModel? selectedContact;
  bool isLoading = false;
  String? errorMessage;

  ContactService contactService = ContactService();

  // Get all contacts for a client
  Future<void> getAllContactsForClient(int clientId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      print("ContactDtoProvider: Getting contacts for client $clientId");

      final result = await contactService.getAllContactsForClient(clientId);

      if (result != null) {
        contacts = result;
        print("ContactDtoProvider: Successfully loaded ${contacts!.length} contacts");
      } else {
        contacts = [];
        errorMessage = "Failed to load contacts";
        print("ContactDtoProvider: Failed to load contacts");
      }
    } catch (e) {
      contacts = [];
      errorMessage = "Error loading contacts: $e";
      print("ContactDtoProvider: Error loading contacts: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Delete a contact
  Future<bool> deleteContact(int contactId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      print("ContactDtoProvider: Deleting contact $contactId");

      bool success = await contactService.deleteContact(contactId);

      if (success) {
        // Remove the contact from the local list
        if (contacts != null) {
          contacts!.removeWhere((contact) => contact.id == contactId);
        }
        print("ContactDtoProvider: Contact $contactId deleted successfully");
        notifyListeners();
        return true;
      } else {
        errorMessage = "Failed to delete contact";
        print("ContactDtoProvider: Failed to delete contact $contactId");
        return false;
      }
    } catch (e) {
      errorMessage = "Error deleting contact: $e";
      print("ContactDtoProvider: Error deleting contact: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Update a contact
  Future<bool> updateContact(int contactId, ContactDtoModel updatedContact) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      print("ContactDtoProvider: Updating contact $contactId");

      bool success = await contactService.updateContact(contactId, updatedContact);

      if (success) {
        // Update the contact in the local list
        if (contacts != null) {
          int index = contacts!.indexWhere((contact) => contact.id == contactId);
          if (index != -1) {
            contacts![index] = updatedContact;
          }
        }

        // Update selected contact if it's the same
        if (selectedContact?.id == contactId) {
          selectedContact = updatedContact;
        }

        print("ContactDtoProvider: Contact $contactId updated successfully");
        notifyListeners();
        return true;
      } else {
        errorMessage = "Failed to update contact";
        print("ContactDtoProvider: Failed to update contact $contactId");
        return false;
      }
    } catch (e) {
      errorMessage = "Error updating contact: $e";
      print("ContactDtoProvider: Error updating contact: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Get a specific contact by ID
  ContactDtoModel? getContactById(int contactId) {
    if (contacts != null) {
      try {
        return contacts!.firstWhere((contact) => contact.id == contactId);
      } catch (e) {
        print("ContactDtoProvider: Contact with ID $contactId not found");
        return null;
      }
    }
    return null;
  }

  // Set selected contact
  void setSelectedContact(ContactDtoModel contact) {
    selectedContact = contact;
    notifyListeners();
  }

  // Clear selected contact
  void clearSelectedContact() {
    selectedContact = null;
    notifyListeners();
  }

  // Search contacts by name
  List<ContactDtoModel> searchContacts(String query) {
    if (contacts == null || query.isEmpty) {
      return contacts ?? [];
    }

    return contacts!
        .where((contact) =>
    contact.nom.toLowerCase().contains(query.toLowerCase()) ||
        contact.type.toLowerCase().contains(query.toLowerCase()) ||
        (contact.categorie?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();
  }

  // Filter contacts by category
  List<ContactDtoModel> filterContactsByCategory(String category) {
    if (contacts == null) {
      return [];
    }

    return contacts!
        .where((contact) => contact.categorie == category)
        .toList();
  }

  // Filter contacts by type
  List<ContactDtoModel> filterContactsByType(String type) {
    if (contacts == null) {
      return [];
    }

    return contacts!
        .where((contact) => contact.type == type)
        .toList();
  }

  // Get contact categories
  List<String> getAvailableCategories() {
    if (contacts == null) {
      return [];
    }

    Set<String> categories = contacts!
        .where((contact) => contact.categorie != null)
        .map((contact) => contact.categorie!)
        .toSet();

    return categories.toList();
  }

  // Get contact statistics
  Map<String, int> getContactStatistics() {
    if (contacts == null) {
      return {};
    }

    Map<String, int> stats = {
      'total': contacts!.length,
      'professional': 0,
      'personal': 0,
    };

    for (var contact in contacts!) {
      if (contact.type.toLowerCase() == 'professionnel') {
        stats['professional'] = (stats['professional'] ?? 0) + 1;
      } else {
        stats['personal'] = (stats['personal'] ?? 0) + 1;
      }
    }

    return stats;
  }

  // Clear error message
  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  // Refresh contacts (reload from server)
  Future<void> refreshContacts(int clientId) async {
    await getAllContactsForClient(clientId);
  }

  // Clear all data
  void clearData() {
    contacts = null;
    selectedContact = null;
    errorMessage = null;
    isLoading = false;
    notifyListeners();
  }
}