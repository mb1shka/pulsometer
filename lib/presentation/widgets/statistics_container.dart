import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heart_rate/data/database/measurement_database.dart';
import 'package:heart_rate/data/model/measurement.dart';
import 'package:heart_rate/data/model/status.dart';
import 'package:heart_rate/presentation/pages_and_screens/show_measurement_data.dart';
import 'package:heart_rate/presentation/widgets/statistics_element.dart';

import '../../custom_icons.dart';

class StatisticsContainer extends StatefulWidget {
  @override
  _StatisticsContainerState createState() => _StatisticsContainerState();
}

class _StatisticsContainerState extends State<StatisticsContainer> {
  String _selectedItem = 'Today';
  bool _isToday = true;
  bool _isWeek = false;
  bool _isMonth = false;
  bool _isYear = false;

  @override
  Widget build(BuildContext context) {
    void _selectItem(String name) {
      Navigator.pop(context);
      setState(() {
        _selectedItem = name;
      });
    }

    Column _buildBottomNavigationMenu() {
      return Column(
        children: <Widget>[
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Today'),
                _isToday ?
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(CustomIcons.nike,
                    size: 16,
                    color: new Color(0xFFFF6A89),
                  ),
                ) : SizedBox(),
              ],
            ),
            onTap: () {
              setState(() {
                _isToday = true;
                _isWeek = false;
                _isMonth = false;
                _isYear = false;
              });
              _selectItem('Today');
            }
          ),
          ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Week'),
                  _isWeek ?
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(CustomIcons.nike,
                      size: 16,
                      color: new Color(0xFFFF6A89),
                    ),
                  ) : SizedBox(),
                ],
              ),
              onTap: () {
                setState(() {
                  _isToday = false;
                  _isWeek = true;
                  _isMonth = false;
                  _isYear = false;
                });
                _selectItem('Week');
              }
          ),
          ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Month'),
                  _isMonth ?
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(CustomIcons.nike,
                      size: 16,
                      color: new Color(0xFFFF6A89),
                    ),
                  ) : SizedBox(),
                ],
              ),
              onTap: () {
                setState(() {
                  _isToday = false;
                  _isWeek = false;
                  _isMonth = true;
                  _isYear = false;
                });
                _selectItem('Month');
              }
          ),
          ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Year'),
                  _isYear ?
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(CustomIcons.nike,
                      size: 16,
                      color: new Color(0xFFFF6A89),
                    ),
                  ) : SizedBox(),
                ]
              ),
              onTap: () {
                setState(() {
                  _isToday = false;
                  _isWeek = false;
                  _isMonth = false;
                  _isYear = true;
                });
                _selectItem('Year');
              }
          ),
        ],
      );
    }

    void _onButtonPressed() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Color(0xFF737373),
              height: 240,
              child: Container(
                child: _buildBottomNavigationMenu(),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                    )),
              ),
            );
          });
    }

    return new Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistics',
          style: TextStyle(
            color: new Color(0xFF121212),
            fontStyle: FontStyle.normal,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: new Color(0xFFFFFFFF),
        actionsIconTheme: IconThemeData(
          color: new Color(0xFFFF6A89),
        ),
        actions: [/*
          GestureDetector(
            child: Text(_selectedItem),
            onTap: () => _onButtonPressed(),
          ),*/
          Column(
            children: [
              ElevatedButton(
                //TODO: delete animation of the button
                onPressed: () {
                  _onButtonPressed();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 0,
                ),
                child: Text(_selectedItem,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: new Color(0xFFFF6A89),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Measurement>>(
            future: MeasurementDataBase.instance.readAll(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Measurement>> snapshot) {
              if (snapshot.hasData && snapshot.data!.length > 0) {
                return new ListView.builder(
                  itemBuilder: (context, index) =>
                      StatisticsElement(snapshot.data![index]),
                  itemCount: snapshot.data!.length,
                );
              } else if (snapshot.data?.isEmpty ?? false) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/svg/amico.svg'),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getStatisticsElements(List<Measurement> measurements) {
    List<Widget> elements = [];

    for (var i = 0; i < measurements.length; i++) {
      elements.add(new StatisticsElement(measurements[i]));
    }
    return new ListView.builder(
      itemBuilder: (context, index) => elements[index],
      itemCount: measurements.length,
    );
  }
}
