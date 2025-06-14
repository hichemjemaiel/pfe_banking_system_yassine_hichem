import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Reclamations/Model/ReclamationDTO.dart';

class ReclamationDtoService{
  Dio dio = DioClient().dio;

  Future<List<ReclamationDTO>> getAllReclamationForClient(int Id)async{
    try{
      print("Fetching Reclamation for client : ");
      Response response = await dio.get("${EndPoints.findAllReclamtionForClient}/${Id}");
      return (response.data as List).map((json) => ReclamationDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching reclamation ${e}");
      return [];
    }
  }
}