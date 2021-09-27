import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate/data/database/measurement_database.dart';
import 'package:heart_rate/data/model/measurement.dart';
import 'package:heart_rate/data/model/status.dart';
import 'package:heart_rate/presentation/widgets/statistics_element.dart';

import '../../custom_icons.dart';

class StatisticsContainer extends StatefulWidget {
  @override
  _StatisticsContainerState createState() => _StatisticsContainerState();
}

class _StatisticsContainerState extends State<StatisticsContainer> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Statistics',
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
        actions: [
          IconButton(
              onPressed: () {},
              //TODO: make a showdialog how to use
              icon: Icon(
                CustomIcons.info,
              )
          ),
        ],
      ),
        body: FutureBuilder<List<Measurement>>(
          future: MeasurementDataBase.instance.readAll(),
          builder: (BuildContext context, AsyncSnapshot<List<Measurement>> snapshot) {
            List<Measurement> measurements = [];
            var rawMeasurements = snapshot.data;
            if (rawMeasurements != null) {
              measurements = rawMeasurements;
            }
            Widget statElements = getStatisticsElements(measurements);
            return statElements;
          },
        ),
    );
  }

  // Future<List<Measurement>> loadMeasurments() async {
  //
  //   List<Measurement> measurments = [
  //     Measurement(BPM: 56, status: Status.Normal, comment: "comment", dateTime: new DateTime.now()),
  //     Measurement(BPM: 56, status: Status.Normal, comment: "comment", dateTime: new DateTime.now())
  //   ];
  //   return Future<List<Measurement>>(() => measurments);
  // }

  Widget getStatisticsElements(List<Measurement> measurements) {
    List<Widget> elements = [];

    for (var i=0; i < measurements.length; i++) {
      elements.add(new StatisticsElement(measurements[i]));
    }
    return new ListView.builder(
      itemBuilder: (context, index) => elements[index],
      itemCount: measurements.length,
    );
  }
}
