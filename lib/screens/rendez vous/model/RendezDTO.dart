class RendezDTO{
  int? id ;
  String date;
  String time ;
  String objet;
  String commentaire;
  String status;
  int clientId ;
  int agencyId;

  RendezDTO({
      this.id,
      required this.date,
      required this.time,
      required this.objet,
      required this.commentaire,
      required this.status,
      required this.clientId,
      required this.agencyId});

  factory RendezDTO.fromJson(Map<String ,dynamic> json){
    return RendezDTO(
        id: json["id"],
        date: json["date"],
        time: json["time"],
        objet: json["objet"],
        commentaire: json["commentaire"],
        status: json["status"],
        clientId:json["clientId"],
        agencyId: json["agencyId"]);
  }

  Map<String,dynamic> toJson()=>{
        'id': id,
        'date': date,
        'time': time,
        'objet': objet,
        'commentaire': commentaire,
        'status': status,
        'clientId': clientId,
        'agencyId': agencyId
  };
}