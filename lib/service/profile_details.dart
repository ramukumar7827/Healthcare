import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileDetails {
  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchProfile() async {
    final token = await storage.read(key: 'auth_token');
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final profileData = jsonDecode(response.body);
      print(profileData);
      await storeProfileDetails(profileData);
      return profileData;
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<Map<String, dynamic>> fetchDoctorProfile() async {
    final token = await storage.read(key: 'auth_token');
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/doctorProfile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final profileData = jsonDecode(response.body);
      print('uuuuuuuuuuuuuuuuuuuuuuuuuuuu');
      print(profileData);
      await storeDoctorProfileDetails(profileData);
      return profileData;
    } else {
      throw Exception('Failed to load profile');
    }
  }
   Future<void> storeDoctorProfileDetails(Map<String, dynamic> profileData) async {
    print(profileData['name']);
    print(profileData['email']);
    await storage.write(key: 'userName', value: profileData['userName']);
      await storage.write(key: 'fullName', value: profileData['fullName']);
    await storage.write(key: 'specialization', value: profileData['specialization']);
    await storage.write(key: 'degrees', value: profileData['degrees']);
    await storage.write(key: 'experience', value: profileData['experience']);
    await storage.write(
        key: 'fees', value: profileData['fees']);
      await storage.write(
        key: 'timings', value: profileData['timings']);
  
    await storage.write(key: 'experience', value: profileData['experience']);
    await storage.write(key: 'address', value: profileData['address']);
        await storage.write(key: 'contactNumber', value: profileData['contactNumber']);
  }
  Future<void> storeProfileDetails(Map<String, dynamic> profileData) async {
    print(profileData['name']);
    print(profileData['email']);
    await storage.write(key: 'userName', value: profileData['name']);
    await storage.write(key: 'email', value: profileData['email']);
    // Add any other details you need to store
  }
}
