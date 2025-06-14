import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactDtoModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class ContactDtoService{
  Dio dio = DioClient().dio;

  Future<List<ContactDtoModel>?> getAllContactsForClient(int CLId)async{
    try{
      print("fetching contacts : ");
      Response response = await dio.get("${EndPoints.getAllContactForClient}/${CLId}");
      return (response.data as List).map((json) => ContactDtoModel.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching contacts in Service ${e}");
      return [];
    }
  }

}