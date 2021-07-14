import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String BASE_URL = "https://namma-badavane.herokuapp.com";// heroku live

Future<void> statusColor() async {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor:  Colors.green, // status bar color
  ));
}



Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accessToken = prefs.getString("token");
  return accessToken;
}


  void userToken(){
  getToken().then((value) =>  {
     value
  });

}





