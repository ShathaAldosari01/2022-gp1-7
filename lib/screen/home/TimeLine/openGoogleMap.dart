import 'package:url_launcher/url_launcher.dart';

class MopUtils{
  // MapUtils._();

  static Future<void> openMop(double latitude, double longitude) async{
    String googleUrl = 'https://www.google.com/maps/search/'+'Five Guys, Dammam Saudi Arabia';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

}