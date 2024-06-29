import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/ChangePassword.dart';
import 'package:fruit_e_commerce/SignIn.dart';
import 'package:fruit_e_commerce/profile/edit_profile.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: use_key_in_widget_constructors
class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late User user;
  late LoginResponse signInModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? signInModelJson = prefs.getString('signInModel');
    signInModel =
        LoginResponse.fromJson(jsonDecode(signInModelJson ?? 'USER_ID'));

    try {
      User fetchedUser = await fetchUserData(signInModel.userId ?? 'userId');
      setState(() {
        user = fetchedUser;
        isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error loading user data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          // ignore: unnecessary_null_comparison
          : user == null
              ? const Center(child: Text('No user data found'))
              : PersonalDataScreen(
                  user: user,
                  userid: signInModel.userId ?? '',
                ),
    );
  }
}

Future<User> fetchUserData(String userId) async {
  final response =
      await http.get(Uri.parse('http://readify.runasp.net/api/Auth/$userId'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user data');
  }
}

class User {
  final String firstName;
  final String middleName;
  final String lastName;
  final String birthDate;
  final String phoneNumber;

  User({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      birthDate: json['birthDate'],
      phoneNumber: json['phoneNumber'],
    );
  }
}

class PersonalDataScreen extends StatelessWidget {
  final User user;
  final String userid;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  PersonalDataScreen({required this.user, required this.userid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28277D),
        centerTitle: true,
        title: const Text(
          "Personl Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    "assets/images/149071.png",
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildDataRow("First Name", user.firstName),
              buildDataRow("Middle Name", user.middleName),
              buildDataRow("Last Name", user.lastName),
              buildDataRow("Birth Date", user.birthDate),
              buildDataRow("Phone number", user.phoneNumber),
              const SizedBox(height: 30),
              buildButton(
                text: "Change Password",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePassword(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              buildButton(
                text: "Edit Personal Data",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        userId: userid,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDataRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Text(
            // ignore: prefer_interpolation_to_compose_strings
            title + ": ",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton({required String text, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF28277D),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
