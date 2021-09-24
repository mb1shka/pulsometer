import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_rate/data/listeners/heart_rate_listener.dart';
import 'package:heart_rate/domain/shared_preferences/my_shared_preferences.dart';
import 'package:heart_rate/presentation/widgets/measurement_start_position.dart';


import 'package:provider/provider.dart';


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
  int currentValue = 0;

  void _measurement() {
    context.read<HeartRateListener>().measurement();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        title: 'Heart rate',
        home: Scaffold(/*
          appBar: AppBar(
            title: Text('Heart BPM Demo'),
          ),*/
          body: Column(
            children: [
              isBPMEnabled
                  ? dialog = Column(
                    children: [
                      HeartBPMDialog(
                          context: context,
                          onRawData: (value) {
                            setState(() {
                              if (data.length == 100) data.removeAt(0);
                              data.add(value);
                            });
                            // chart = BPMChart(data);
                          },
                          onBPM: (value) {
                            setState(() {
                              currentValue = value;
                              HeartRateListener(currentValue: value);
                              //TODO: неправильно работает. нужно понять, как передавать текущие данные пулса
                            });
                          },
                          // sampleDelay: 1000 ~/ 20,
                          // child: Container(
                          //   height: 50,
                          //   width: 100,
                          //   child: BPMChart(data),
                          // ),
                        ),
                      Center(
                        child: Text("${context.watch<HeartRateListener>().getAVGRate}"),
                      )
                    ],
                  )
                  : SizedBox(),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(255, 106, 137, 1),
                    fixedSize: Size(224, 46),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    )
                  ),
                  child: Text(isBPMEnabled ? "Stop" : "Start",
                    style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => setState(() {
                    if (isBPMEnabled) {
                      isBPMEnabled = false;
                      _measurement();
                      // dialog.
                    } else
                      isBPMEnabled = true;
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    /*return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: MeasurementStart(),
                ),
                ElevatedButton(
                  onPressed: () {},
                      child: Text("Press here to start"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  ),
              ],
            ),
          ),
        ),
    );*/
  }
}
