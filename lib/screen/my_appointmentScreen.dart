import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PatientAppointmentsScreen extends StatefulWidget {
  final String patientUserName;

  const PatientAppointmentsScreen({super.key, required this.patientUserName});

  @override
  _PatientAppointmentsScreenState createState() =>
      _PatientAppointmentsScreenState();
}

class _PatientAppointmentsScreenState extends State<PatientAppointmentsScreen> {
  final storage = FlutterSecureStorage();
  List appointments = [];

  Future<void> fetchAppointments() async {
    final _patientUserName = await storage.read(key: 'userName');
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api//myAppoinments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'patientUserName': _patientUserName ?? widget.patientUserName,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['success'] == true) {
        setState(() {
          appointments = jsonResponse['appointments'];
        });
      } else {
        print('Failed to fetch appointments: ${jsonResponse['message']}');
      }
    } else {
      print('Failed to fetch appointments.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments for ${widget.patientUserName}'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return ListTile(
            title: Text('Doctor: ${appointment['doctorUserName']}'),
            subtitle: Text('Date: ${appointment['date']}'),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Reason: ${appointment['reason']}'),
                Text('Message: ${appointment['message']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
