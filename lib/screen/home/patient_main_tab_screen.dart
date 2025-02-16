import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/common_widget/menu.dart';
import 'package:medicare/screen/home/patient_home_tab_screen.dart';
import 'package:medicare/screen/my_appointmentScreen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectTab = 0;
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey();
  final storage = FlutterSecureStorage();
  var userName;
  var userLocation;
  List menuArr = [
    {'name': 'My Appointments', 'icon': 'assets/img/my_apo.png', 'action': '1'},
    {
      'name': 'New Appointment',
      'icon': 'assets/img/new_app.png',
      'action': '2'
    },
    {'name': 'Logout', 'icon': 'assets/img/logout.png', 'action': '7'}
  ];

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 3, vsync: this);
    initData();

    controller.addListener(() {
      setState(() {
        selectTab = controller.index;
      });
    });
  }

  void initData() async {
    final name = await storage.read(key: 'userName');
    final location = await storage.read(key: "cityName");
    print(name);
    print(location);
    setState(() {
      userName = name ?? "Ramu Kumar";
      userLocation = location ?? "Assam";
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
                                userName == null ? "Ramu" : userName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                userLocation == null ? "Assam" : userLocation,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientAppointmentsScreen(
                            patientUserName: userName)));
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
          "Medicare",
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
                      userLocation,
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
            // child: TabBarView(controller: controller, children: [
            //   const HomeTabScreen(),
            //   Container(),
            //   Container(),
            // ]),
            child: HomeTabScreen(),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.symmetric(vertical: 15),
      //   decoration: const BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(15),
      //         topRight: Radius.circular(15),
      //       ),
      //       boxShadow: [
      //         BoxShadow(
      //             color: Colors.black12, blurRadius: 5, offset: Offset(0, -2))
      //       ]),
      //   child: TabBar(
      //       controller: controller,
      //       indicatorColor: Colors.transparent,
      //       tabs: [
      //         Tab(
      //           icon: Image.asset(
      //             "assets/img/home_tab_ic.png",
      //             width: 32,
      //             color: selectTab == 0 ? TColor.primary : TColor.unselect,
      //           ),
      //         ),
      //         Tab(
      //           icon: Image.asset(
      //             "assets/img/chat_tab_ic.png",
      //             width: 32,
      //             color: selectTab == 1 ? TColor.primary : TColor.unselect,
      //           ),
      //         ),
      //         Tab(
      //           icon: Image.asset(
      //             "assets/img/setting_tab_ic.png",
      //             width: 32,
      //             color: selectTab == 2 ? TColor.primary : TColor.unselect,
      //           ),
      //         )
      //       ]),
      // ),
    );
  }
}
