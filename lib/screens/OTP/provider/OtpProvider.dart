import 'package:flutter/foundation.dart';
import 'package:pfe_banking_system/screens/OTP/service/OtpService.dart';

class OtpProvider extends ChangeNotifier{

  OtpService service = OtpService();
  String? otpCode ;
  Future<void> generateOtp(String phoneNumber)async{
    try{
      final result = await service.generateOTP(phoneNumber);
      if(result != null){
        otpCode = result;
        notifyListeners();
        print("otpCode sent successfully ${otpCode}");
      }
    }catch(e){
      print("Error in generation otp provider ${e}");
    }
  }
}