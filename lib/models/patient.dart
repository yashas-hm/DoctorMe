import 'package:flutter/material.dart';

class Patient with ChangeNotifier {
  final String id;
  final String address;
  final String name;
  final String contact;
  final String symptoms;
  final String additionalNotes;
  final String imageUrl;
  final String password;
  String? location;

  Patient({
    required this.id,
    required this.address,
    required this.name,
    required this.contact,
    required this.symptoms,
    required this.additionalNotes,
    required this.imageUrl,
    required this.password,
    this.location = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'contact': contact,
      'address': address,
      'symptoms': symptoms,
      'additionalNotes': additionalNotes,
      'imageUrl': imageUrl,
      'password': password,
      'location': location,
    };
  }

  static Patient fromMap(Map<String, dynamic> map) {
    return Patient(
      id: map['id'],
      name: map['name'],
      contact: map['contact'],
      address: map['address'],
      symptoms: map['symptoms'],
      additionalNotes: map['additionalNotes'],
      imageUrl: map['imageUrl'] ??
          'https://www.nicepng.com/png/detail/100-1007094_patient-on-gurney-cartoon.png',
      password: map['password'],
      location: map['location'] ?? '',
    );
  }
}
