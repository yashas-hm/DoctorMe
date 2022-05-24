import 'package:flutter/cupertino.dart';

import '../models/doctor.dart';

class CurrentUser with ChangeNotifier {
  Object? _user;
  bool _byLocation = false;

  get getUser => _user;

  set setUser(Object user) {
    _user = user;
    notifyListeners();
  }

  bool get byLocation => _byLocation;

  void toggleLocation(){
    _byLocation = !_byLocation;
    notifyListeners();
  }

  bool checkDoctor() => _user.runtimeType == Doctor ? true : false;
}
