import 'package:flutter/cupertino.dart';

class studentModel {


  late String name;
  late String id;
  late String contact;
  late String profileImage;
  late String dateofBirth;
  late String dni;
  late String email;
  late String address;
  late String education;
  late String language;

  studentModel({
    required this.id,
    required this.name,
    required this.contact,
    required this.profileImage,
    required this.dateofBirth,
    required this.email,
    required this.dni,
    required this.address,
    required this.education,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "id": id,
      "contact": contact,
      "profileImage": profileImage,
      "dateofBirth": dateofBirth,
      "email":email ,
      "education": education,
      "language": language,
      "address": address,
      "dni": dni,

    };
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'contact': contact,
    'profileImage': profileImage,
    'dateofBirth': dateofBirth,
    'email': email,
    'education': education,
    'dni': dni,
    'address': address,
    'language': language,

  };

  studentModel.fromSnapshot(snapshot):
        id = snapshot.data()['id'],
        name = snapshot.data()['name'],
        contact = snapshot.data()['contact'],
        profileImage = snapshot.data()['profileImage'],
        email = snapshot.data()['email'],
        dateofBirth = snapshot.data()['dateofBirth'],
        language = snapshot.data()['language'],
        address = snapshot.data()['address'],
        education = snapshot.data()['education'],
        dni = snapshot.data()['dni'];
}
