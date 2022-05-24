import 'package:doctor_me/providers/current_provider.dart';
import 'package:doctor_me/providers/patient_provider.dart';
import 'package:doctor_me/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class PatientDetailsScreen extends StatelessWidget {
  static const routeName = '/patient-details';

  const PatientDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final _patient =
        Provider.of<Patients>(context, listen: false).getPatientById(id);
    Size screenSize = MediaQuery.of(context).size;
    final bool darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Me'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Hero(
                  tag: _patient.id,
                  child: Container(
                    decoration: BoxDecoration(
                        color: darkMode ? Colors.black12 : Colors.white70,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    width: screenSize.width,
                    height: screenSize.height / 4,
                    child: FadeInImage.memoryNetwork(
                      image: _patient.imageUrl,
                      placeholder: kTransparentImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    _patient.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Symptoms',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    _patient.symptoms,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    'Additional Notes',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    _patient.additionalNotes,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: InkWell(
              onTap: () => Utils.sendMsg(Provider.of<CurrentUser>(context, listen: false).checkDoctor(), '+91'+_patient.contact),
              splashColor: darkMode ? Colors.white70: Colors.black12  ,
              child: Container(
                width: screenSize.width,
                height: screenSize.height / 13,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Text(
                  'SCHEDULE',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
              ),
            ),
            alignment: Alignment.bottomCenter,
          )
        ],
      ),
    );
  }
}
