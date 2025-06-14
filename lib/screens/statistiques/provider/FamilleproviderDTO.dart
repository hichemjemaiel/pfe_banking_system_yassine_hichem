import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EpargneServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EspecesServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/FamilleServiceDTO.dart';

class FamilleProviderDTO extends ChangeNotifier{
  List<FamilleDTO> familles = [];
  FamilleServiceDTO service =  FamilleServiceDTO();


  Future<List<FamilleDTO>> getAllEpargens(int bankId)async{
    try{
      familles   = await service.findAllFamille(bankId);
      notifyListeners();
      return familles  ;
    }catch(e){
      print("Error in fetching especes  in Provider");
      return [];
    }
  }
}