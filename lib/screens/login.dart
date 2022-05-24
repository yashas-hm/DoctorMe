import 'package:doctor_me/models/doctor.dart';
import 'package:doctor_me/screens/patient_accept_screen.dart';
import 'package:doctor_me/screens/signup.dart';
import 'package:doctor_me/utils/db_helper.dart';
import 'package:flutter/material.dart';

import 'doctor_choice_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const routeName = '/login-screen';
  static final formKey = GlobalKey<FormState>();
  final Map<String, dynamic> dataMap = {};

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final bool darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Me'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: screenSize.height / 2,
          width: screenSize.width * 3 / 4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: darkMode ? Colors.black38 : Colors.white70,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            hintText: 'E-mail used in SignUp'),
                        maxLength: 30,
                        textInputAction: TextInputAction.next,
                        onSaved: (value) => dataMap['id'] = value ?? '',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        maxLength: 20,
                        obscureText: true,
                        obscuringCharacter: '*',
                        textInputAction: TextInputAction.done,
                        onSaved: (value) => dataMap['password'] = value ?? '',
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () => login(context),
                  child: Container(
                    alignment: Alignment.center,
                    width: screenSize.width / 2.5,
                    height: 30,
                    decoration: BoxDecoration(
                      color: !darkMode ? Colors.black26 : Colors.white38,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(SignUp.routeName),
                  child: const Text(
                    'Are you a new user? SignUp',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    formKey.currentState!.save();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return FutureBuilder(
            future: DBHelper.login(context, dataMap['id'], dataMap['password']),
            builder: (c, s) {
              if (s.connectionState == ConnectionState.done) {
                if (s.data == null) {
                  Navigator.of(ctx).pop();
                } else {
                  Future.delayed(
                    const Duration(seconds: 3),
                    () {
                      Navigator.of(ctx).pop();
                      Navigator.of(context).pushReplacementNamed(
                          s.data.runtimeType == Doctor
                              ? PatientAcceptScreen.routeName
                              : DoctorChoiceScreen.routeName);
                    },
                  );
                  return Center(
                    child: AlertDialog(
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height/3,
                        child: Column(
                          children: const [
                            Icon(
                              Icons.check_circle_outline_outlined,
                              size: 80,
                              color: Colors.greenAccent,
                            ),
                            Text('Login Successful'),
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
        });
  }
}
