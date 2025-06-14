class BankingAccountDTOModel{
  final int? id;
  final String RIB;
  final double balance;
  final String type;
  final double overDraftAmount;
  final bool checkbook;
  final String? pack;
  final String? status;
  final int? agency_Id;
  final int? client_Id;
  BankingAccountDTOModel({
    this.id,
    required this.RIB,
    required this.balance,
    required this.type,
    required this.overDraftAmount,
    required this.checkbook,
     this.pack,
     this.status,
     this.agency_Id,
     this.client_Id
  });

  factory BankingAccountDTOModel.fromJson(Map<String , dynamic> json){
    return BankingAccountDTOModel
      ( id: json["id"],
        RIB: json["rib"] ?? json["RIB"],
        balance: json["balance"],
        type: json["type"],
        overDraftAmount: json["overDraftAmount"],
        checkbook: json["checkbook"],
        pack: json["pack"],
       status: json["status"],
      agency_Id: json["agency_Id"],
      client_Id: json[" client_Id"]
    );
  }

  Map<String , dynamic> toJson()=>{
        'id':id,
        'RIB': RIB,
        'balance': balance,
        'type': type,
        'overDraftAmount': overDraftAmount,
        'checkbook': checkbook,
        'pack':pack,
        'status':status,
        'agencyId':agency_Id,
        'client_Id':client_Id
  };
}