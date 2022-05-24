import 'package:doctor_me/models/patient.dart';
import 'package:doctor_me/providers/patient_provider.dart';
import 'package:doctor_me/screens/login.dart';
import 'package:doctor_me/utils/db_helper.dart';
import 'package:doctor_me/widgets/patient_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/current_provider.dart';

enum Filters { showByLocation, signOut }

class PatientAcceptScreen extends StatefulWidget {
  static const String routeName = '/patient-accept-screen';

  const PatientAcceptScreen({Key? key}) : super(key: key);

  @override
  State<PatientAcceptScreen> createState() => _PatientAcceptScreenState();
}

class _PatientAcceptScreenState extends State<PatientAcceptScreen> {
  var byLocation = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Patients>(context);
    final currentUser = Provider.of<CurrentUser>(context);
    // final loc = Utils.locationFromString((currentUser.getUser as Doctor).location!);
    // final List<Patient> patients = byLocation? provider.byLocation(loc[0], loc[1]):provider.patient;
    final List<Patient> patients = provider.patient;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Me'),
        actions: [
          PopupMenuButton(
            onSelected: (Filters selected) {
              if (selected == Filters.showByLocation) {
                currentUser.toggleLocation();
                setState(() {
                  byLocation = currentUser.byLocation;
                });
              } else if (selected == Filters.signOut) {
                DBHelper.signOut(currentUser);
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                enabled: false,
                child: Text(byLocation ? 'Show all' : 'Show by Location'),
                value: Filters.showByLocation,
              ),
              const PopupMenuItem(
                child: Text('SignOut'),
                value: Filters.signOut,
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: patients[i],
          child: const PatientItem(),
        ),
        padding: const EdgeInsets.all(10.0),
        itemCount: patients.length,
      ),
    );
  }
}
