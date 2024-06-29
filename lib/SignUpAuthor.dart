// ignore_for_file: file_names
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fruit_e_commerce/verf.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SignupAuthor(),
  ));
}

// ignore: use_key_in_widget_constructors
class MyDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  // ignore: use_key_in_widget_constructors
  const MyDatePicker({required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Birth Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      ),
      onTap: () => _selectDate(context),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onDateChanged(picked);
    }
  }
}

// ignore: use_key_in_widget_constructors
class SignupAuthor extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SignupAuthorState createState() => _SignupAuthorState();
}

class _SignupAuthorState extends State<SignupAuthor> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String selectedCountry = 'Egypt';
  String selectedDegree = 'Professor';
  String selectedSpecialization = 'Science';
  DateTime selectedDate = DateTime(1920, 11, 22);

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

  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop(); // Close the modal sheet
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  Future<void> _register(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    await registerUser(context);
  }

  Future<void> registerUser(BuildContext context) async {
    FormData formData = FormData.fromMap({
      'FirstName': firstNameController.text,
      'MiddleName': middleNameController.text,
      'LastName': lastNameController.text,
      'PhoneNumber': phoneNumberController.text,
      'Email': emailController.text,
      'Password': passwordController.text,
      'isAuther': true,
      'BirthDate':
          '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
      'NationalityId': 'e2c2904d-097e-4f77-d6c2-08dc47fc8d3b',
      'Degree': selectedDegree,
      'Specialization': selectedSpecialization,
      if (_image != null)
        'ProfileImage': await MultipartFile.fromFile(_image!.path),
    });

    try {
      var response = await Dio().post(
        'http://readify.runasp.net/api/Auth/Register',
        data: formData,
        options: Options(
          headers: {
            Headers.contentTypeHeader: 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerificationPage(email: emailController.text)),
        );
      } else {
        // ignore: avoid_print
        print('Registration failed: ${response.data}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error registering user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fill your profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Don’t worry, you can always change it later',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(children: [
                    Stack(children: [
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
                    ])
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  hintText: 'First Name',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFC4C4C4),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: middleNameController,
                                decoration: InputDecoration(
                                  hintText: 'Middle Name',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFC4C4C4),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your middle name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFFC4C4C4),
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      MyDatePicker(
                          selectedDate: selectedDate,
                          onDateChanged: (newDate) {
                            setState(() {
                              selectedDate = newDate;
                            });
                          }),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(
                            width: 100,
                            child: Text('Specialization'),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: SpecializationDropdown(
                              selectedSpecialization: selectedSpecialization,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedSpecialization = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 100, child: Text('Degree')),
                          const SizedBox(width: 5),
                          Expanded(
                            child: DegreeDropdown(
                              selectedDegree: selectedDegree,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedDegree = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 100, child: Text('Country')),
                          const SizedBox(width: 5),
                          Expanded(
                            child: CountryDropdown(
                              selectedCountry: selectedCountry,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCountry = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFC4C4C4),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFC4C4C4),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFFC4C4C4),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _register(context),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF28277D),
                          fixedSize: const Size(500, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text('Create'),
                      ),
                    ],
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

List<String> fallbackDegrees = [
  'Bachelor\'s',
  'Master\'s',
  'Doctorate',
  'Professor',
];

class DegreeDropdown extends StatefulWidget {
  final String selectedDegree;
  final ValueChanged<String?> onChanged;

  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  DegreeDropdown({
    required this.selectedDegree,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DegreeDropdownState createState() => _DegreeDropdownState();
}

class _DegreeDropdownState extends State<DegreeDropdown> {
  List<String> degreeOptions = [];
  String selectedDegree = 'Professor';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDegrees();
  }

  Future<void> _fetchDegrees() async {
    try {
      final response =
          await Dio().get('http://readify.runasp.net/api/Auth/GetAllDegrees');
      if (response.statusCode == 200) {
        setState(() {
          degreeOptions = List<String>.from(response.data['\$values']);
          selectedDegree = degreeOptions.contains('Professor')
              ? 'Professor'
              : degreeOptions.first;
          isLoading = false;
        });
      } else {
        setState(() {
          degreeOptions = fallbackDegrees;
          selectedDegree = 'Professor';
          isLoading = false;
        });
        // ignore: avoid_print
        print('Failed to load degrees');
      }
    } catch (e) {
      setState(() {
        degreeOptions = fallbackDegrees;
        selectedDegree = 'Professor';
        isLoading = false;
      });
      // ignore: avoid_print
      print('Error fetching degrees: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedDegree,
      onChanged: (isLoading || degreeOptions.isEmpty)
          ? null
          : (newValue) {
              setState(() {
                selectedDegree = newValue!;
                widget.onChanged(newValue);
              });
            },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: isLoading
          ? [
              const DropdownMenuItem<String>(
                value: 'loading',
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ]
          : degreeOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    );
  }
}

List<String> fallbackSpecializations = [
  'Science',
  'History',
  'Arts',
  'Social Science',
  'Technology',
  'Medicine',
  'Economics',
  'Computer Science',
  'Anthropology',
  'Linguistics',
  'Engineering',
];

class SpecializationDropdown extends StatefulWidget {
  final String selectedSpecialization;
  final ValueChanged<String?> onChanged;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  SpecializationDropdown({
    required this.selectedSpecialization,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SpecializationDropdownState createState() => _SpecializationDropdownState();
}

class _SpecializationDropdownState extends State<SpecializationDropdown> {
  List<String> specializations = [];
  String selectedSpecialization = 'Science';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSpecializations();
  }

  Future<void> _fetchSpecializations() async {
    try {
      final response = await Dio()
          .get('http://readify.runasp.net/api/Auth/GetAllSpecializations');
      if (response.statusCode == 200) {
        setState(() {
          specializations = List<String>.from(response.data['\$values']);
          selectedSpecialization = specializations.contains('Science')
              ? 'Science'
              : specializations.first;
          isLoading = false;
        });
      } else {
        setState(() {
          specializations = fallbackSpecializations;
          selectedSpecialization = 'Science';
          isLoading = false;
        });
        // ignore: avoid_print
        print('Failed to load specializations');
      }
    } catch (e) {
      setState(() {
        specializations = fallbackSpecializations;
        selectedSpecialization = 'Science';
        isLoading = false;
      });
      // ignore: avoid_print
      print('Error fetching specializations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedSpecialization,
      onChanged: (isLoading || specializations.isEmpty)
          ? null
          : (newValue) {
              setState(() {
                selectedSpecialization = newValue!;
                widget.onChanged(newValue);
              });
            },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: isLoading
          ? [
              const DropdownMenuItem<String>(
                value: 'loading',
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ]
          : specializations.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    );
  }
}

List<String> fallbackCountries = [
  'Bolivia',
  'Egypt',
  'Algeria',
  'Belgium',
  'Libya',
  'Kuwait',
  'Jordan',
  'Iraq',
  'United Arab Emirates',
  'Saudi Arabia',
  'Qatar',
  'Bahrain',
  'Syria',
  'Oman',
  'Lebanon',
  'Yemen',
  'Palestine',
  'Tunisia'
];

class CountryDropdown extends StatefulWidget {
  final String selectedCountry;
  final ValueChanged<String?> onChanged;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  CountryDropdown({
    required this.selectedCountry,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  List<String> countries = [];
  String selectedCountry = 'Egypt';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final response = await Dio()
          .get('http://readify.runasp.net/api/Auth/GetAllNationlaites');
      if (response.statusCode == 200) {
        setState(() {
          countries = List<String>.from(response.data['\$values']);
          selectedCountry =
              countries.contains('Egypt') ? 'Egypt' : countries.first;
          isLoading = false;
        });
      } else {
        setState(() {
          countries = fallbackCountries;
          selectedCountry = 'Egypt';
          isLoading = false;
        });
        // ignore: avoid_print
        print('Failed to load countries');
      }
    } catch (e) {
      setState(() {
        countries = fallbackCountries;
        selectedCountry = 'Egypt';
        isLoading = false;
      });
      // ignore: avoid_print
      print('Error fetching countries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCountry,
      onChanged: (isLoading || countries.isEmpty)
          ? null
          : (newValue) {
              setState(() {
                selectedCountry = newValue!;
                widget.onChanged(newValue);
              });
            },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      items: isLoading
          ? [
              const DropdownMenuItem<String>(
                value: 'loading',
                child: SizedBox(
                  width: 200.0,
                  height: 100.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ]
          : countries.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
    );
  }
}
