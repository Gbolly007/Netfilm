import 'dart:async';
import 'package:movie_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nMain.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  SharedPreferences sharedPrefs;
  String apikey;
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPrefs = sp;
      apikey = sharedPrefs.getString('APIKey');
      // will be null if never previously saved
      if (apikey == null) {
        apikey = 'Empty';
        persist(apikey); // set an initial value
      }
      setState(() {});
    });
    startSplashCreen();
  }

  void persist(String value) {
    setState(() {
      apikey = value;
    });
    sharedPrefs?.setString('APIKey', value);
  }

  startSplashCreen() async {
    var duration = const Duration(seconds: 3);
    print(apikey);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return apikey.contains('Empty') ? LoginPage() : MyHomePage();
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGeneralColor,
      body: Center(
        child: Image.asset(
          "images/Netfilm.png",
          width: 200,
          height: 100,
        ),
      ),
    );
  }
}
