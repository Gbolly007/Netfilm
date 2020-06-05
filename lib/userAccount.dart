import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAccount extends StatefulWidget {
  @override
  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  SharedPreferences sharedPrefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final name = sharedPrefs.getString('Username');
    final link = sharedPrefs.getString('ImageLink');
    return Scaffold(
      body: Container(
        color: kGeneralColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 70.0,
                backgroundImage: NetworkImage(link),
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "VarelaRound"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: screenWidth - 10.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(6.0, 6.0),
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                        )
                      ]),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.lock,
                              color: kSemiGeneralColor,
                            ),
                            Text(
                              "Change Password",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: kGeneralColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "PoiretOne-Regular"),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: kSemiGeneralColor,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.phone_iphone,
                              color: kSemiGeneralColor,
                            ),
                            Text(
                              "Change Mobile Number",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: kGeneralColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "PoiretOne-Regular"),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: kSemiGeneralColor,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.mail,
                              color: kSemiGeneralColor,
                            ),
                            Text(
                              "Change Email",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: kGeneralColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "PoiretOne-Regular"),
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: kSemiGeneralColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
