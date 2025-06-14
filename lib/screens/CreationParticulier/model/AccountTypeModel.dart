class AccountTypeModel{
  final int? id;

  AccountTypeModel({this.id});

  factory AccountTypeModel.fromJson(Map<String , dynamic> json){
    return AccountTypeModel(
      id: json["id"]
    );
  }
  Map<String , dynamic> toJson()=>{
    'id':id
  };
}