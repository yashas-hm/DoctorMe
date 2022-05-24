import 'package:doctor_me/models/patient.dart';
import 'package:doctor_me/screens/patient_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientItem extends StatelessWidget {
  const PatientItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final _patient = Provider.of<Patient>(context);
    final bool darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(
          PatientDetailsScreen.routeName,
          arguments: _patient.id,
        )
      },
      splashColor: darkMode ? Colors.white70 : Colors.black12,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: darkMode ? Colors.black12 : Colors.white70,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Hero(
                tag: _patient.id,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_patient.imageUrl),
                  backgroundColor: Colors.transparent,
                  radius: screenSize.width / 8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: screenSize.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _patient.name,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _patient.address,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 15.0, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: screenSize.width / 3,
                          height: 30,
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          child: const Text('Details'),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
