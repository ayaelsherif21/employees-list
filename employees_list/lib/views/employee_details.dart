import 'package:flutter/material.dart';
import 'package:employees_list/models/employee_model.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailsScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(employee.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (employee.profileImage.isNotEmpty)
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(employee.profileImage),
                  onBackgroundImageError: (_, __) =>
                      const Icon(Icons.person, size: 50),
                ),
              ),
            const SizedBox(height: 16),
            Text('Name: ${employee.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Age: ${employee.age}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Salary: \$${employee.salary}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
