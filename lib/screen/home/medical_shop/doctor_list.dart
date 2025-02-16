import 'package:flutter/material.dart';
import 'package:medicare/models/place.dart';
import 'package:medicare/service/api_service.dart';
import 'package:location/location.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  late Future<List<dynamic>> doctors;
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  @override
  void initState() {
    super.initState();
  
    doctors = Future.value([]);
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
    if (lat == null || lng == null) {
      return;
    }

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: lat, longitude: lng, address: 'Ramu');
      _isGettingLocation = false;
    });

    // Fetch doctors only after location is retrieved
    setState(() {
      doctors = ApiService().fetchDoctors(lat, lng);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nearby Doctors')),
      body: FutureBuilder<List<dynamic>>(
        future: doctors,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No doctors found'));
          }

          final doctorList = snapshot.data!;
          return ListView.builder(
            itemCount: doctorList.length,
            itemBuilder: (context, index) {
              final doctor = doctorList[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.local_hospital, color: Colors.blue),
                  title: Text(doctor['name'] ?? 'Unknown'),
                  subtitle: Text(
                      '${doctor['street']}, ${doctor['city']}, ${doctor['postalCode']}'),
                  trailing: Text(doctor['ext'] ?? ''),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

