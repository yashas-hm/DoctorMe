import 'package:doctor_me/models/patient.dart';
import 'package:doctor_me/utils/db_helper.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class Patients with ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patient => [..._patients];

  Patients() {
    getData();
  }

  void createDatabase() async {
    for (var i = 0; i < 10; i++) {
      DBHelper.insertPatient(
        Patient(
          id: '${i + 1}',
          address: 'Nehrunagar, Ahmedabad',
          name: 'Lorem Ipsum',
          contact: '5496321965',
          symptoms: 'Cough\nChest Pain\nRunning Nose',
          additionalNotes: 'Happening since 3 days',
          imageUrl:
          'https://www.nicepng.com/png/detail/100-1007094_patient-on-gurney-cartoon.png',
          password: '1234',
        ),
      );
    }

    await getData();
  }

  Patient getPatientById(String id) {
    return _patients.firstWhere((element) => element.id == id);
  }

  void addPatient(Patient patient) {
    _patients.add(patient);
    notifyListeners();
    DBHelper.insertPatient(patient);
  }

  Future<void> getData() async {
    final data = await DBHelper.getPatientData();
    _patients = data.map((e) => Patient.fromMap(e)).toList();
    notifyListeners();
  }

  // List<Patient> byLocation(double lat, double long){
  //   final dummy = [..._patients];
  //   dummy.sort((a, b) {
  //     final loc1 = Utils.locationFromString(a.location!);
  //     final loc2 = Utils.locationFromString(b.location!);
  //     final dist1 = Utils.distanceFromUser(lat, long, loc1[0], loc1[1]);
  //     final dist2 = Utils.distanceFromUser(lat, long, loc2[0], loc2[1]);
  //     return dist1.compareTo(dist2);
  //   });
  //   return dummy;
  // }
}
