import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/common_widget/category_button.dart';
import 'package:medicare/common_widget/section_row.dart';

import 'package:medicare/screen/home/chat/chat_message_screen.dart';
import 'package:medicare/screen/home/doctor_cell.dart';
import 'package:medicare/screen/home/medical_shop/medical_shop_list_screen.dart';
import 'package:medicare/screen/home/medical_shop/medical_shop_profile_screen.dart';
import 'package:medicare/screen/home/only_docter_profile_screen.dart';
import 'package:medicare/screen/home/shop_cell.dart';
import 'package:http/http.dart' as http;
import 'package:medicare/service/data_service.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final storage = FlutterSecureStorage();
 

  List adsArr = [
    {"img": "assets/img/ad_1.png"},
    {"img": "assets/img/ad_2.png"},
  ];

  List nearDoctorArr = [];

  List nearShopArr = [
    {
      "name": "Jai Ambey Medical",
      "address": "Surat",
      "img": "assets/img/s1.png"
    },
    {
      "name": "All Relif Medical",
      "address": "Surat",
      "img": "assets/img/s2.png"
    },
    {
      "name": "Matru Chaya Medical",
      "address": "Surat",
      "img": "assets/img/s3.png"
    },
  ];
  bool _isgetDoctor = false;
  void getDoctor() async {
    try {
      final _cityName = await storage.read(key: 'cityName');
      Map<String, String> body = {"cityName": _cityName!};

      var response = await DataService().getDoctor('/getDoctor', body);
      if (response != null) {
        Map<String, dynamic> jsonResponse = await json.decode(response);
        if (jsonResponse['success'] == true) {
          setState(() {
            nearDoctorArr = jsonResponse['doctors'];
            _isgetDoctor = true;
          });
        }
      }
      print(nearDoctorArr); // Use the list as needed
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getDoctor();
    _isgetDoctor = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(
              height: context.width * 0.5,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  itemBuilder: (context, index) {
                    var obj = adsArr[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            obj["img"],
                            width: context.width * 0.85,
                            height: context.width * 0.425,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 15,
                      ),
                  itemCount: adsArr.length),
            ),
            SectionRow(title: "Doctors near by you", onPressed: () {}),
            SizedBox(
              height: 220,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DoctorCell(
                    obj: nearDoctorArr[index],
                    // onPressed: () {
                    //   context.push(const OnlyDoctorProfileScreen());
                    // });
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 15,
                ),
                itemCount: nearDoctorArr.length,
              ),
            ),
            SectionRow(
              title: "Medical Shop near by you",
              onPressed: () {
                context.push(const MedicalShopListScreen());
              },
            ),
            SizedBox(
              height: 220,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ShopCell(
                    obj: nearShopArr[index],
                    onPressed: () {
                      context.push(const MedicalShopProfileScreen());
                    },
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  width: 15,
                ),
                itemCount: nearShopArr.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


