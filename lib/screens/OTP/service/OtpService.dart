import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/OTP/model/SmsRequest.dart';

class OtpService{
  Dio dio = DioClient().dio;

  Future<void> sendSms(SmsRequest request)async{
    try{
       await dio.post("${EndPoints.sendSms}",data: request.toJson());
    }catch(e){
      print("Error in sending Message in OtpService ${e}");
    }
  }

  Future<String?> generateOTP(String phoneNumber)async{
    try{
      Response response = await dio.post("${EndPoints.generaOtpCode}/${phoneNumber}");
      return (response.data as String);
    }catch(e){
      print("Error in generating otp message ${e}");
    }
  }
}