import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/common_widget/menu.dart';
import 'package:medicare/screen/home/doctor_home_tab.dart';
// import 'package:medicare/screen/doctor/doctor_appointments_screen.dart';
// import 'package:medicare/screen/doctor/patient_records_screen.dart';

class DoctorMainTabScreen extends StatefulWidget {
  const DoctorMainTabScreen({super.key});

  @override
  State<DoctorMainTabScreen> createState() => _DoctorMainTabScreenState();
}

class _DoctorMainTabScreenState extends State<DoctorMainTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectTab = 0;
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey();
  final storage = FlutterSecureStorage();
  var doctorName;
  var specialization;
  var cityName;
  List menuArr = [
    {'name': 'Upcoming Appointments', 'icon': 'assets/img/my_apo.png', 'action': '1'},
    {
      'name': 'Patient Records',
      'icon': 'assets/img/patients.png',
      'action': '2'
    },
    {'name': 'Logout', 'icon': 'assets/img/logout.png', 'action': '3'},
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    loadData();

    controller.addListener(() {
      setState(() {
        selectTab = controller.index;
      });
    });
  }

  void loadData() async {
    final name = await storage.read(key: 'fullName');
    final spec = await storage.read(key: "specialization");
    final location = await storage.read(key: "cityName");
    setState(() {
      cityName = location ?? "Assam";
      doctorName = name ?? "Dr. Ramu Kumar";
      specialization = spec ?? "General Physician";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      drawer: Drawer(
        width: context.width * 0.78,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: TColor.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              scaffoldStateKey.currentState?.closeDrawer();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 25,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              "assets/img/u1.png",
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctorName??"Dr ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                specialization??"General Physician",
                                
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Menu(
              obj: menuArr[0],
              onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => PatientAppointmentsScreen(
                //               patientUserName: userName)));
              },
            ),
            SizedBox(
              height: 5,
            ),
            Menu(
              obj: menuArr[2],
              onPressed: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            scaffoldStateKey.currentState?.openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            size: 35,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Medicare - Doctor",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              child: Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: TColor.primaryText,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      cityName??"Assam",
                      style: TextStyle(
                          color: TColor.primaryText,
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: 15,
            decoration: BoxDecoration(
                color: TColor.primary,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
          Expanded(
            child: DoctorHomeTab(),
          ),
        ],
      ),
    );
  }
}
