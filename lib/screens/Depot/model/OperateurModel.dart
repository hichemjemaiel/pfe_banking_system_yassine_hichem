class OperateurModel{
  final int? id ;
  final String name;

  OperateurModel({this.id, required this.name});

  factory OperateurModel.fromJson(Map<String , dynamic> json){
    return OperateurModel(
        id:json["id"],
        name: json["name"]);
  }
  Map<String , dynamic> toJson()=>{
    'id':id,
    'name':name
  };
}