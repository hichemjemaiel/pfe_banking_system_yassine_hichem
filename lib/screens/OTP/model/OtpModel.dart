class OtpModel{
  int? id ;
  String phoneNumber ;
  String otpCode;
  DateTime expirationTime;
  bool? isUsed;

  OtpModel({
    this.id,
    required this.phoneNumber,
    required this.otpCode,
    required this.expirationTime,
      this.isUsed});

  factory OtpModel.fromJson(Map<String , dynamic> json){
    return OtpModel(
        id: json["id"],
        phoneNumber: json["phoneNumber"],
        otpCode: json["otpCode"],
        expirationTime: DateTime.parse(json["expirationTime"]),
        isUsed:json["isUsed"] ?? false
    );

  }

  Map<String ,dynamic> toJson()=>{
        'id': id,
        'phoneNumber': phoneNumber,
        'otpCode': otpCode,
        'expirationTime': expirationTime,
        'isUsed' : isUsed
  };
}