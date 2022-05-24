import 'package:doctor_me/providers/current_provider.dart';
import 'package:doctor_me/providers/doctor_provider.dart';
import 'package:doctor_me/screens/login.dart';
import 'package:doctor_me/utils/db_helper.dart';
import 'package:doctor_me/widgets/doctor_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Filters {
  favourites,
  all,
  showByLocation,
  signOut,
}

class DoctorChoiceScreen extends StatefulWidget {
  static const String routeName = '/doctor-choice-screen';

  const DoctorChoiceScreen({Key? key}) : super(key: key);

  @override
  State<DoctorChoiceScreen> createState() => _DoctorChoiceScreenState();
}

class _DoctorChoiceScreenState extends State<DoctorChoiceScreen> {
  var favourites = false;
  var byLocation = false;

  @override
  Widget build(BuildContext context) {
    final providers = Provider.of<Doctors>(context);
    final currentUser = Provider.of<CurrentUser>(context, listen: false);
    // final loc =
    //     Utils.locationFromString((currentUser.getUser as Patient).location!);
    // final doctors = byLocation
    //     ? favourites
    //         ? providers.byLocationFavourites(loc[0], loc[1])
    //         : providers.byLocation(loc[0], loc[1])
    //     : favourites
    //         ? providers.favDoctors
    //         : providers.doctor;
    final doctors = favourites ? providers.favDoctors : providers.doctor;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Me'),
        actions: [
          PopupMenuButton(
            onSelected: (Filters selected) => {
              setState(() {
                if (selected == Filters.favourites) {
                  favourites = true;
                } else if (selected == Filters.all) {
                  favourites = false;
                }else if(selected == Filters.showByLocation){
                  currentUser.toggleLocation();
                  setState(() {
                    byLocation = currentUser.byLocation;
                  });
                }else if(selected == Filters.signOut){
                  DBHelper.signOut(currentUser);
                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                }
              })
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Show Favourites'),
                value: Filters.favourites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: Filters.all,
              ),
              const PopupMenuItem(
                enabled: false,
                child: Text('Show by Location'),
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
          value: doctors[i],
          child: const DoctorItem(),
        ),
        padding: const EdgeInsets.all(10.0),
        itemCount: doctors.length,
      ),
    );
  }
}
