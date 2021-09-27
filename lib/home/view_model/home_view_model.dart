import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel{

  getClockInStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('isClockIn') ?? false;
  }
}
