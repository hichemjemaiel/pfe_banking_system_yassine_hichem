class SmsRequest{
  String phoneNumber;
  String  message;

  SmsRequest({
    required this.phoneNumber,
    required this.message});

  factory SmsRequest.fromJson(Map<String , dynamic> json){
    return SmsRequest(
        phoneNumber: json["phoneNumber"],
        message: json["message"]);
  }

  Map<String , dynamic> toJson()=>{
        'phoneNumber': phoneNumber,
        'message': message
  };

}