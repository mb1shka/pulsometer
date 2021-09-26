import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate/presentation/icons/heart_beat_icon.dart';
import 'package:heart_rate/presentation/pages_and_screens/measurement_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/settings_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/statistics_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> tabs = [
    MeasurementPage(),
    StatisticsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xFF1c1c1e),
          elevation: 0,
          selectedFontSize: 10,
          unselectedFontSize: 10,
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
          currentIndex: _selectedIndex,
          onTap: (int index) => setState(() => _selectedIndex = index),
      ),
      body: tabs.elementAt(_selectedIndex),
      // child: CupertinoApp(
      //   title: 'Heart rate app',
      //   home: CupertinoTabScaffold(
      //       tabBar: CupertinoTabBar(
      //         currentIndex: _currentIndex,
      //         onTap: _onItemTapped,
      //         items: [
      //           BottomNavigationBarItem(
      //             icon: Icon(
      //               HeartBeatIcon.heartbeat_1,
      //             ),
      //             label: 'Measurement',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.equalizer_outlined),
      //             label: 'Statistics',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.settings),
      //             label: 'Settings',
      //           ),
      //         ],
      //       ),
      //       tabBuilder: (BuildContext context, index) {
      //         return _widgetOptions[index];
      //       }),
      // ),
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
