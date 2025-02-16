import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/screen/home/patient_main_tab_screen.dart';
import 'package:medicare/screen/login/doctor_login_screen.dart';
import 'package:medicare/service/data_service.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DoctorSignupScreen extends StatefulWidget {
  const DoctorSignupScreen({super.key});

  @override
  State<DoctorSignupScreen> createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends State<DoctorSignupScreen> {
  FlCountryCodePicker countryCodePicker = const FlCountryCodePicker();
  late CountryCode countryCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryCode = countryCodePicker.countryCodes
        .firstWhere((element) => element.name == "India");
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  final TextEditingController _degreesController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _feesController = TextEditingController();
  final TextEditingController _timingsController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  DataService dataService = DataService();

  final storage = FlutterSecureStorage();
  void _onSubmit() async {
    final cityName = await storage.read(key: 'cityName');
    print('rrrrrrrrrrrrrr');
    print(cityName);
    if (_formkey.currentState!.validate()) {
      Map<String, String> data = {
        "userName": _usernameController.text,
        "password": _passwordController.text,
        "email": _emailController.text,
        "fullName": _nameController.text,
        "specialization": _specializationController.text,
        "degrees": _degreesController.text,
        "experience": _experienceController.text,
        "fees": _feesController.text,
        "timings": _timingsController.text,
        "cityName": cityName!,
        "address": _addressController.text,
        "contactNumber": _contactController.text
      };

      var response = await dataService.registerDoctor('/registerDoctor', data);
      if (response != null) {
        Map<String, dynamic> jsonResponse = await json.decode(response);
        if (jsonResponse['success'] == false) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(jsonResponse['error'])));
        } else if (jsonResponse['success'] == true) {
          // final token = jsonResponse['authToken'];
          // await storage.write(key: 'auth_token', value: token);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => MainTabScreen()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup failed, please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            width: context.width,
            height: context.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "assets/img/color_logo.png",
                  width: context.width * 0.33,
                ),
                SizedBox(
                  height: context.width * 0.05,
                ),
                Expanded(
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 45,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: TColor.placeholder,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                      controller: _usernameController,
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Username",
                                        hintStyle: TextStyle(
                                          color: TColor.placeholder,
                                          fontSize: 14,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }

                                        return null;
                                      }),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 45,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: TColor.placeholder,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                          color: TColor.placeholder,
                                          fontSize: 14,
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty ||
                                            !value.contains('@')) {
                                          return 'Please enter your email address';
                                        }

                                        return null;
                                      }),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 45,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: TColor.placeholder,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: TextFormField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                          color: TColor.placeholder,
                                          fontSize: 14,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        }

                                        return null;
                                      }),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: 45,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: "Full Name",
                                      hintStyle: TextStyle(
                                        color: TColor.placeholder,
                                        fontSize: 14,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    validator: (value) => value!.isEmpty
                                        ? "Enter your name"
                                        : null,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                      controller: _specializationController,
                                      decoration: InputDecoration(
                                        hintText: "Specialization",
                                        hintStyle: TextStyle(
                                          color: TColor.placeholder,
                                          fontSize: 14,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Specialization';
                                        }

                                        return null;
                                      }),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            height: 45,
                            child: TextFormField(
                                controller: _degreesController,
                                decoration: InputDecoration(
                                  hintText: "Degrees (e.g., MBBS, MD)",
                                  hintStyle: TextStyle(
                                    color: TColor.placeholder,
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Degree';
                                  }

                                  return null;
                                }),
                          ),

                          // Experience & Fees (Row)
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            height: 45,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      controller: _experienceController,
                                      decoration: InputDecoration(
                                        hintText: "Experience (Years)",
                                        hintStyle: TextStyle(
                                          color: TColor.placeholder,
                                          fontSize: 14,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Experience';
                                        }

                                        return null;
                                      }),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                      controller: _feesController,
                                      decoration: InputDecoration(
                                        hintText: "Fees (\$)",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Fees';
                                        }

                                        return null;
                                      }),
                                ),
                              ],
                            ),
                          ),

                          // Timings Field
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            height: 45,
                            child: TextFormField(
                                controller: _timingsController,
                                decoration: InputDecoration(
                                  hintText: "Timings (e.g., Mon-Fri 11AM-5PM)",
                                  hintStyle: TextStyle(
                                    color: TColor.placeholder,
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Timings';
                                  }

                                  return null;
                                }),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            height: 45,
                            child: TextFormField(
                                controller: _addressController,
                                decoration: InputDecoration(
                                  hintText: "Clinic Address",
                                  hintStyle: TextStyle(
                                    color: TColor.placeholder,
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Address';
                                  }

                                  return null;
                                }),
                          ),

                          // Contact Field
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            height: 45,
                            child: TextFormField(
                                controller: _contactController,
                                decoration: InputDecoration(
                                  hintText: "Contact Number",
                                  hintStyle: TextStyle(
                                    color: TColor.placeholder,
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Contact Number';
                                  }

                                  return null;
                                }),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: InkWell(
                              onTap: _onSubmit,
                              child: Container(
                                width: double.maxFinite,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: TColor.primary,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "Continue",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorLoginScreen(),
                                  ));
                            },
                            child: Text('Already have a account ? Login'),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
