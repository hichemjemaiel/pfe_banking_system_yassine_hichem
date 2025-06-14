class AgencyModel{
  final int? id ;
  final String city;
  final String phoneNumber;
  final String address;
  final String email;

  AgencyModel({
    this.id,
    required this.city,
    required this.phoneNumber,
    required this.address,
    required this.email});

  factory AgencyModel.fromJson(Map<String , dynamic> json){
    return AgencyModel
      ( id: json["id"],
        city: json["city"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        email: json["email"]);
  }

  Map<String , dynamic> toJson()=>{
    'id':id,
    'city':city,
    'phoneNumber':phoneNumber,
    'address':address,
    'email':email
  };
}