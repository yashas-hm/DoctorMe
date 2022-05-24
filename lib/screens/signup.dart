import 'package:doctor_me/models/doctor.dart';
import 'package:doctor_me/models/patient.dart';
import 'package:doctor_me/screens/doctor_choice_screen.dart';
import 'package:doctor_me/screens/patient_accept_screen.dart';
import 'package:doctor_me/utils/db_helper.dart';
import 'package:doctor_me/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../utils/validation.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static const routeName = '/sign-up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isDoctor = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Me'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height + 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Colors.black38
                      : Colors.white70,
                ),
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Patient',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      onChanged: (bool value) {
                        setState(() {
                          isDoctor = value;
                        });
                      },
                      value: isDoctor,
                      activeTrackColor: Colors.greenAccent,
                      inactiveTrackColor: Colors.redAccent,
                      inactiveThumbColor: Colors.redAccent,
                    ),
                    const Text(
                      'Doctor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SignUpWidget(isDoctor: isDoctor),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  final bool isDoctor;
  static final formKey = GlobalKey<FormState>();

  const SignUpWidget({
    required this.isDoctor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: screenSize.width,
          height: screenSize.height / 1.8,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: darkMode ? Colors.black38 : Colors.white70,
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: isDoctor ? doctorForm() : patientForm(),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () => signUp(context, isDoctor, formKey),
          child: Container(
            alignment: Alignment.center,
            width: screenSize.width / 2,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: const Text(
              'SIGN UP',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final Map<String, dynamic> dataMap = {};

Future<void> signUp(
    BuildContext context, bool isDoc, GlobalKey<FormState> key) async {
  key.currentState!.save();
  Object user;

  final location = await Location().getLocation();
  final locationStr = Utils.locationFromLatLon(location.latitude!, location.longitude!);
  dataMap['location'] = locationStr;

  if (!Validation.verifyEmail(dataMap['id'])) {
    Validation.errorSnackbar(context, 'Incorrect Email Format');
    return;
  } else if (!Validation.verifyPassword(
      dataMap['password'].toString().trim())) {
    Validation.errorSnackbar(context,
        'Password should consist one digit, one uppercase, one lowercase, one special character, no whitespace and length between 8-20.');
    return;
  } else if (dataMap['name'] == '') {
    Validation.errorSnackbar(context, 'Name field Empty');
    return;
  } else if (dataMap['contact'].toString().length < 10) {
    Validation.errorSnackbar(context, 'Invalid Contact');
    return;
  }

  if (isDoc) {
    if (dataMap['specialization'] == '') {
    } else if (dataMap['description'] == '') {
      Validation.errorSnackbar(context, 'Description field Empty');
      return;
    } else if (dataMap['consultationFee'] == -1) {
      Validation.errorSnackbar(context, 'Consultation Fee field Empty');
      return;
    }
    user = Doctor.fromMap(dataMap);
  } else {
    if (dataMap['address'] == '') {
      Validation.errorSnackbar(context, 'Home Address field Empty');
      return;
    } else if (dataMap['symptoms'] == '') {
      Validation.errorSnackbar(context, 'Symptoms field Empty');
      return;
    } else if (dataMap['additionalNotes'] == '') {
      Validation.errorSnackbar(context, 'Additional Information field Empty');
      return;
    }
    user = Patient.fromMap(dataMap);
  }

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) {
      return FutureBuilder(
        future: DBHelper.signup(context, isDoc, user),
        builder: (c, s) {
          if (s.connectionState == ConnectionState.done) {
            if (!(s.data as bool)) {
              Navigator.of(ctx).pop();
            } else {
              Future.delayed(
                const Duration(seconds: 3),
                () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pushReplacementNamed(isDoc
                      ? PatientAcceptScreen.routeName
                      : DoctorChoiceScreen.routeName);
                },
              );
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/3,
                  child: AlertDialog(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.check_circle_outline_outlined,
                          size: 20,
                          color: Colors.greenAccent,
                        ),
                        Text('Sign Up Successful'),
                      ],
                    ),
                  ),
                ),
              );
            }
          }

          return const AlertDialog(
            content: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      );
    },
  );
}

List<Widget> patientForm() => <Widget>[
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'E-mail',
        ),
        maxLength: 30,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['id'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
        maxLength: 20,
        obscureText: true,
        obscuringCharacter: '*',
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['password'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
        maxLength: 30,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['name'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Mobile Number',
        ),
        maxLength: 30,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['contact'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          labelText: 'Home Address',
        ),
        maxLength: 100,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['address'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          labelText: 'Symptoms',
          hintText: 'Input each symptom in new line',
        ),
        maxLength: 300,
        minLines: 1,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['symptoms'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Additional Information',
        ),
        maxLength: 60,
        textInputAction: TextInputAction.done,
        onSaved: (value) => {dataMap['additionalNotes'] = value ?? ''},
      ),
    ];

List<Widget> doctorForm() => <Widget>[
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'E-mail',
        ),
        maxLength: 30,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['id'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
        maxLength: 20,
        obscureText: true,
        obscuringCharacter: '*',
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['password'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Name',
        ),
        maxLength: 30,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['name'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          labelText: 'Mobile Number',
        ),
        maxLength: 30,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['contact'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: 'Specialization',
        ),
        maxLength: 30,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {dataMap['specialization'] = value ?? ''},
      ),
      TextFormField(
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'Consultation Fee',
        ),
        maxLength: 5,
        textInputAction: TextInputAction.next,
        onSaved: (value) => {
          dataMap['consultationFee'] =
              int.parse(value == null ? '-1' : value.toString())
        },
      ),
      TextFormField(
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          labelText: 'Description',
          hintText: 'Describe yourself and your achievements',
        ),
        maxLength: 700,
        textInputAction: TextInputAction.done,
        onSaved: (value) => {dataMap['description'] = value ?? ''},
      ),
    ];
