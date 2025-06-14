class MaxBudgetModel{
  int? id ;
  String type;
  int MaximumBudget;

  MaxBudgetModel({
    this.id,
    required this.type,
    required this.MaximumBudget});

  factory MaxBudgetModel.fromJson(Map<String , dynamic> json){
    return MaxBudgetModel
      ( id: json["id"],
        type: json["type"],
        MaximumBudget: json["maximumBudget"]);
  }

  Map<String,dynamic> toJson()=>{
        'id': id,
        'type': type,
        'maximumBudget': MaximumBudget
  };
}