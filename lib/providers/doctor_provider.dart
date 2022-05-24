import 'dart:math';

import 'package:doctor_me/utils/db_helper.dart';
import 'package:doctor_me/utils/utils.dart';
import 'package:flutter/material.dart';

import '../models/doctor.dart';

class Doctors with ChangeNotifier {
  List<Doctor> _doctors = [];
  var isFavourite = false;

  List<Doctor> get favDoctors =>
      _doctors.where((element) => element.isFavourite).toList();

  List<Doctor> get doctor => [..._doctors];

  Doctors() {
    fetchData();
  }

  void createDatabase() async {
    List<String> specialization = [
      'Orthopedics',
      'Cardiologist',
      'Physician',
      'Gynaecologist',
      'Dentist'
    ];
    for (var i = 0; i < 10; i++) {
      DBHelper.insertDoctor(
        Doctor(
          id: '${i + 1}',
          name: 'Dr. Lorem Ipsum',
          contact: '9876512369',
          specialization:
              specialization[Random().nextInt(specialization.length)],
          rating: Random().nextInt(5),
          consultationFee: Random().nextInt(1000),
          description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In nisl purus, scelerisque a commodo ut, efficitur vel libero. Nam vehicula mi purus, a scelerisque quam aliquet luctus. Praesent porta velit at nibh vehicula tempus. Mauris commodo velit a lacinia porta. Vivamus aliquet sodales enim ut maximus. Proin fermentum pretium nulla, in iaculis nulla interdum eu. Vestibulum ultrices suscipit nibh, in blandit massa eleifend sed. Cras egestas pharetra ligula vitae hendrerit. Etiam suscipit pulvinar dolor ut rhoncus. Praesent dictum volutpat eros sed bibendum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eros quam, lacinia in urna sed, gravida volutpat est. Donec mauris leo, blandit ac quam ut, euismod sodales elit.',
          imageUrl:
              'https://img.freepik.com/free-vector/doctor-character-background_1270-84.jpg?w=2000',
          password: '1234',
        ),
      );
    }

    await fetchData();
  }

  void addDoctor(Doctor doc) {
    _doctors.add(doc);
    notifyListeners();
    DBHelper.insertDoctor(doc);
  }

  Doctor getDoctorById(String id) {
    return _doctors.firstWhere((element) => element.id == id);
  }

  Future<void> fetchData() async {
    final data = await DBHelper.getDoctorData();
    _doctors = data.map((e) => Doctor.fromMap(e)).toList();
    notifyListeners();
  }

  // List<Doctor> byLocation(double lat, double long){
  //   final dummy = [..._doctors];
  //   dummy.sort((a, b) {
  //     final loc1 = Utils.locationFromString(a.location!);
  //     final loc2 = Utils.locationFromString(b.location!);
  //     final dist1 = Utils.distanceFromUser(lat, long, loc1[0], loc1[1]);
  //     final dist2 = Utils.distanceFromUser(lat, long, loc2[0], loc2[1]);
  //     return dist1.compareTo(dist2);
  //   });
  //   return dummy;
  // }
  //
  // List<Doctor> byLocationFavourites(double lat, double long){
  //   final dummy = byLocation(lat, long);
  //   return dummy.where((element) => element.isFavourite).toList();
  // }
}
