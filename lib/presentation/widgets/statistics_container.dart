import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate/data/database/measurement_database.dart';
import 'package:heart_rate/data/model/measurement.dart';
import 'package:heart_rate/data/model/status.dart';
import 'package:heart_rate/presentation/widgets/statistics_element.dart';

class StatisticsContainer extends StatefulWidget {
  @override
  _StatisticsContainerState createState() => _StatisticsContainerState();
}

class _StatisticsContainerState extends State<StatisticsContainer> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Statistics'),
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
