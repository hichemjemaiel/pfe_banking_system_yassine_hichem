class User{
  int? id;
  String email;
  String role;

  User({
    this.id,
    required this.email,
    required this.role});

  factory User.fromJson(Map<String , dynamic> json){
    return User(
        id: json["id"],
        email: json["email"],
        role: json["role"]);
  }

  Map<String , dynamic> toJson()=>{

        'id': id,
        'email': email,
        'role': role
  };
}