import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heart_bpm/chart.dart';
import 'package:heart_bpm/heart_bpm.dart';
import 'package:heart_rate/custom_icons.dart';
import 'package:heart_rate/data/listeners/heart_rate_listener.dart';
import 'package:heart_rate/domain/heart_rate_calculator.dart';
import 'package:heart_rate/domain/shared_preferences/my_shared_preferences.dart';
import 'package:heart_rate/presentation/widgets/measurement_start_position.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

class MeasurementPage extends StatefulWidget {
  const MeasurementPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MeasurementPageState();
}

class _MeasurementPageState extends State<MeasurementPage> {
  HeartRateCalculator _heartRateCalculator = new HeartRateCalculator();
  List<SensorValue> data = [];
  //Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
  late Widget dialog;
  int currentValue = 0;
  int middleValue = 0;

  late Timer _timer;
  int _start = 60;

  @override
  void dispose() {
    // _timer.cancel(); // проверить задан ли таймер
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: new Color(0xFFFFFFFF),
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
          actions: [
            IconButton(
                onPressed: () {},
                //TODO: make a showDialog how to use
                icon: Icon(
                  CustomIcons.info,
                )),
          ],
        ),
        body: Column(
          children: [
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Center(
                child: SvgPicture.asset('assets/svg/measurement_hearts.svg'),
              ),
            )),
            SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                    child: Center(
                      child:
                          SvgPicture.asset('assets/svg/measurement_second.svg'),
                    ),
                  ),
                    Text(
                      '$currentValue BPM',
                      style: TextStyle(
                        color: new Color(0xFFFF6A89),
                        fontSize: 48,
                      ),
                    ),
                ],
              ),
            ),
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
                            //print("new bpm value: $value");
                            currentValue = value;
                            //_heartRateCalculator.addValue(value);
                            //TODO: точно ли этот метод должен быть здесь?
                            // HeartRateListener(currentValue: value);
                          });
                        },
                        // sampleDelay: 1000 ~/ 20,
                        // child: Container(
                        //   height: 50,
                        //   width: 100,
                        //   child: BPMChart(data),
                        // ),
                      ),
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
                    )),
                child: Text(
                  isBPMEnabled ? "Stop" : "Start",
                  style: TextStyle(
                    fontSize: 17,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                  ),
                ),
                onPressed: () => setState(() {
                  //_measurement();

                  //timer = 60 sec
                  if (isBPMEnabled) {
                    isBPMEnabled = false;
                    // dialog.
                  } else
                    isBPMEnabled = true;

                  const oneSec = const Duration(seconds: 1);
                  _timer = new Timer.periodic(
                    oneSec,
                    (Timer timer) {
                      if (_start == 0) {
                        setState(() {
                          middleValue = _heartRateCalculator.calculate();
                          _heartRateCalculator.cleanList();
                          timer.cancel();
                          //_measurementCancel();
                        });
                      } else {
                        setState(() {
                          _heartRateCalculator.addValue(currentValue);
                          _start--;
                        });
                      }
                    },
                  );
                }),
              ),
            ),
            Center(
              child: Text('Time left: $_start'),
            ),
            Center(
              //child: Text("${context.watch<HeartRateListener>().getAVGRate}"),
              child: Text("Middle value is: $middleValue"),
            )
          ],
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
