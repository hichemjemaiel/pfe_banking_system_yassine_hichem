class RechargeCardDTO{
  int? id ;
  String debitRib;
  String banque;
  String nom ;
  int montant;
  String date ;
  String time ;

  RechargeCardDTO({
    this.id,
    required this.debitRib,
    required this.banque,
    required this.nom,
    required this.montant,
    required this.date,
    required this.time,
  });

  factory RechargeCardDTO.fromJson(Map<String , dynamic> json){
    return RechargeCardDTO(
        id: json["id"],
        debitRib: json["debitRib"],
        banque: json["banque"],
        nom: json["nom"],
        montant: json["montant"],
        date: json["date"],
        time: json["time"]
    );
  }

  Map<String , dynamic> toJson()=>{
        'id': id,
        'debitRib': debitRib,
        'banque': banque,
        'nom': nom,
        'montant': montant,
        'date': date,
        'time' : time
  };
 }