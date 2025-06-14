import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Reclamations/Model/ReclamationDTO.dart';
import 'package:pfe_banking_system/screens/Reclamations/service/ReclamationDtoService.dart';

class ReclamationDtoProvider extends ChangeNotifier{
  ReclamationDtoService service = ReclamationDtoService();
  List<ReclamationDTO> reclamations = [];

  Future<List<ReclamationDTO>> getAllReclamtionForClient(int Id)async{
    try{
      print("Fetching Reclamation for client : ");
      reclamations = await service.getAllReclamationForClient(Id);
      notifyListeners();
      return reclamations;
    }catch(e){
      print("Error in fetching Reclamation in Provider ${e}");
      return [];
    }
  }
}