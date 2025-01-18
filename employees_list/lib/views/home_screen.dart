import 'package:flutter/material.dart';
import 'package:employees_list/models/employee_model.dart';
import 'package:employees_list/services/employee_service.dart';
import 'package:employees_list/views/employee_details.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> _employeeListFuture;
  final EmployeeService _employeeService = EmployeeService();

  @override
  void initState() {
    super.initState();
    _employeeListFuture = _loadEmployees();
  }

  Future<List<Employee>> _loadEmployees() async {
    try {
      final cachedEmployees = await _employeeService.loadCachedEmployees();
      if (cachedEmployees.isNotEmpty) {
        return cachedEmployees;
      }
      final employees = await _employeeService.fetchEmployees();
      await _employeeService.cacheEmployees(employees);
      return employees;
    } catch (e) {
      throw Exception('Error loading employees: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employees') , backgroundColor: const Color.fromARGB(255, 204, 77, 226), foregroundColor: Colors.white),
      body: FutureBuilder<List<Employee>>(
        future: _employeeListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _employeeListFuture = _loadEmployees();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            final employees = snapshot.data!;
            if (employees.isEmpty) {
              return const Center(child: Text('No employees found.'));
            }
            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text('Salary: \$${employee.salary}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EmployeeDetailsScreen(employee: employee),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
