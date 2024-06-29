import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  static String routeName = "/EditProfileScreen";

  final String userId;

  // ignore: use_super_parameters
  const EditProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF28277D),
        centerTitle: true,
        title: const Text(
          "Edit Personal Data",
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: media.height * 0.02,
                    ),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : const AssetImage('assets/images/149071.png')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 140,
                          child: IconButton(
                            onPressed: () {
                              _pickImage(context);
                            },
                            icon: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: media.height * 0.02,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              hintText: "Enter your first name",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _middleNameController,
                            decoration: InputDecoration(
                              labelText: "Middle Name",
                              hintText: "Enter your middle name",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your middle name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              hintText: "Enter your last name",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: media.height * 0.02,
                    ),
                    TextFormField(
                      controller: _birthDateController,
                      decoration: InputDecoration(
                        labelText: "Birth Date",
                        hintText: "Enter your birth date",
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your birth date';
                        }
                        return null;
                      },
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _birthDateController.text =
                                pickedDate.toString().split(' ')[0];
                          });
                        }
                      },
                      readOnly: true,
                    ),
                    SizedBox(
                      height: media.height * 0.02,
                    ),
                    TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintText: "Enter your phone number",
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: media.height * 0.02,
                    ),
                    SizedBox(
                      height: media.height * 0.05,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final profile = UserProfile(
                            userId: widget.userId,
                            firstName: _firstNameController.text,
                            middleName: _middleNameController.text,
                            lastName: _lastNameController.text,
                            phoneNumber: _phoneNumberController.text,
                            imageUrl: _image?.path ?? '',
                            birthDate: _birthDateController.text,
                          );
                          updateProfile(profile);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF28277D),
                      ),
                      child: const Text("Enter"),
                    ),
                    SizedBox(
                      height: media.height * 0.015,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4.5,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromGallery();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 70,
                          ),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImageFromCamera();
                    },
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 70,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); //close the modal sheet
  }

  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      _image = File(returnImage.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> updateProfile(UserProfile profile) async {
    final url =
        Uri.parse('http://readify.runasp.net/api/Auth/update/${widget.userId}');

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        // ignore: avoid_print
        print('Profile updated successfully');
        setState(() {
          // Update the controllers with new data
          _firstNameController.text = profile.firstName;
          _middleNameController.text = profile.middleName;
          _lastNameController.text = profile.lastName;
          _phoneNumberController.text = profile.phoneNumber;
          _birthDateController.text = profile.birthDate;
        });
        // ignore: use_build_context_synchronously
        Navigator.pop(context, profile);
      } else {
        // ignore: avoid_print
        print(
            'Failed to update profile: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception during update: $e');
    }
  }
}

class UserProfile {
  final String userId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String imageUrl;
  final String birthDate;

  UserProfile({
    required this.userId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.imageUrl,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'birthDate': birthDate,
    };
  }
}
