import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/SoinDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EpargneServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EspecesServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/FamilleServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/SoinServiceDTO.dart';

class SoinProviderDTO extends ChangeNotifier{
  List<SoinDTO> soins = [];
  SoinServiceDTO service =  SoinServiceDTO();


  Future<List<SoinDTO>> getAllSoins(int bankId)async{
    try{
      soins   = await service.findAllSoin(bankId);
      notifyListeners();
      return soins ;
    }catch(e){
      print("Error in fetching soins  in Provider");
      return [];
    }
  }
}