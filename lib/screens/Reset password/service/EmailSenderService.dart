import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Reset%20password/model/MailSenderRequest.dart';

class EmailSenderService{
  Dio dio = DioClient().dio;

  Future<bool> userExistence(String email)async{
    try{
      Response response = await dio.get("${EndPoints.userExistence}/${email}");
      if(response.statusCode == 200 || response.statusCode ==201){
        return true;
      }
      return false;
    }on DioException catch(e){
      if(e.response != null){
        String errorMessage = e.response?.data?.toString() ?? e.message ?? "Unknwon";
        if(errorMessage.contains("User with this email not found")){
          return false;
        }

      }
      throw Exception("Erreur de connexion");
    }catch(e){
      throw Exception("Une erreur inattendue s'est produite");
    }
  }

  Future<String?> sendMail(MailSenderRequest request)async{
    try{
      print("Sending email : ");
      Response response = await dio.post("${EndPoints.sendMail}",data: request.toJson());
      if(response.statusCode == 200 || response.statusCode ==201){
        print("Email sent successfully ${response.data}");
        return (response.data);
      }else{
        print("Error sending email ${response.data}");

      }
    }catch(e){
      print("Error in sending email Service ${e}");

    }
  }
}