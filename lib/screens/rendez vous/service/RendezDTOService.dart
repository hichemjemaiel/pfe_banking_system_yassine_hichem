import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/model/RendezDTO.dart';

class RendezDtoService{
  Dio dio = DioClient().dio;

  Future<List<RendezDTO>> getAllRendezVousForClient(int Id)async{
    try{
      print("Fetching All Rendez Vous for a clinet : ");
      Response response = await dio.get("${EndPoints.findAllRendezVousForClient}/${Id}");
      return (response.data as List).map((json) => RendezDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in Rendez vous fetching service ${e}");
      return [];
    }
  }
}