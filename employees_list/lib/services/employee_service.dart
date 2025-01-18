import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employees_list/models/employee_model.dart';

class EmployeeService {
  final Dio _dio = Dio();

  /// Fetches employees from the new API
  Future<List<Employee>> fetchEmployees() async {
    const url = 'https://mocki.io/v1/283ba093-9bf9-42e4-8f28-d2538937f9ca';
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        return jsonData.map((e) => Employee.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch employees: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }

  /// Caches employees locally using SharedPreferences
  Future<void> cacheEmployees(List<Employee> employees) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final employeeJson = jsonEncode(employees.map((e) => e.toJson()).toList());
      await prefs.setString('cached_employees', employeeJson);
    } catch (e) {
      throw Exception('Error caching employees: $e');
    }
  }

  /// Loads cached employees from SharedPreferences
  Future<List<Employee>> loadCachedEmployees() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('cached_employees');

      if (cachedData != null) {
        final List<dynamic> jsonData = jsonDecode(cachedData);
        return jsonData.map((e) => Employee.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Error loading cached employees: $e');
    }
  }
}
