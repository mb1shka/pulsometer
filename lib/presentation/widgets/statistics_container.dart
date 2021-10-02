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
  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ShowMeasurementData(BPM: '72', status: ' ', comment: 'comment', dateTime: new DateTime.now().toString())),
                );
              },
              //TODO: make a showdialog how to use
              icon: Icon(
                CustomIcons.info,
              )),
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

    for (var i = 0; i < measurements.length; i++) {
      elements.add(new StatisticsElement(measurements[i]));
    }
    return new ListView.builder(
      itemBuilder: (context, index) => elements[index],
      itemCount: measurements.length,
    );
  }
}
