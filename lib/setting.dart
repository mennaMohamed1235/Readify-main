import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchWidget extends StatefulWidget {
  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _switchValue,
      onChanged: (value) {
        setState(() {
          _switchValue = value;
        });
      },
    );
  }
}

class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          title: Row(children: [
            const SizedBox(width: 0.5),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {},
            ),
            const SizedBox(width: 72),
            Text('settings',
                style:
                    GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold)),
            const Icon(Icons.settings)
          ]),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(children: [
                const SizedBox(width: 50),
                Text('ACTIVATION:-',
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold)),
                // Icon(Icons.active)
              ]),
              Row(children: [
                const SizedBox(width: 50),
                Text('Notification          ',
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 120),
                SwitchWidget(),
              ]),
              Row(children: [
                const SizedBox(width: 50),
                Text('updates                 ',
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 120),
                SwitchWidget(),
              ]),
              Row(children: [
                const SizedBox(width: 50),
                Text('language (Arabic)',
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 120),
                SwitchWidget(),
              ]),
              Row(children: [
                const SizedBox(width: 50),
                Text('Dark mode            ',
                    style: GoogleFonts.robotoCondensed(
                        fontWeight: FontWeight.bold)),
                const SizedBox(width: 120),
                SwitchWidget(),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
