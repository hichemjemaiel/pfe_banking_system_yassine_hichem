class ReclamationDTO{
  int? id ;
  String type ;
  String objet;
  String description;
  String date ;
  String time;
  String status;
  int client_Id;

  ReclamationDTO({
      this.id,
      required this.type,
      required this.objet,
      required this.description,
      required this.date,
      required this.time,
      required this.status,
      required this.client_Id});

  factory ReclamationDTO.fromJson(Map<String , dynamic> json){
    return ReclamationDTO(
        id:json["id"],
        type: json["type"],
        objet: json["objet"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        status: json["status"],
        client_Id: json["client_Id"]);
  }

  Map<String , dynamic> toJson()=>{
        'id': id,
        'type': type,
        'objet': objet,
        'description': description,
        'date': date,
        'time': time,
        'status': status,
        'client_Id': client_Id
  };
}