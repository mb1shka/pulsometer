import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate/presentation/icons/heart_beat_icon.dart';
import 'package:heart_rate/presentation/pages_and_screens/intro_screen.dart';
import 'package:heart_rate/presentation/pages_and_screens/measurement_page.dart';
import 'package:heart_rate/shared_preferences/my_shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  //в этом куске кода - текущий индекс иконки и его смена при нажатии

  static List<Widget> _widgetOptions = <Widget>[
    /*Text('Measurement',
      style: TextStyle(
        color: Colors.white,
      ),
    ),*/
    MeasurementPage(),
    Text('Statistics'),
    Text('Settings'),
  ];

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Form(
        child: CupertinoApp(
          title: 'Heart rate app',
          home: CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      HeartBeatIcon.heartbeat_1,
                    ),
                    label: 'Measurement',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.equalizer_outlined),
                    label: 'Statistics',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
              tabBuilder: (BuildContext context, index) {
                return _widgetOptions[index];
              }),
        ),
      ),
    );
    /*return CupertinoApp(
      title: 'Heart rate app',
      home: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  HeartBeatIcon.heartbeat_1,
                ),
                label: 'Measurement',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.equalizer_outlined),
                label: 'Statistics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          tabBuilder: (BuildContext context, index) {
            return _widgetOptions[index];
          }),
    );*/
  }
}
