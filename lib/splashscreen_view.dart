import 'dart:async';
import 'nMain.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashCreen();
  }

  startSplashCreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return MyHomePage();
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
