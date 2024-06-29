// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class ChangePassword extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String errorMessage = '';

  Future<void> changePassword() async {
    if (emailController.text.isEmpty ||
        currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        retypePasswordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all password fields';
      });
      return;
    } else if (newPasswordController.text != retypePasswordController.text) {
      setState(() {
        errorMessage = 'Passwords do not match';
      });
      return;
    } else {
      setState(() {
        errorMessage = '';
      });
    }

    final Map<String, dynamic> requestData = {
      "email": emailController.text,
      "currentPassword": currentPasswordController.text,
      "newPassword": newPasswordController.text,
    };

    // ignore: prefer_const_declarations
    final String url = 'http://readify.runasp.net/api/Auth/ChangePasswordAsync';
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Password changed successfully');
      } else {
        // ignore: avoid_print
        print('Failed to change password');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFDFDFD),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFDFDFD),
          title: Row(
            children: [
              const SizedBox(width: 0.5),
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(width: 30),
              Text('Change password',
                  style:
                      GoogleFonts.robotoCondensed(fontWeight: FontWeight.bold)),
              const Icon(Icons.lock_outline),
            ],
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: currentPasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Current Password',
                          hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: newPasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'New Password',
                          hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: retypePasswordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Re-type New Password',
                          hintStyle: TextStyle(color: Color(0xFFD0D0D0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                errorMessage.isNotEmpty
                    ? Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.black),
                      )
                    : Container(),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    changePassword();
                  },
                  // ignore: sort_child_properties_last
                  child: const Text('Change password'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF28277D),
                    // ignore: prefer_const_constructors
                    fixedSize: Size(290, 40),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
