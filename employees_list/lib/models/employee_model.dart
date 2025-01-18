class Employee {
  final int id;
  final String name;
  final int salary;
  final int age;
  final String profileImage;
  final String email;
  final String contactNumber;
  final String address;

  Employee({
    required this.id,
    required this.name,
    required this.salary,
    required this.age,
    required this.profileImage,
    required this.email,
    required this.contactNumber,
    required this.address,
  });

  // Convert JSON to Employee object
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      name: '${json['firstName']} ${json['lastName']}',
      salary: json['salary'] ?? 0,
      age: json['age'] ?? 0,
      profileImage: json['imageUrl'] ?? '',
      email: json['email'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
      address: json['address'] ?? '',
    );
  }

  // Convert Employee object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': name.split(' ')[0], // Split first and last name
      'lastName': name.split(' ')[1],
      'salary': salary,
      'age': age,
      'imageUrl': profileImage,
      'email': email,
      'contactNumber': contactNumber,
      'address': address,
    };
  }
}
