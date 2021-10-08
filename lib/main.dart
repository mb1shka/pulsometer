// @dart=2.9
import 'package:flutter/material.dart';
import 'package:heart_rate/presentation/pages_and_screens/home_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/intro_screen.dart';
import 'package:heart_rate/domain/shared_preferences/my_shared_preferences.dart';
import 'package:heart_rate/presentation/pages_and_screens/payment_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/splash_screen.dart';
import 'package:heart_rate/presentation/pages_and_screens/statistics_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/listeners/heart_rate_listener.dart';
//import 'package:heart_bpm/heart_bpm.dart';

SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isFirstRun = false;

  @override
  void initState() {
    super.initState();
    if (prefs.getBool('isFirstRun') != null) isFirstRun = prefs.getBool('isFirstRun');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart rate app',
      home: SplashScreen(
        next: (context) => isFirstRun ? PaymentPage() : IntroScreen(),
      ),
      //isFirstRun ? PaymentPage() : IntroScreen(),
    );
  }
}
