import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/service/AgencyService.dart';

class AgencyProvider extends ChangeNotifier{
  AgencyService agencyService = AgencyService();
  List<AgencyModel> agencies =[];

  Future<List<AgencyModel>> getAllAgencies()async{
    try{
      agencies = await agencyService.getAllAgencies();
      notifyListeners();
      return agencies;

    }catch(e){
      print("Error");
      return [];
    }
  }
}