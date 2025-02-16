import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/service/data_service.dart';
import 'package:intl/intl.dart';

class DoctorHomeTab extends StatefulWidget {
  const DoctorHomeTab({super.key});

  @override
  State<DoctorHomeTab> createState() => _DoctorHomeTabState();
}

class _DoctorHomeTabState extends State<DoctorHomeTab> {
  List upcomingAppointments = [];
  final storage = FlutterSecureStorage();
  bool _isloaded = false;
  List<Map<String, String>> patientsList = [
    {"name": "John Doe", "age": "30", "condition": "Diabetes"},
    {"name": "Alice Smith", "age": "25", "condition": "Hypertension"},
    {"name": "Michael Brown", "age": "40", "condition": "Heart Disease"},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDoctorAppointments();
    _isloaded = true;
  }

  Future<void> fetchDoctorAppointments() async {
    final _DoctorUserName = await storage.read(key: 'userName');
    print(_DoctorUserName);
    print('kkkkkkkkkkkkk');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api//doctorAppointments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'doctorUserName': _DoctorUserName!}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        setState(() {
          upcomingAppointments = jsonResponse['appointments'];
          print('pppppppppp');
          print(upcomingAppointments);
        });
      } else {
        print('Failed to fetch appointments: ${jsonResponse['message']}');
      }
    } else {
      print('Failed to fetch appointments.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Upcoming Appointments",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: !_isloaded
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: upcomingAppointments.length,
                    itemBuilder: (context, index) {
                      var appointment = upcomingAppointments[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading:
                              Icon(Icons.calendar_today, color: TColor.primary),
                          title: Text(appointment["message"]!),
                          subtitle: Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(appointment['date']))}',
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Patient List",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: patientsList.length,
              itemBuilder: (context, index) {
                var patient = patientsList[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.person, color: TColor.primary),
                    title: Text(patient["name"]!),
                    subtitle: Text(
                        "Age: ${patient["age"]}, Condition: ${patient["condition"]}"),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
