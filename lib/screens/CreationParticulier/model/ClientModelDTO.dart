class ClientModelDTO{
  int?  id ;
  String address ;
  String country;
  String sexe ;
  String dateOfBirth;
  String phoneNumber;
  String firstName;
  String lastName;
  String? dateOfCreation;
  String email;
  int age;

  ClientModelDTO({
    this.id,
    required this.address,
    required this.country,
    required this.sexe,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    this.dateOfCreation,
    required this.email,
    required this.age});

   factory ClientModelDTO.fromJson(Map<String , dynamic> json){
     return ClientModelDTO(
         id: json["id"],
         address: json["address"],
         country: json["country"],
         sexe: json["sexe"],
         dateOfBirth: json["dateOfBirth"],
         phoneNumber: json["phoneNumber"],
         firstName: json["firstName"],
         lastName: json["lastName"],
         dateOfCreation: json["dateOfCreation"],
         email: json["email"],
         age: json["age"]);
   }

   Map<String , dynamic> toJson()=>{
         'id': id,
         'address': address,
         'country': country,
         'sexe': sexe,
         'dateOfBirth': dateOfBirth,
         'phoneNumber': phoneNumber,
         'firstName': firstName,
         'lastName': lastName,
         'dateOfCreation': dateOfCreation,
         'email': email,
         'age': age
   };
}