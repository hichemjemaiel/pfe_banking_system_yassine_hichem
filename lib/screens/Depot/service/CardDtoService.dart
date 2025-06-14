import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Depot/model/CardDto.dart';

class CardDtoService{
  Dio dio = DioClient().dio;

  Future<List<CardDtoModel>> getAllCardsToClient(int Id)async{
    try{
      print("fetching all cards");
      Response response = await dio.get("${EndPoints.getAllCards}/${Id}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("Successfull fetching");
        return (response.data as List).map((json) => CardDtoModel.fromJson(json)).toList();
      }else{
        return [];
      }
      
    }catch(e){
      print("Error in fetching cards dto in Service ${e}");
      return [];
    }
  }

  Future<List<CardDtoModel>> getAllCardsToClientActive(int Id)async{
    try{
      print("fetching all cards");
      Response response = await dio.get("${EndPoints.getAllCardsDtoForClientActive}/${Id}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("Successfull fetching");
        return (response.data as List).map((json) => CardDtoModel.fromJson(json)).toList();
      }else{
        return [];
      }

    }catch(e){
      print("Error in fetching cards dto in Service ${e}");
      return [];
    }
  }

}