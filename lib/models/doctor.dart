import 'package:doctor_me/utils/db_helper.dart';
import 'package:flutter/material.dart';

class Doctor with ChangeNotifier {
  final String id;
  final String name;
  final String contact;
  final String specialization;
  final int rating;
  final int consultationFee;
  final String imageUrl;
  final String description;
  String? location;
  bool isFavourite;
  final String password;

  Doctor(
      {required this.id,
      required this.name,
      required this.contact,
      required this.specialization,
      required this.rating,
      required this.consultationFee,
      required this.imageUrl,
      required this.description,
      required this.password,
      this.isFavourite = false,
      this.location = ''});

  void toggleFavourite() {
    isFavourite = !isFavourite;
    DBHelper.toggleFavourite(this);
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'specialization': specialization,
      'rating': rating,
      'consultationFee': consultationFee,
      'imageUrl': imageUrl,
      'description': description,
      'location': location,
      'isFavourite': isFavourite ? 1 : 0,
      'password': password,
    };
  }

  static Doctor fromMap(Map<String, dynamic> map) {
    return Doctor(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      specialization: map['specialization'],
      rating: map['rating'] ?? 4,
      consultationFee: map['consultationFee'],
      imageUrl: map['imageUrl'] ??
          'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000',
      description: map['description'],
      password: map['password'],
      isFavourite: map['isFavourite'] == 1 ? true : false,
      location: map['location'] ?? '',
    );
  }
}
