// ignore_for_file: file_names
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/SignUpAuthor.dart';
import 'package:fruit_e_commerce/SignUpUser.dart';
import 'package:fruit_e_commerce/features/home/presentation/pages/home_page.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SignIn extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> signIn() async {
    // ignore: prefer_const_declarations
    final String apiUrl = 'http://readify.runasp.net/api/Auth/Login';

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'Please fill in all fields';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );
      if (response.statusCode == 200) {
        var signInModel = LoginResponse.fromJson(jsonDecode(response.body));
        String signInModelJson = jsonEncode(signInModel.toJson());

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('signInModel', signInModelJson);

        log(signInModel.userId ?? 'No user ID'); // Add null check
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        setState(() {
          errorMessage =
              'Authentication failed: Email or Password is incorrect!';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/431382558_934333264581957_6966909f827530271850_n.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      // ignore: use_full_hex_values_for_flutter_colors
                      color: const Color(0xFFDFDFDFD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email/username',
                          hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      // ignore: use_full_hex_values_for_flutter_colors
                      color: const Color(0xFFDFDFDFD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Color(0xFFD9D9D9)),
                        ),
                        obscureText: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                ElevatedButton(
                  onPressed: () {
                    signIn();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF28277D),
                    fixedSize: const Size(290, 40),
                  ),
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    const Text('   Don’t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpUser()),
                        );
                      },
                      // ignore: sort_child_properties_last
                      child: const Text('Sign up'),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF28277D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 0.01),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupAuthor()),
                        );
                      },
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF28277D),
                        ),
                      ),
                      child: const Text('Sign up as an author'),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
                errorMessage.isNotEmpty
                    ? Text(
                        errorMessage,
                        style: const TextStyle(color: Colors.red),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginResponse {
  final String? userId;
  final String? token;

  LoginResponse({this.userId, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      userId: json['userId'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'token': token,
    };
  }
}
