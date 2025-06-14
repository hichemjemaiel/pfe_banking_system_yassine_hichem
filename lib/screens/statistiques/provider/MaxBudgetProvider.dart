import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/MaxBudgetModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/MaxBudgetService.dart';

class MaxBudgetProvider extends ChangeNotifier{
    MaxBudgetService service = MaxBudgetService();
    String? type ;
    int? maximumBudget;

    

    void setType({
      required String type
}){
      this.type = type;
      notifyListeners();
    }

    void setMaximumBudget({
      required int maximumBudget
}){
      this.maximumBudget = maximumBudget;
      notifyListeners();
    }

    Future<void> saveMaxBudget()async{
      if(type != null && maximumBudget != null){
        try{
          MaxBudgetModel maxBudgetModel = MaxBudgetModel(
              type: type!,
              MaximumBudget: maximumBudget!);
           await service.addMaxBudgetModel(maxBudgetModel);

          print("MaxBudgetModel Added successfully ");
        }catch(e){
          print("Error in adding MaxBudgetModel");
        }
      }
    }

    Future<void> updateMaxBudget(String type ,int amount)async{
        try{
          print("Updating Max budget");
          await service.updateMaxBudgetModel(type, amount);
          print("Amount updated successfully");
        }catch(e){
          print("Error updating Max Budget ${e}");
        }
    }

    Future<MaxBudgetModel?> getMaxBudgetByType(String type)async{
      try{
        print("Fetching Max budget by type : ");
        final result = await service.getMaxBudgetByType(type);
        if(result != null){

          return result ;
        }else{
          print("Error in fetching Max budget provider");
          return null;
        }
      }catch(e){
        print("Error in fetching Max Budget provider ${e}");
        return null;
      }
    }
}