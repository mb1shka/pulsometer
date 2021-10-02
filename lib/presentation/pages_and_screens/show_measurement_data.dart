import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heart_rate/custom_icons.dart';
import 'package:heart_rate/data/model/measurement.dart';
import 'package:heart_rate/presentation/widgets/chip_painter.dart';
import 'package:heart_rate/presentation/widgets/statistics_container.dart';

import 'home_page.dart';

class ShowMeasurementData extends StatelessWidget {
  final String BPM;
  final String status;
  final String comment;
  final String dateTime;

  ShowMeasurementData({
    required this.BPM,
    required this.status,
    required this.comment,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Measurement',
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
        /*actions: [

          //TODO: add actions
        ],*/
        leading: IconButton(
          icon: Icon(CustomIcons.disclosure),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage()),
          ),
        ),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text('first date'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text('second date'),
            ),
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 27, 0, 40),
              child: Center(
                child: SvgPicture.asset('assets/svg/measurement_second.svg'),
              ),
            ),
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Text(
                    '${BPM.toString()}',
                    style: TextStyle(
                      color: new Color(0xFFFF6A89),
                      fontSize: 48,
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
        Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width - 32, 75),
              painter: ChipPainter(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 6),
                  child: Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
                  child: Text(
                    'Normal',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: new Color(0xFFFF6A89),
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 16),
        Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width - 32, 75),
              painter: ChipPainter(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 6),
                  child: Text(
                    'Comment',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 16),
                  child: Text(
                    'Good morning',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: new Color(0xFFFF6A89),
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
