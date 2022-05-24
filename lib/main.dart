import 'package:doctor_me/models/patient.dart';
import 'package:doctor_me/providers/current_provider.dart';
import 'package:doctor_me/providers/doctor_provider.dart';
import 'package:doctor_me/providers/patient_provider.dart';
import 'package:doctor_me/screens/doctor_choice_screen.dart';
import 'package:doctor_me/screens/doctor_details.dart';
import 'package:doctor_me/screens/login.dart';
import 'package:doctor_me/screens/patient_accept_screen.dart';
import 'package:doctor_me/screens/patient_details.dart';
import 'package:doctor_me/screens/signup.dart';
import 'package:doctor_me/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Patients(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Doctors(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CurrentUser(),
        ),
      ],
      child: MaterialApp(
        title: 'Doctor Me',
        theme: ThemeData.light(),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
        routes: {
          DoctorChoiceScreen.routeName: (ctx) => const DoctorChoiceScreen(),
          PatientAcceptScreen.routeName: (ctx) => const PatientAcceptScreen(),
          DoctorDetailsScreen.routeName: (ctx) => const DoctorDetailsScreen(),
          PatientDetailsScreen.routeName: (ctx) => const PatientDetailsScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          SignUp.routeName: (ctx) => const SignUp(),
        },
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: DBHelper.createDatabase(context),
      builder: (ctx, s) {
        if(s.connectionState == ConnectionState.done){
          return FutureBuilder(
            future: DBHelper.checkUser(context),
            builder: (c, state) {
              if (state.connectionState == ConnectionState.done) {
                if (state.data == null) {
                  return LoginScreen();
                } else {
                  if (state.data.runtimeType==Patient) {
                    return const DoctorChoiceScreen();
                  } else {
                    return const PatientAcceptScreen();
                  }
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    );
  }
}
