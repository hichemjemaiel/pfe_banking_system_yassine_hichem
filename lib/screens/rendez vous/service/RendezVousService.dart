import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/model/RendezVousModel.dart';

class RendezVousService{
  Dio dio = DioClient().dio;

  Future<RendezVousModel?> addRendezVous(RendezVousModel  rendezVousModel)async{
    try{
      print("Passing Rendez vous : ${rendezVousModel.toJson()}");
      Response response = await dio.post("${EndPoints.addRendezVous}",data: rendezVousModel.toJson());
      print("Raw Response Api : ${response.data}");
      if(response.data != null && response.data is Map<String , dynamic>){
        return RendezVousModel.fromJson(response.data);
      }else{
        print("Invalid Api Response ${response.data}");
      }
    }catch(e){
      print("Error in RendezVous Service ${e}");
    }
  }

  Future<bool> addRendezVousToClient(int Id , int CId )async{
    try{
      print("Passing Rendez vous ${Id} to Client ${CId}");
      Response response =  await dio.post("${EndPoints.addRendezVousToClient}/${Id}/${CId}");
      if(response.statusCode ==200 || response.statusMessage ==201){
        print("Rendez vous ${Id} passed successfully to client ${CId}");
        return true;
      }else{
        print("failed in passing client to rendez vous Service ");
        return false;
      }
    }catch(e){
      print("failed in passing client to rendez vous Service ${e}");
      return false;
    }
  }

  Future<bool> addRendezVousToAgency(int Id , int AId)async{
    try{
      print("Passing Rendez Vous ${Id} to agency${AId}");
      Response response = await dio.post("${EndPoints.addRendezVousToAgency}/${Id}/${AId}");
      if(response.statusCode == 200 || response.statusMessage ==201){
        print("Rendez vous ${Id} passed to Agency ${AId} successfully");
        return true;
      }else{
        "failed in passing agency to rendez vous Service";
        return false;
      }
    }catch(e){
      print("failed in passing agency to rendez vous Service ${e}");
      return false;
    }
  }
}