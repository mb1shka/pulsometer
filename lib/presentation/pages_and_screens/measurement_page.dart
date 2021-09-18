import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_rate/shared_preferences/my_shared_preferences.dart';

class MeasurementPage extends StatefulWidget {
  const MeasurementPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  List<SensorValue> data = [];
  //Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
  late Widget dialog;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Heart BPM Demo'),
        ),
        body: Column(
          children: [
            isBPMEnabled
                ? dialog = HeartBPMDialog(
                    context: context,
                    onRawData: (value) {
                      setState(() {
                        if (data.length == 100) data.removeAt(0);
                        data.add(value);
                      });
                      // chart = BPMChart(data);
                    },
                    onBPM: (value) {},
                    // sampleDelay: 1000 ~/ 20,
                    // child: Container(
                    //   height: 50,
                    //   width: 100,
                    //   child: BPMChart(data),
                    // ),
                  )
                : SizedBox(),
            isBPMEnabled
                ? Container(
                    decoration: BoxDecoration(border: Border.all()),
                    height: 150,
                    child: BPMChart(data),
                  )
                : SizedBox(),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(Icons.favorite_rounded),
                label: Text(isBPMEnabled ? "Stop measurement" : "Measure BPM"),
                onPressed: () => setState(() {
                  if (isBPMEnabled) {
                    isBPMEnabled = false;
                    // dialog.
                  } else
                    isBPMEnabled = true;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
