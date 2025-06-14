import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/model/RechargeCardDTO.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/service/RechargeCardDTOService.dart';


class RechargeCardDTOProvider extends ChangeNotifier{
  List<RechargeCardDTO> recharges =[];
  RechargeCardDTOService service = RechargeCardDTOService();

  Future<List<RechargeCardDTO>> getAllRecharges(int id)async{
    try{
      print("Fetching all recharges");
      recharges = await service.getAllRechargeCardDto(id);
      notifyListeners();
      return recharges;
    }catch(e){
      print("Error in fetching recharges ${e}");
      return [];
    }
  }
 }