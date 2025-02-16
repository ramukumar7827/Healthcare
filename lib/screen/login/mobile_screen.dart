import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/screen/home/patient_main_tab_screen.dart';
import 'package:medicare/screen/login/doctor_signup_screen.dart';

import 'package:medicare/screen/login/signup_screen.dart';
import 'package:medicare/service/profile_details.dart';
import 'package:medicare/service/data_service.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
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
  DataService dataService = DataService();
  ProfileDetails profileDetails = ProfileDetails();
  final storage = FlutterSecureStorage();
  void _onSubmit() async {
    if (_formkey.currentState!.validate()) {
      Map<String, String> data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      print(_emailController.text);
      print(_passwordController.text);
      var response = await dataService.loginUser('/loginuser', data);
      if (response != null) {
        Map<String, dynamic> jsonResponse = await json.decode(response);
        if (jsonResponse['success'] == false) {
          print("lllllllllllllllllllll");
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(jsonResponse['error'])));
        } else if (jsonResponse['success'] == true) {
          final token = jsonResponse['authToken'];
          await storage.write(key: 'auth_token', value: token);
          await profileDetails.fetchProfile();

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
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.width * 0.3,
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
                                  builder: (context) => SignupScreen(),
                                ));
                          },
                          child: Text('Create an account ? SignUp'),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
