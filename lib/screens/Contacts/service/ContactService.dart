// Updated ContactService.dart with Delete and Update methods
import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactModel.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactDtoModel.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class ContactService {
  Dio dio = DioClient().dio;

  // Existing add contact method
  Future<ContactModel?> addContact(ContactModel contact) async {
    try {
      print("Adding Contact with data: ${contact.toJson()}");

      Response response = await dio.post(
        "${EndPoints.addContact}",
        data: contact.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print("Response status: ${response.statusCode}");
      print("Raw API response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          return ContactModel.fromJson(response.data);
        } else {
          print("Invalid API Response format: ${response.data}");
          return null;
        }
      } else {
        print("API Error - Status: ${response.statusCode}, Data: ${response.data}");
        return null;
      }
    } on DioException catch (e) {
      print("DioException in addContact: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Response status: ${e.response?.statusCode}");
      return null;
    } catch (e) {
      print("Unexpected error in addContact: ${e}");
      return null;
    }
  }

  // Existing add contact to client method
  Future<bool> addContactToClient(int CId, int CLId) async {
    try {
      print("Adding contact $CId to client $CLId");

      Response response = await dio.post(
        "${EndPoints.addContactToClient}/${CId}/${CLId}",
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print("AddContactToClient response status: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Contact ${CId} added successfully to client ${CLId}");
        return true;
      } else {
        print("Failed to add contact to client - Status: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      print("DioException in addContactToClient: ${e.message}");
      print("Response data: ${e.response?.data}");
      return false;
    } catch (e) {
      print("Unexpected error in addContactToClient: ${e}");
      return false;
    }
  }

  // NEW: Delete contact method
  Future<bool> deleteContact(int contactId) async {
    try {
      print("Deleting contact with ID: $contactId");

      Response response = await dio.delete(
        "${EndPoints.deleteContact}/$contactId",
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print("Delete contact response status: ${response.statusCode}");
      print("Delete contact response data: ${response.data}");

      if (response.statusCode == 200) {
        print("Contact $contactId deleted successfully");
        return true;
      } else {
        print("Failed to delete contact - Status: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      print("DioException in deleteContact: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Response status: ${e.response?.statusCode}");
      return false;
    } catch (e) {
      print("Unexpected error in deleteContact: $e");
      return false;
    }
  }

  // NEW: Update contact method
  Future<bool> updateContact(int contactId, ContactDtoModel updatedContact) async {
    try {
      print("Updating contact with ID: $contactId");
      print("Update data: ${updatedContact.toJson()}");

      Response response = await dio.put(
        "${EndPoints.updateContact}/$contactId",
        data: updatedContact.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print("Update contact response status: ${response.statusCode}");
      print("Update contact response data: ${response.data}");

      if (response.statusCode == 200) {
        print("Contact $contactId updated successfully");
        return true;
      } else {
        print("Failed to update contact - Status: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      print("DioException in updateContact: ${e.message}");
      print("Response data: ${e.response?.data}");
      print("Response status: ${e.response?.statusCode}");
      return false;
    } catch (e) {
      print("Unexpected error in updateContact: $e");
      return false;
    }
  }

  // NEW: Get all contacts for client (DTO)
  Future<List<ContactDtoModel>?> getAllContactsForClient(int clientId) async {
    try {
      print("Getting all contacts for client: $clientId");

      Response response = await dio.get(
        "${EndPoints.getAllContactForClient}/$clientId",
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print("Get contacts response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        if (response.data != null && response.data is List) {
          List<ContactDtoModel> contacts = (response.data as List)
              .map((contactJson) => ContactDtoModel.fromJson(contactJson))
              .toList();

          print("Successfully fetched ${contacts.length} contacts");
          return contacts;
        } else {
          print("Invalid response format for contacts list");
          return [];
        }
      } else {
        print("Failed to get contacts - Status: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      print("DioException in getAllContactsForClient: ${e.message}");
      print("Response data: ${e.response?.data}");
      return null;
    } catch (e) {
      print("Unexpected error in getAllContactsForClient: $e");
      return null;
    }
  }
}