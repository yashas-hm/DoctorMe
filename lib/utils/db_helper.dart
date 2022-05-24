import 'package:doctor_me/models/doctor.dart';
import 'package:doctor_me/models/patient.dart';
import 'package:doctor_me/providers/current_provider.dart';
import 'package:doctor_me/providers/patient_provider.dart';
import 'package:doctor_me/utils/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import '../providers/doctor_provider.dart';

class DBHelper {
  static const doctorDatabase = 'Doctors';
  static const patientDatabase = 'Patients';

  static Future<sql.Database> getPatientDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'database.db'),
        onCreate: (db, version) {
          db.rawQuery(
              "CREATE TABLE $doctorDatabase(id TEXT PRIMARY KEY, name TEXT, contact TEXT, specialization TEXT, rating INTEGER, consultationFee INTEGER, imageUrl TEXT, description TEXT, password TEXT, location TEXT, isFavourite INTEGER, currentUser INTEGER)");
          db.rawQuery(
          "CREATE TABLE $patientDatabase(id TEXT PRIMARY KEY, name TEXT, contact TEXT, address TEXT, symptoms TEXT, imageUrl TEXT, additionalNotes TEXT, password TEXT, location TEXT, currentUser INTEGER)");
    }, version: 1);
  }

  static Future<void> insertPatient(Patient patient, {int user = 0}) async {
    final sqlDB = await getPatientDatabase();
    final map = patient.toMap();
    map['currentUser'] = user;
    await sqlDB.insert(patientDatabase, map,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<sql.Database> getDoctorDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'database.db'),
        onCreate: (db, version) {
      db.rawQuery(
          "CREATE TABLE $doctorDatabase(id TEXT PRIMARY KEY, name TEXT, contact TEXT, specialization TEXT, rating INTEGER, consultationFee INTEGER, imageUrl TEXT, description TEXT, password TEXT, location TEXT, isFavourite INTEGER, currentUser INTEGER)");
      db.rawQuery(
          "CREATE TABLE $patientDatabase(id TEXT PRIMARY KEY, name TEXT, contact TEXT, address TEXT, symptoms TEXT, imageUrl TEXT, additionalNotes TEXT, password TEXT, location TEXT, currentUser INTEGER)");
    }, version: 1);
  }

  static Future<void> insertDoctor(Doctor doctor, {int user = 0}) async {
    final sqlDB = await getDoctorDatabase();
    final map = doctor.toMap();
    map['currentUser'] = user;
    await sqlDB.insert(doctorDatabase, map,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getPatientData() async {
    final sqlDB = await getPatientDatabase();
    return sqlDB.query(patientDatabase);
  }

  static Future<void> toggleFavourite(Doctor doctor) async {
    final sqlDB = await getDoctorDatabase();
    await sqlDB.rawUpdate(
        '''UPDATE $doctorDatabase SET isFavourite = ? WHERE id = ?''',
        [doctor.isFavourite ? 1 : 0, doctor.id]);
  }

  static Future<List<Map<String, dynamic>>> getDoctorData() async {
    final sqlDB = await getDoctorDatabase();
    return sqlDB.query(doctorDatabase);
  }

  static Future<bool> signup(
      BuildContext context, bool isDoctor, Object user) async {
    if (isDoctor) {
      try{
        await insertDoctor(user as Doctor, user: 1);
      }catch(w){
        return false;
      }
    } else {
      try{
        await insertPatient(user as Patient, user: 1);
      }catch(w){
        return false;
      }
    }

    Provider.of<CurrentUser>(context, listen: false).setUser = user;

    return true;
  }

  static Future<Object?> login(
      BuildContext context, String id, String password) async {
    var sqlDB = await getDoctorDatabase();
    var data = await sqlDB
        .rawQuery('''SELECT * FROM $doctorDatabase WHERE id = ?''', [id]);
    if (data.isNotEmpty) {
      if (data.first['password'] == password) {
        Provider.of<CurrentUser>(context, listen: false).setUser = Doctor.fromMap(data.first);
        await sqlDB.rawQuery('''UPDATE $doctorDatabase SET currentUser = ? WHERE id = ?''', [1, id]);
        return Doctor.fromMap(data.first);
      } else {
        Validation.errorSnackbar(context, 'Wrong Password');
      }
    } else {
      sqlDB = await getPatientDatabase();
      data = await sqlDB
          .rawQuery('''SELECT * FROM $patientDatabase WHERE id = ?''', [id]);
      if (data.isEmpty) {
        Validation.errorSnackbar(context, 'Invalid ID');
      } else {
        if (data.first['password'] == password) {
          Provider.of<CurrentUser>(context, listen: false).setUser =
              Patient.fromMap(data.first);
          await sqlDB.rawQuery('''UPDATE $patientDatabase SET currentUser = ? WHERE id = ?''', [1, id]);
          return Patient.fromMap(data.first);
        } else {
          Validation.errorSnackbar(context, 'Wrong Password');
        }
      }
    }

    return null;
  }

  static Future<void> createDatabase(BuildContext context) async {
    var sqlDB = await getDoctorDatabase();
    var data = await sqlDB.query(doctorDatabase);
    if (data.isEmpty) {
      Provider.of<Doctors>(context, listen: false).createDatabase();
    }

    sqlDB = await getPatientDatabase();
    data = await sqlDB.query(patientDatabase);
    if (data.isEmpty) {
      Provider.of<Patients>(context, listen: false).createDatabase();
    }
  }

  static Future<void> signOut(CurrentUser user) async {
    if (user.checkDoctor()) {
      final sqlDB = await getDoctorDatabase();
      await sqlDB.rawUpdate(
          '''UPDATE $doctorDatabase SET currentUser = ? WHERE id = ?''',
          [0, user.getUser.id]);
    } else {
      final sqlDB = await getPatientDatabase();
      await sqlDB.rawUpdate(
          '''UPDATE $patientDatabase SET currentUser = ? WHERE id = ?''',
          [0, user.getUser.id]);
    }
  }

  static Future<Object?> checkUser(BuildContext context) async {
    var sqlDB = await getDoctorDatabase();
    var data = await sqlDB.rawQuery(
        '''SELECT * FROM $doctorDatabase WHERE currentUser = ?''', [1]);
    Object? user;
    if (data.isNotEmpty) {
      user = Doctor.fromMap(data.first);
      Provider.of<CurrentUser>(context, listen: false).setUser = user;
      return user;
    } else {
      sqlDB = await getPatientDatabase();
      data = await sqlDB.rawQuery(
          '''SELECT * FROM $patientDatabase WHERE currentUser = ?''', [1]);
      if (data.isNotEmpty) {
        user = Patient.fromMap(data.first);
        Provider.of<CurrentUser>(context, listen: false).setUser = user;
        return user;
      }
    }
    return user;
  }
}
