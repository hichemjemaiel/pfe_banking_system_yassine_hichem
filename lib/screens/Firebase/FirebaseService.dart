import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

Dio dio = DioClient().dio;

Future<void> sendTokenToBackend(String userId)async{
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  if(fcmToken != null){
    try{
      Response response = await dio.post("${EndPoints.sendTokenToBackend}",data: {
        "userId":userId,
        "token":fcmToken,
      });
      print("Token sent successfully : ${response.statusCode}");
      print("${fcmToken}");
    }catch(e){
      print("Failed to send token : ${e}");
    }
  }
}