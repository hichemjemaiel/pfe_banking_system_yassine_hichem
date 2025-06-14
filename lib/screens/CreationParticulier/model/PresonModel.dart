import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModel.dart';

class PersonModel extends ClientModel{
  final String address;
  final String country;
  final String sexe;
  final String dateOfBirth;
  final String phoneNumber;
  final String firstName;
  final String lastName;
  final int age;


  PersonModel({
    int? id,
    required String email,
    required String role,
    required this.address,
    required this.country,
    required this.sexe,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.age,}) : super(id : id , email : email ,role :role );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json["id"],
      email: json["email"],
      role: json["role"],
      address: json["address"],
      country: json["country"],
      sexe: json["sexe"],
      dateOfBirth: json["dateOfBirth"],
      phoneNumber: json["phoneNumber"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      age: json["age"],
    );
  }
  @override
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'role': role,
    'address': address,
    'country': country,
    'sexe': sexe,
    'dateOfBirth': dateOfBirth,
    'phoneNumber': phoneNumber,
    'firstName': firstName,
    'lastName': lastName,
    'age': age,
  };
}