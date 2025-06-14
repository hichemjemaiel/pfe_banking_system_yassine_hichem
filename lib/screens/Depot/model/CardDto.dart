class CardDtoModel{
  final int? id;
  final String type;
  final String name ;
  final String number;
  final String expirationDate;
  final int balance;
  final String status;
  CardDtoModel({
    this.id,
    required this.type,
    required this.name,
    required this.number,
    required this.expirationDate,
    required this.balance,
    required this.status,
  });

  factory CardDtoModel.fromJson(Map<String,dynamic> json){
  return CardDtoModel(
       id: json["id"],
       type: json["type"],
      name: json["name"],
      number: json["number"],
      expirationDate: json["expirationDate"],
      balance:  json["balance"] is String ? int.parse(json["balance"]) : json["balance"],
      status: json["status"],
  );
  }

  Map<String,dynamic> toJson()=>{
        'id':id,
        'type': type,
        'name': name,
        'number': number,
        'expirationDate': expirationDate,
        'balance':balance,
        'status':status
  };
}