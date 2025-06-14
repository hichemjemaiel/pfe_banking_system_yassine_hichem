import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/model/CardDto.dart';
import 'package:pfe_banking_system/screens/Depot/service/CardDtoService.dart';

class CardDtoProvider extends ChangeNotifier{
  List<CardDtoModel> cards= [];
  List<CardDtoModel> Acards = [];
  CardDtoService cardService =CardDtoService();



  Future<List<CardDtoModel>> getAllCardsToClient(int Id)async{
    try{
      cards = await cardService.getAllCardsToClient(Id);
      notifyListeners();
      return cards;
    }catch(e){
      print("Error in fetching Card dto in provider ${e}");
      return [];
    }

  }

  Future<List<CardDtoModel>> getAllCardsToClientActive(int Id)async{
    try{
      Acards = await cardService.getAllCardsToClientActive(Id);
      notifyListeners();
      return Acards;
    }catch(e){
      print("Error in fetching Card dto in provider ${e}");
      return [];
    }

  }

}