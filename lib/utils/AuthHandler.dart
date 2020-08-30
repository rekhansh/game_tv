import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHandler{

  Future<bool> login(String username,String password) async
  {
    if((username=="9898989898"||username=="9876543210")&&password=="password123")
    {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('loggedIn', true);
      return true;
    }
    return false;
  }
}