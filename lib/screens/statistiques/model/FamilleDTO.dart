class FamilleDTO{
  int? id ;
  int amount ;
  String type ;
  String name;
  String date;
  String time;

  FamilleDTO({
    this.id,
    required this.amount,
    required this.type,
    required this.name,
    required this.date,
    required this.time});

  factory FamilleDTO.fromJson(Map<String , dynamic> json){
    return FamilleDTO(
        id: json["id"],
        amount: json["amount"],
        type: json["type"],
        name: json["name"],
        date: json["date"],
        time: json["time"]);
  }

  Map<String , dynamic> toJson()=>{

    'id': id,
    'amount': amount,
    'type': type,
    'name': name,
    'date': date,
    'time': time
  };
}