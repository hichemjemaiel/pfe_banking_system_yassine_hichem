import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EpargneServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EspecesServiceDTO.dart';

class EspecesProviderDTO extends ChangeNotifier{
  List<EspecesDTO> especes = [];
  EspecesServiceDTO service =  EspecesServiceDTO();


  Future<List<EspecesDTO>> getAllEpargens(int bankId)async{
    try{
      especes  = await service.findAllEspeces(bankId);
      notifyListeners();
      return especes ;
    }catch(e){
      print("Error in fetching especes  in Provider");
      return [];
    }
  }
}