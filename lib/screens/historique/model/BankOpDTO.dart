class BankOpDTO{
  int? id ;
  String type ;
  int montant ;
  String date ;
  String status ;
  String? senderRIB;
  String? receiverRIB;
  String?  namecreditnum;
  int? bankId;
  int? operateurId;
  String? operateurName;

  BankOpDTO({
      this.id,
      required this.type,
      required this.montant,
      required this.date,
      required this.status,
        this.senderRIB,
       this.receiverRIB,
       this.namecreditnum,
       this.bankId,
       this.operateurId,
       this.operateurName
  });

  factory BankOpDTO.fromJson(Map<String , dynamic> json){
    return BankOpDTO(
        id:json["id"],
        type: json["type"],
        montant: json["montant"],
        date: json["date"],
        status: json["status"],
        senderRIB: json["senderRIB"],
        receiverRIB: json["receiverRIB"],
        namecreditnum : json["namecreditnum"],
        bankId: json["bankId"],
        operateurId: json["operateurId"],
        operateurName: json["operateurName"]
    );
  }

  Map<String , dynamic> toJson()=>{
        'id':id,
        'type': type,
        'montant': montant,
        'date': date,
        'status': status,
        'senderRIB': senderRIB,
        'receiverRIB': receiverRIB,
        'namecreditnum':namecreditnum,
        'bankId' : bankId,
        'operateurId':operateurId,
        'operateurName':operateurName
  };
}