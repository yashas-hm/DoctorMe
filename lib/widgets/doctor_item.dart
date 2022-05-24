import 'package:doctor_me/screens/doctor_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/doctor.dart';

class DoctorItem extends StatelessWidget {
  const DoctorItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _doctor = Provider.of<Doctor>(context, listen: false);
    Size screenSize = MediaQuery.of(context).size;
    final bool darkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(
          DoctorDetailsScreen.routeName,
          arguments: _doctor.id,
        )
      },
      splashColor: darkMode ? Colors.white70: Colors.black12 ,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: darkMode ? Colors.black12 : Colors.white70,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Hero(
                tag: _doctor.id,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_doctor.imageUrl),
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
                        _doctor.name,
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
                        _doctor.specialization,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 15.0, fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Fee: ₹${_doctor.consultationFee}',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<Doctor>(
                    builder: (ctx, doctor, child) => IconButton(
                        onPressed: doctor.toggleFavourite,
                        iconSize: 20.0,
                        icon: doctor.isFavourite
                            ? const Icon(Icons.favorite)
                            : const Icon(Icons.favorite_border)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${_doctor.rating}',
                          style: TextStyle(
                            color: darkMode ? Colors.white : Colors.black,
                            fontSize: 14.0,
                          ),
                        ),
                        const WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
