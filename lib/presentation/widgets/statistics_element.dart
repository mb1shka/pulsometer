import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_rate/data/model/measurement.dart';

/*class StatisticsElement extends StatefulWidget {
  @override
  _StatisticsElementState createState() => _StatisticsElementState();

  final Measurement measurement;
  const StatisticsElement(this.measurement);
}*/

class StatisticsElement extends StatelessWidget {


  final Measurement measurement;

  const StatisticsElement(this.measurement);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(13, 16, 19, 0),
      child: Container(
        decoration: BoxDecoration(
          color: new Color(0xFFFFF1F3),
          borderRadius: BorderRadius.all(const Radius.circular(24.0)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('${measurement.status.toString()}'),
                    ),
                  ),
                  Text('${measurement.BPM.toString()}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('${measurement.dateTime.toString()}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('${measurement.comment.toString()}'),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}