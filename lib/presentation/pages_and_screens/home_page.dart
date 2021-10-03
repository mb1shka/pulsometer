import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate/custom_icons.dart';
import 'package:heart_rate/presentation/icons/heart_beat_icon.dart';
import 'package:heart_rate/presentation/pages_and_screens/intro_screen.dart';
import 'package:heart_rate/presentation/pages_and_screens/measurement_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/payment_page.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), topLeft: Radius.circular(24)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            fixedColor: new Color(0xFFFF6A89),
            items: [
              BottomNavigationBarItem(
                icon: Icon(CustomIcons.tab_heart),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(CustomIcons.tab_statistics),
                label: ' ',
              ),
              BottomNavigationBarItem(
                icon: Icon(CustomIcons.tab_settings),
                label: ' ',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (int index) => setState(() => _selectedIndex = index),
          ),
        ),
      ),
      body: tabs.elementAt(_selectedIndex),
    );
  }
}
