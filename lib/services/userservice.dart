import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  static String _emailkey = "email";
  static String _passwordkey = "password";
  static String _isloginedkey = "is_login";
  static String _detailskey = "budget";

  Future<void> saveuser({
    required String email,
    required String password,
  }) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(_emailkey, email);
    pref.setString(_passwordkey, password);
    pref.setBool(_isloginedkey, true);
  }

  Future<void> saveDetails() async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool(_detailskey, true);
  }

  Future<bool?> isDetailsSaved() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(_detailskey)) {
      return pref.containsKey(_detailskey);
    } else {
      return false;
    }
  }

  Future<bool?> islogined() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.containsKey(_isloginedkey)) {
      return pref.getBool(_isloginedkey);
    } else {
      return false;
    }
  }
}
