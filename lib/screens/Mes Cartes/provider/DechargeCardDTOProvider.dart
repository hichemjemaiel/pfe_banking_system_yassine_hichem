import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/model/DechargeCardDTO.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/service/DechargeCardDTOService.dart';

class DechargeCardDTOProvider extends ChangeNotifier{

  List<DechargeCardDTO> decharges = [];

  DechargeCardDTOService service = DechargeCardDTOService();


  Future<List<DechargeCardDTO>> getAllDecharges(int id)async{
    try{
      print("Fetching all decharges ");
      decharges = await service.getAllDechargeCardDto(id);
      notifyListeners();
      return decharges;
    }catch(e){
      print("Error in fetching decharges in Provider ${e}");
      return [];
    }
  }

}