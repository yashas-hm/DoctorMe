import 'package:doctor_me/models/doctor.dart';
import 'package:doctor_me/providers/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DoctorDetailsScreen extends StatelessWidget {
  static const routeName = '/doctor-details';

  const DoctorDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)!.settings.arguments as String;
    final Doctor _doctor = Provider.of<Doctors>(
      context,
      listen: false,
    ).getDoctorById(id);
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
                  tag: _doctor.id,
                  child: Container(
                    decoration: BoxDecoration(
                        color: darkMode ? Colors.black12 : Colors.white70,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    width: screenSize.width,
                    height: screenSize.height / 4,
                    child: FadeInImage.memoryNetwork(
                      image: _doctor.imageUrl,
                      placeholder: kTransparentImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    _doctor.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    _doctor.specialization,
                    style: const TextStyle(
                        fontSize: 15.0, fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    _doctor.description,
                    style: const TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Consultation Fee: ₹${_doctor.consultationFee}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: InkWell(
              onTap: () => {},
              splashColor: !darkMode ? Colors.black12 : Colors.white70,
              child: Container(
                width: screenSize.width,
                height: screenSize.height / 13,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: const Text(
                  'BOOK NOW',
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
