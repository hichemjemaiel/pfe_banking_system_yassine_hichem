import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/model/CardModel.dart';
import 'package:pfe_banking_system/screens/Depot/service/CardService.dart';

class CardProvider extends ChangeNotifier{
  String? type ;
  String? name;
  String? number;
  String? expirationDate;
  String? status;
  CardModel? card;
  List<CardModel> cards = [];
  bool isLoading = false;

  CardService service = CardService();

  void setType({required String type}){
    this.type = type ;
  }

  void setName({required String name}){
    this.name = name;
  }

  void setNumber({required String number}){
    this.number = number;
  }

  void setExpirationDate({required String expirationDate}){
    this.expirationDate = expirationDate;
  }

  void setStatus({required String status}){
    this.status = status;
  }

  void setLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> saveCard()async{
    try{
      setLoading(true);
      print("Adding Card :");
      CardModel cardModel = CardModel(
          type: type!,
          name: name!,
          number: number!,
          expirationDate: expirationDate!,
          client: null,
          balance: 0,
          status: status!
      );
      final result = await service.addCard(cardModel);
      if(result != null){
        card = result;
        // Add to local list
        cards.add(result);
        print("Card created successfully ${card?.id}");
        notifyListeners();
      }
    }catch(e){
      print("Error in adding Card in Provider ${e}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> addCardToClient(String  CAId, String CLId)async{
    int cardId = int.parse(CAId);
    int clientId = int.parse(CLId);
    try{
      setLoading(true);
      print("Addding card to client ");
      final result = await service.addCardToClient(cardId, clientId);
      if(result){
        print("Card ${cardId} added to Clinet ${clientId} successfully");
      }
    }catch(e){
      print("Error in adding Card to client in Provider ${e}");
    } finally {
      setLoading(false);
    }
  }

  Future<void> setCardStatus(int id)async{
    try{
      setLoading(true);
      print("Setting card status ");
      final result = await service.setCardStatus(id);
      if(result){
        print("Card status set Successfully");
        // Update local card status
        int index = cards.indexWhere((card) => card.id == id);
        if (index != -1) {
          cards[index].status = "Verrouille";
          notifyListeners();
        }
      }
    }catch(e){
      print("Error in setting card in provider ${e}");
    } finally {
      setLoading(false);
    }
  }

  // New delete method
  Future<bool> deleteCard(int id) async {
    try {
      setLoading(true);
      print("Deleting card with ID: ${id}");
      final result = await service.deleteCard(id);
      if (result) {
        print("Card ${id} deleted successfully");
        // Remove from local list
        cards.removeWhere((card) => card.id == id);
        notifyListeners();
        return true;
      } else {
        print("Failed to delete card ${id}");
        return false;
      }
    } catch (e) {
      print("Error in deleting card in provider ${e}");
      return false;
    } finally {
      setLoading(false);
    }
  }

  // Method to fetch all cards
  Future<void> fetchAllCards() async {
    try {
      setLoading(true);
      print("Fetching all cards");
      final result = await service.getAllCards();
      if (result != null) {
        cards = result;
        print("Fetched ${cards.length} cards successfully");
        notifyListeners();
      }
    } catch (e) {
      print("Error in fetching cards in provider ${e}");
    } finally {
      setLoading(false);
    }
  }

  // Method to get a specific card
  Future<CardModel?> fetchCard(int id) async {
    try {
      setLoading(true);
      print("Fetching card with ID: ${id}");
      final result = await service.getCard(id);
      if (result != null) {
        print("Card ${id} fetched successfully");
        return result;
      }
    } catch (e) {
      print("Error in fetching card in provider ${e}");
    } finally {
      setLoading(false);
    }
    return null;
  }

  // Helper method to clear form data
  void clearForm() {
    type = null;
    name = null;
    number = null;
    expirationDate = null;
    status = null;
    card = null;
    notifyListeners();
  }
}