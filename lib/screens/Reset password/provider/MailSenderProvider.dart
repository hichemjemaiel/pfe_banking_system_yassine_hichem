import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Reset%20password/model/MailSenderRequest.dart';
import 'package:pfe_banking_system/screens/Reset%20password/service/EmailSenderService.dart';

class MailSenderProvider extends ChangeNotifier{
  EmailSenderService service = EmailSenderService();
  String? otpCode;
  String? error;
  Future<bool> userExistence(String email)async{
    try{
      final result = await service.userExistence(email);
      if(result){
        return true;
      }else{
        return false;
      }
    }catch(e){
      error = e.toString();
      return false;
    }
  }
  Future<String?> sendMail(MailSenderRequest request)async{
    try{
      print("Sending email ");
      otpCode =  await service.sendMail(request);
      notifyListeners();
      return otpCode;
    }catch(e){
      print("Error in sending email provider ${e}");
    }
  }
}