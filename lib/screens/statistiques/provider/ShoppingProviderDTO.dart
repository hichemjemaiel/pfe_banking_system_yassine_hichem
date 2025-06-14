import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EpargneServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EspecesServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/FamilleServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingServiceDTO.dart';

class ShoppingProviderDTO extends ChangeNotifier{
  List<ShoppingDTO> shoppings = [];
  ShoppingServiceDTO service =  ShoppingServiceDTO();


  Future<List<ShoppingDTO>> getAllShoppings(int bankId)async{
    try{
      shoppings   = await service.findAllShopping(bankId);
      notifyListeners();
      return shoppings ;
    }catch(e){
      print("Error in fetching shoppings  in Provider");
      return [];
    }
  }
}