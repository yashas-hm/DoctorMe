import 'dart:math';

class Utils{
  static String locationFromLatLon(double latitude, double longitude){
    return '$latitude%$longitude';
  }

  static List<double> locationFromString(String location){
    final split = location.split('%');
    final List<double> list = [];
    list.add(double.parse(split[0]));
    list.add(double.parse(split[1]));
    return list;
  }

  static double distanceFromUser(double lat1, double long1, double lat2, double long2){
    // final l1 = pow(lat1-lat2, 2);
    // final l2 = pow(long1-long2, 2);
    // return sqrt(l1-l2);
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((long2 - long1) * p))/2;
    return 12742 * asin(sqrt(a));
  }


}