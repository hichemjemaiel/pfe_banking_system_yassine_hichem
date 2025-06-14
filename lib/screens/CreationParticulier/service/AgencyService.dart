import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class AgencyService{
  Dio dio = DioClient().dio;

  Future<List<AgencyModel>> getAllAgencies()async{
    try{
      Response response = await dio.get(EndPoints.getAllAgencies);
      return (response.data as List).map((json) => AgencyModel.fromJson(json)).toList();
    }catch(e){
      return [];
    }
  }
}