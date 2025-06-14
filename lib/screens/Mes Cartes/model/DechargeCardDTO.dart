class DechargeCardDTO {
  int? id;
  String? creditRib;  // Made nullable
  String? banque;     // Made nullable
  int? montant;       // Made nullable
  String? date;       // Made nullable
  String? time;       // Made nullable

  DechargeCardDTO({
    this.id,
    this.creditRib,
    this.banque,
    this.montant,
    this.date,
    this.time
  });

  factory DechargeCardDTO.fromJson(Map<String, dynamic> json) {
    return DechargeCardDTO(
        id: json["id"],
        creditRib: json["creditRib"],
        banque: json["banque"],
        montant: json["montant"],
        date: json["date"],
        time: json["time"]
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "creditRib": creditRib,
    "banque": banque,
    "montant": montant,
    "date": date,
    "time": time
  };
}