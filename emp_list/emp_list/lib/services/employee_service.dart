import 'dart:convert';
import 'package:http/http.dart' as http; 
import 'package:emp_list/models/employee_model.dart';

class EmployeeService {
  final String url = 'https://mocki.io/v1/283ba093-9bf9-42e4-8f28-d2538937f9ca'; 

  // Fetches employees from the API using HTTP
  Future<List<Employee>> fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse(url)); 

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body); 
        return jsonData.map((e) => Employee.fromJson(e)).toList(); 
      } else {
        throw Exception('Failed to fetch employees: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }
}
