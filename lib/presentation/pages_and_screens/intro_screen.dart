import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heart_rate/domain/shared_preferences/my_shared_preferences.dart';
import 'package:heart_rate/presentation/pages_and_screens/home_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/payment_page.dart';

import '../../custom_icons.dart';

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

  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                PaymentPage()),
      );
    });
  }*/

  @override
  Widget build(BuildContext context) {
    /*return Expanded(
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
    );*/

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              ),
              //TODO: make a showDialog how to use
              icon: Icon(
                CustomIcons.cross_icon,
                color: Colors.black,
              )),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(84, 99, 85, 0),
            child: SvgPicture.asset('assets/svg/bubble.svg'),
          ),
          SizedBox(height: 82),
          Center(
            child: Text(
              'Attention!',
              style: TextStyle(
                color: new Color(0xFFFF6A89),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 24),
          Center(
            child: Text('The Heart Rate Monitor app is not intended \n '
                'for medical purposes. \n'
                'All Data is provided for informational \n'
                'purposes only.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text('In case of feeling sick please consult your\n '
              'doctor.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 17,
            ),),
          SizedBox(height: 46),
          ElevatedButton(
            onPressed: () {
              MySharedPreferences.instance.setBooleanValue('isFirstRun', true);

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => PaymentPage()));
            },
            child: Text(
              'Got it',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: new Color(0xFFFF6A89),
                fixedSize: Size(224, 46),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                )),
          ),
        ],
      ),
    );
  }
}
