import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/screen/login/login_screen.dart';

class SelectCityScreen extends StatefulWidget {
  const SelectCityScreen({super.key});

  @override
  State<SelectCityScreen> createState() => _SelectCityScreenState();
}

class _SelectCityScreenState extends State<SelectCityScreen> {
  bool _isGettingLocation = false;
  String? _cityName;
  final _secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    print(lat);
    print(lng);
    if (lat == null || lng == null) {
      return;
    }

    await _fetchCityName(lat, lng);

    setState(() {
      _isGettingLocation = false;
    });

    // Navigate to the next screen after location is retrieved
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<void> _fetchCityName(double lat, double lng) async {
    final response = await http.get(Uri.parse(
        'https://geocode.maps.co/reverse?lat=$lat&lon=$lng&api_key=67ae32c46eab5551162509eotbad22b'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final city = data['address']['city'] ?? 'Unknown City';

      setState(() {
        _cityName = city;
        print("///////////////////////////////");
        print(_cityName);
      });

      await _secureStorage.write(key: 'cityName', value: city);
    } else {
      print('Failed to fetch city name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Select City",
          style: TextStyle(
            color: TColor.primaryTextW,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 35,
                decoration: BoxDecoration(
                  color: TColor.primary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 3))
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: _isGettingLocation
                        ? "Fetching your location..."
                        : _cityName ?? "Unknown City",
                    hintStyle:
                        TextStyle(color: TColor.placeholder, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.location_on,
                      color: TColor.placeholder,
                    ),
                    enabled: false,
                  ),
                ),
              )
            ],
          ),
          if (_isGettingLocation) Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }
}
