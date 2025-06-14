  import 'package:dio/dio.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/model/PresonModel.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

  class PersonService{
    Dio dio = DioClient().dio;

    Future<bool> verifyEmailExistence(String email) async {
      try {
        Response response = await dio.post("${EndPoints.verifyEmailExistence}/$email");
        if (response.statusCode == 200 || response.statusCode == 201) {
          return true; // Email is available (doesn't exist)
        }
        return false;
      } on DioException catch (e) {
        if (e.response != null) {
          String errorMessage = e.response?.data?.toString() ?? e.message ?? "Unknown error";
          if (errorMessage.contains("email") && errorMessage.contains("already exists")) {
            return false; // Email already exists
          }
        }
        // For other errors, rethrow
        throw Exception("Erreur de connexion. Vérifier votre connexion internet");
      } catch (e) {
        throw Exception("Une erreur inattendue s'est produite");
      }
    }


    Future<bool> verifyPhoneExistence(String phone) async {
      try {
        // Fixed the endpoint path - it should match your controller
        Response response = await dio.post("${EndPoints.verifyPhoneExitence}/${phone}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          return true; // Phone is available (doesn't exist)
        }
        return false;
      } on DioException catch (e) {
        if (e.response != null) {
          String errorMessage = e.response?.data?.toString() ?? e.message ?? "Unknown error";
          if (errorMessage.contains("phone") && errorMessage.contains("already exists")) {
            return false; // Phone already exists
          }
        }
        throw Exception("Erreur de connexion. Vérifier votre connexion internet");
      } catch (e) {
        throw Exception("Une erreur inattendue s'est produite");
      }
    }
    Future<PersonModel?> addPerson(PersonModel person)async{
      try{
        print("passing person ${person.toJson()}");
        Response response = await dio.post(EndPoints.addPerson,data: person.toJson());
        if(response.data != null && response.data is Map<String , dynamic>){
          print("RAW Api response : ${response.data}");
          return PersonModel.fromJson(response.data);
        }else{
          print("Invalid data format ${response.data}");
          return null;

      }
      }catch(e){
        print("Error creating Person${e}");

      }
    }


    Future<PersonModel?> updatePerson(String email , PersonModel person)async{
      try{
        print("Updating person info  : ");
        Response response = await dio.put("${EndPoints.updatePersonByEmail}/${email}",data:person.toJson() );
        if(response.statusCode == 200 || response.statusCode ==201){
          print("Person updated successfully");
          return PersonModel.fromJson(response.data);
        }
      }catch(e){
        print("Error in updating person in Service");
      }
    }
  }