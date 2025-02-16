import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/common_widget/user_image_picker.dart';
import 'package:medicare/screen/home/patient_main_tab_screen.dart';
import 'package:medicare/screen/login/login_screen.dart';
import 'package:medicare/screen/login/mobile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicare/service/profile_details.dart';
import 'package:medicare/service/data_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 

  File? _selectedImage;
  DataService dataService = DataService();
  // final storage = FlutterSecureStorage();
  void _onSubmit() async {
    if (_formkey.currentState!.validate()) {
      Map<String, String> data = {
        "email": _emailController.text,
        "password": _passwordController.text,
        "userName": _usernameController.text
      };
      var response = await dataService.register('/register', data);
      if (response != null) {
        Map<String, dynamic> jsonResponse = await json.decode(response);
        if (jsonResponse['success'] == false) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(jsonResponse['error'])));
        } else if (jsonResponse['success'] == true) {
          // final token = jsonResponse['authToken'];
          // await storage.write(key: 'auth_token', value: token);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MobileScreen()),
          );
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
              Text(
                "Sign Up",
                style: TextStyle(
                  color: TColor.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              // UserImagePicker(
              //   onPickImage: (pickedImage) {
              //     _selectedImage = pickedImage;
              //   },
              // ),
              const SizedBox(
                height: 15,
              ),
              Form(
                key: _formkey,
                child: Column(children: [
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
                ]),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        builder: (context) => MobileScreen(),
                      ));
                },
                child: Text('Already have an account ? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
