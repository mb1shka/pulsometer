// @dart=2.9
import 'package:flutter/material.dart';
import 'package:heart_rate/presentation/pages_and_screens/home_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/intro_screen.dart';
import 'package:heart_rate/domain/shared_preferences/my_shared_preferences.dart';
import 'package:heart_rate/presentation/pages_and_screens/statistics_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/listeners/heart_rate_listener.dart';
//import 'package:heart_bpm/heart_bpm.dart';

void main() {
  runApp(MyApp());
}

/*Future<bool> saveFirstRunState(String state) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('Welcome', true);
}*/

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isFirstRun = false;

  MyAppState() {
    MySharedPreferences.instance
        .getBooleanValue("isFirstRun")
        .then((value) => setState(() {
              isFirstRun = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    /*return MultiProvider(
      providers: [
        ChangeNotifierProvider<HeartRateListener>(
            create: (context) => HeartRateListener()),
      ],*/
      //child:
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        //TODO: to know, what IS it
        title: 'Heart rate app',
        // home: isFirstRun ? HomePage() : IntroScreen(),
        home: HomePage(),
      //),
    );
  }
}
