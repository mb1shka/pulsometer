import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heart_rate/custom_icons.dart';
import 'package:heart_rate/data/model/measurement.dart';
import 'package:heart_rate/presentation/pages_and_screens/show_measurement_data.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

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
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ShowMeasurementData(
                  BPM: measurement.BPM.toString(),
                  status: measurement.status.toString(),
                  comment: measurement.comment,
                  date: DateFormat.yMMMMd('en_US').format(measurement.dateTime),
                  time: DateFormat.jm().format(measurement.dateTime),
                )),
      ),
      child: Container(
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          decoration: BoxDecoration(
            color: new Color(0xFFFFF1F3),
            borderRadius: BorderRadius.all(const Radius.circular(24.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 33, 12, 33),
                      child:
                          SvgPicture.asset('assets/svg/statistics_heart.svg'),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '${measurement.status.toString().substring(7)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            //width: 200,
                            height: 42,
                            child: Row(
                              children: [
                                //Expanded(child: SizedBox()),
                                Text(
                                  '${measurement.BPM.toString()}',
                                  style: TextStyle(
                                    color: new Color(0xFFFF6A89),
                                    fontSize: 42,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4),
                                      child: Text(
                                        'BPM',
                                        style: TextStyle(
                                          color: new Color(0xFFFF6A89),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                        '${DateFormat.yMMMMd('en_US').format(measurement.dateTime)}'),
                  ),
                  SizedBox(height: 9),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child:
                        Text('${DateFormat.jm().format(measurement.dateTime)}'),
                  ),
                  SizedBox(height: 10),
                  //Text('${measurement.comment.toString()}'),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Icon(
                      CustomIcons.disclosure,
                      size: 12,
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
