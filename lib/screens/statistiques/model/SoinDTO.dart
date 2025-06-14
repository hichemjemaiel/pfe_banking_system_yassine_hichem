class SoinDTO{
  int? id ;
  int amount ;
  String type ;
  String name;
  String date;
  String time;

  SoinDTO({
    this.id,
    required this.amount,
    required this.type,
    required this.name,
    required this.date,
    required this.time});

  factory SoinDTO.fromJson(Map<String , dynamic> json){
    return SoinDTO(
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