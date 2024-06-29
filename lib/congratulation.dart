import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/features/home/presentation/pages/home_page.dart';

// ignore: use_key_in_widget_constructors
class CongratulationsScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CongratulationsScreenState createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  void initState() {
    super.initState();
    // ignore: prefer_const_constructors
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        backgroundColor: Color(0xFFFDFDFD),
        body: Center(
          child: Image(
            image: AssetImage(
                'assets/images/245C2828-E6EF-4411-86EA-4C3D5364E97D.jpeg'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class Splach extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CongratulationsScreen(),
    );
  }
}

void main() {
  runApp(CongratulationsScreen());
}
