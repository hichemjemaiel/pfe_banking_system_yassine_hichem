import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Depot/model/CardModel.dart';

class CardService{
  Dio dio = DioClient().dio;

  Future<CardModel?> addCard(CardModel card)async{
    try{
      print("Adding card ${card.toJson()}");
      Response response = await dio.post("${EndPoints.addCard}",data: card.toJson());
      if(response.data != null && response.data is Map<String , dynamic>){
        print("Raw Api Response ${response.data}");
        return CardModel.fromJson(response.data);
      }else{
        print("Invalid Api resposne ${response.data}");
      }
    }catch(e){
      print("Error in adding Card in Service ${e}");
    }
    return null;
  }

  Future<bool> addCardToClient(int CAId, int CLId)async{
    try{
      print("Passing Card ${CAId} to clinet ${CLId}");
      Response response = await dio.post("${EndPoints.addCardToClient}/${CAId}/${CLId}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("Card ${CAId} added successfully to client ${CLId} ");
        return true;
      }else{
        print("Error in adding Card to client ");
        return false;
      }
    }catch(e){
      print("Error in adding Card to Client in Service ${e}");
      return false;
    }
  }

  Future<bool> setCardStatus(int id)async{
    try{
      print("Setting card status");
      Response response = await dio.post("${EndPoints.setCardStatus}/${id}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("Status card set sucessfully");
        return true;
      }else{
        print("Error in setting card status");
        return false;
      }
    }catch(e){
      print("Error in setting Card Status in Service ${e}");
      return false;
    }
  }

  // New delete method
  Future<bool> deleteCard(int id)async{
    try{
      print("Deleting card with ID: ${id}");
      Response response = await dio.delete("${EndPoints.deleteCard}/${id}");
      if(response.statusCode == 200 || response.statusCode == 204){
        print("Card ${id} deleted successfully");
        return true;
      }else{
        print("Error in deleting card. Status code: ${response.statusCode}");
        return false;
      }
    }catch(e){
      print("Error in deleting Card in Service ${e}");
      return false;
    }
  }

  // Optional: Get all cards method using existing endpoint
  Future<List<CardModel>?> getAllCards()async{
    try{
      print("Fetching all cards");
      Response response = await dio.get("${EndPoints.getAllCards}");
      if(response.data != null && response.data is List){
        print("Raw Api Response ${response.data}");
        List<CardModel> cards = (response.data as List)
            .map((cardJson) => CardModel.fromJson(cardJson))
            .toList();
        return cards;
      }else{
        print("Invalid Api response ${response.data}");
      }
    }catch(e){
      print("Error in fetching Cards in Service ${e}");
    }
    return null;
  }

  // Optional: Get single card method
  Future<CardModel?> getCard(int id)async{
    try{
      print("Fetching card with ID: ${id}");
      Response response = await dio.get("${EndPoints.getCardById}/${id}");
      if(response.data != null && response.data is Map<String , dynamic>){
        print("Raw Api Response ${response.data}");
        return CardModel.fromJson(response.data);
      }else{
        print("Invalid Api response ${response.data}");
      }
    }catch(e){
      print("Error in fetching Card in Service ${e}");
    }
    return null;
  }
}