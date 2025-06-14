import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Reclamations/Model/ReclamationModel.dart';

class ReclamationService{
  Dio dio = DioClient().dio;

  Future<ReclamationModel?> addReclamation(ReclamationModel reclamation)async{
      try{
        print("Passing Reclamation ${reclamation.toJson()}");
        Response response = await dio.post("${EndPoints.addReclamation}",data: reclamation.toJson());
        print("Raw Api Resposne :${response.data}");
        if(response.data != null && response.data is Map<String , dynamic>){
          return ReclamationModel.fromJson(response.data);
        }
      }catch(e){
        print("Error in Creating Reclamation Service ${e}");

      }
  }

  Future<bool> addReclamationToClient(int Id , int CId)async{
    try{
      print("Passing Reclamation ${Id} to client ${CId}");
      Response response = await dio.post("${EndPoints.addReclamationToClient}/${Id}/${CId}");
      if(response.statusCode == 200 || response.statusCode ==201){
        print("Reclamation ${Id} added successfully to ${CId}");
        return true;
      }else{
        print("Error in adding Reclamation ${Id} to client ${CId}");
        return false;
      }
    }catch(e){
      print("Failed linking Reclamation to Client Service ${e}");
      return false;
    }
  }
}