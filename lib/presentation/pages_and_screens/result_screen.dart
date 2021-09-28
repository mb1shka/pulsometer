import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heart_rate/data/database/measurement_database.dart';
import 'package:heart_rate/data/model/measurement.dart';
import 'package:heart_rate/data/model/status.dart';
import 'package:heart_rate/presentation/pages_and_screens/home_page.dart';
import 'package:heart_rate/presentation/pages_and_screens/statistics_page.dart';

import '../../custom_icons.dart';

class ResultScreen extends StatefulWidget {
  // const ResultScreen({Key? key}) : super(key: key);
  final int BPM;

  ResultScreen(this.BPM);

  @override
  State<StatefulWidget> createState() => _ResultScreenState(BPM: BPM);
}

class _ResultScreenState extends State<ResultScreen> {
  //final Measurement _currentMeasurement;
  final String comment = " ";
  final Status status = Status.Normal;
  final DateTime dateTime = DateTime.now();
  late final int BPM;

  _ResultScreenState({
    required this.BPM,
  });

  /*_ResultScreenState(int BPM) :
    _currentMeasurement = new Measurement(BPM: BPM, comment: '', dateTime: new DateTime.now(), status: Status.Normal);*/

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: new Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text(
            'Result',
            style: TextStyle(
              color: new Color(0xFF121212),
              fontStyle: FontStyle.normal,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: new Color(0xFFFFFFFF),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                  );
                },
                //TODO: make a showDialog how to use
                icon: Icon(
                  CustomIcons.cross_icon,
                )),
          ],
        ),
        body: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: SvgPicture.asset('assets/svg/measurement_second.svg'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text('$BPM  BPM',
                    style: TextStyle(
                      color: new Color(0xFFFF6A89),
                      fontSize: 48,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(255, 106, 137, 1),
                  fixedSize: Size(224, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 17,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () async {
                  await MeasurementDataBase.instance.create(new Measurement(
                      BPM: BPM,
                      status: status,
                      comment: comment,
                      dateTime: dateTime));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
