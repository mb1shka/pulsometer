import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate/presentation/pages_and_screens/home_page.dart';
import 'package:heart_rate/shared_preferences/my_shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heart rate app',
      home: IntroHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class IntroHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroHomeState();
}

class _IntroHomeState extends State<IntroHome> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text('Measurements are not intended for medical use! Use it only for general fitness and wellness purposes.',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    MySharedPreferences.instance
                        .setBooleanValue('isFirstRun', true);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => HomePage()),
                    );
                  },
                  child: Text('Continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.black),
                    ),
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

