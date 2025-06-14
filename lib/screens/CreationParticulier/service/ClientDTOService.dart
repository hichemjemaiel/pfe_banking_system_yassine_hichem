import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class ClientDTOService{
  Dio dio = DioClient().dio;
  
  Future<List<ClientModelDTO>> getAllClients()async{
    try{
      print("Fetching All clients Dto");
      Response response = await dio.get("${EndPoints.getAllClientDtos}");
      print("Fetched clients ${response.data}");
      return (response.data as List).map((json) => ClientModelDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in Client Dto Service ${e}");
      return [];
    }
  }

  Future<ClientModelDTO?> getClient(int Id)async{
    try{
      print("Fetched Client Dto");
      Response response = await dio.get("${EndPoints.getAllClientDtos}/${Id}");
      print("RAW response API ${response.data}");
      return ClientModelDTO.fromJson(response.data);
    }catch(e){
      print("Error in Client Dto Service ${e}");

    }
  }
  
  Future<ClientModelDTO?> getClientByEmail(String email)async{
    try{
      Response response = await dio.get("${EndPoints.findClientDtoByEmail}/${email}");
      return ClientModelDTO.fromJson(response.data);
    }catch(e){
      print("Error in fetching Client dto by mail in Service ${e}");
    }
  }
}