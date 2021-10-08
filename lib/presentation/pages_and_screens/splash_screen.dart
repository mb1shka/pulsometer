import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({required this.next});

  final WidgetBuilder? next;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _goToNext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 260,
          width: 286,
          child: RiveAnimation.asset(
            'assets/animation/pulse_heart.riv',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  _goToNext(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => widget.next!(context),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}