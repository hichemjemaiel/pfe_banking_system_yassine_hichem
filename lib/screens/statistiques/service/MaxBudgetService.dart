import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/statistiques/model/MaxBudgetModel.dart';

class MaxBudgetService{
  Dio dio = DioClient().dio;

  Future<void> addMaxBudgetModel(MaxBudgetModel maxBudget)async{
    try{
      print("Passing maxBudget ${maxBudget.toJson()}");
        await dio.post("${EndPoints.addMaxBudget}",data: maxBudget.toJson());
      print("Max budget added successfully");

    }catch(e){
      print("Error in adding MaxBudget ${e}");
    }
  }

  Future<void> updateMaxBudgetModel(String type , int amount)async{
    try{
      print("Updating maxBudget with amount${amount}");
      await dio.put("${EndPoints.updateMaxBudget}/${type}/${amount}");
      print("Max amount updated successfully");

    }catch(e){
      print("Error in updating MaxBudget ${e}");
    }
  }

  Future<MaxBudgetModel?> getMaxBudgetByType(String type)async{
    try{
      print("Fetching Max budget by type : ");
      Response response = await dio.get("${EndPoints.getMaxBudgetByType}/${type}");
      return MaxBudgetModel.fromJson(response.data);
    }catch(e){
      print("Error in fetching in Service max Budget${e}");
    }
  }

}