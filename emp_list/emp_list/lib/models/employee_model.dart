class Employee {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String contactNumber;
  final int age;
  final String dob;
  final int salary;
  final String address;
  final String imageUrl;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNumber,
    required this.age,
    required this.dob,
    required this.salary,
    required this.address,
    required this.imageUrl,
  });

  // Convert JSON to Employee object
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      contactNumber: json['contactNumber'],
      age: json['age'],
      dob: json['dob'],
      salary: json['salary'],
      address: json['address'],
      imageUrl: json['imageUrl'],
    );
  }

  // Convert Employee object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'contactNumber': contactNumber,
      'age': age,
      'dob': dob,
      'salary': salary,
      'address': address,
      'imageUrl': imageUrl,
    };
  }
}
