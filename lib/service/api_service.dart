import 'package:http/http.dart' as http;
import 'dart:convert';
class ApiService {
 Future<List<dynamic>> fetchDoctors(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://api.medcorder.com/doctors?latitude=$latitude&longitude=$longitude&limit=10');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['result']; // The list of doctors
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
