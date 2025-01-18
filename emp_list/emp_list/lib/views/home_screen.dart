import 'package:flutter/material.dart';
import 'package:emp_list/models/employee_model.dart';
import 'package:emp_list/services/employee_service.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late Future<List<Employee>> employeeList;
  final EmployeeService _employeeService = EmployeeService();

  @override
  void initState() {
    super.initState();
    employeeList = Future.value([]); 
  }

  void _fetchEmployees() {
    setState(() {
      employeeList = _employeeService.fetchEmployees(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employees'), backgroundColor: Colors.teal , foregroundColor: Colors.white,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _fetchEmployees, 
              child: Text('Fetch Employees'),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Employee>>(
              future: employeeList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final employees = snapshot.data!;
                  return ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      final employee = employees[index];
                      return ListTile(
                        title: Text('${employee.firstName} ${employee.lastName}'),
                        subtitle: Text('Salary: \$${employee.salary}'),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No employees found'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
