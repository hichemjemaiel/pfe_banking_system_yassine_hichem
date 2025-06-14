import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/model/OperateurModel.dart';
import 'package:pfe_banking_system/screens/Depot/service/OperateurService.dart';

class OperateurProvider extends ChangeNotifier{
  OperateurService operateurService = OperateurService();
  List<OperateurModel> operateurs = [];
  OperateurModel? operateurModel;
  Future<List<OperateurModel>> getAllOperatuers()async{
    try{
      operateurs = await operateurService.getAllOperateurs();
      notifyListeners();
      return operateurs;
    }catch(e){
      print("Error in OperateurProvider ${e}");
      return [];
    }

  }

  Future<OperateurModel?> getOperateur(int? operateurId)async{
    try{
      operateurModel = await operateurService.getOperateurModel(operateurId!);
      notifyListeners();
      return operateurModel;
    }catch(e){
      print("Error in provider operateur model");
    }
  }

}