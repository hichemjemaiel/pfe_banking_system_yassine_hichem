import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EpargneServiceDTO.dart';

class EpargneProviderDTO extends ChangeNotifier{
  List<EpargneDTO> epargnes = [];
  EpargneServiceDTO service = EpargneServiceDTO();


  Future<List<EpargneDTO>> getAllEpargens(int bankId)async{
    try{
      epargnes = await service.findAllEpargne(bankId);
      notifyListeners();
      return epargnes;
    }catch(e){
      print("Error in fetching Epargne in Provider");
      return [];
    }
  }
}