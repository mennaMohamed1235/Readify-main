import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/SignIn.dart';

// ignore: use_key_in_widget_constructors
class Splach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SplashScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a delayed future to navigate to the home screen after 5 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF141478),
      body: Center(
        child: Image(
          image: AssetImage(
              'assets/images/74E328AC-07CA-4C9D-AA88-63AE66EF4C78.jpeg'),
        ),
      ),
    );
  }
}
