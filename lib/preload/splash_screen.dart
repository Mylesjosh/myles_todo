import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> arrival;
  late Animation<EdgeInsets> movement;

  //add a flag to track whether animations have been initialized.
  bool animationsInitialized = false;
  @override
  void initState() {
    super.initState();

    //Initializing animation for 2sec
    if (!animationsInitialized) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
      );
    }

    //Animation definition
    arrival = Tween<Offset>(begin: Offset(0.0, 5.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.5, curve: Curves.bounceInOut)));

    movement = EdgeInsetsTween(
            begin: EdgeInsets.only(top: 300), end: EdgeInsets.only(top: 500))
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCubic));

    //set the flag to true to indicate animations are initialized.
    animationsInitialized = true;

    //Animation execution
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/logo.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }
}
