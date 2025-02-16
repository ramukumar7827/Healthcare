import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DataService {
  String baseUrl = 'http://10.0.2.2:5000/api';
  var log = Logger();

  String formatter(String url) {
    return baseUrl + url;
  }
  
 Future<dynamic> bookAppointment(String url, Map<String, String> body) async {
    try {
      url = formatter(url);

      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log.e('Error:$e');
      return null;
    }
  }
  
  Future<dynamic> loginUser(String url, Map<String, String> body) async {
    try {
      url = formatter(url);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-type": "application/json"},
          body: json.encode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log.e('Error:$e');
      return null;
    }
  }
  Future<dynamic> getDoctor(String url, Map<String, String> body) async {
    try {
      url = formatter(url);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-type": "application/json"},
          body: json.encode(body));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log.e('Error:$e');
      return null;
    }
  }


  Future<dynamic> register(String url, Map<String, String> body) async {
    try {
      url = formatter(url);

      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body),
      );

     if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log.e('Error:$e');
      return null;
    }
  }
  Future<dynamic> registerDoctor(String url, Map<String, String> body) async {
    try {
      url = formatter(url);

      var response = await http.post(
        Uri.parse(url),
        headers: {"Content-type": "application/json"},
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
          print('Error Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      log.e('Error:$e');
      return null;
    }
  }

  Future<dynamic> becomedonor(String url, Map<String, String> data) async {
    try {
      url = formatter(url);
      var response = await http.post(Uri.parse(url),
          headers: {"Content-type": "application/json"},
          body: json.encode(data));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log.e('Failed to load data: ${response.statusCode}');
        return null;
      }
    } catch (e) {}
  }
}
