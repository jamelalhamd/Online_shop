import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;

  Employee({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
  });

  // Factory method to create an Employee from Firestore document data
  factory Employee.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Employee(
      firstName: data['firstname'] ?? 'Unknown',
      lastName: data['lastname'] ?? 'Unknown',
      email: data['email'] ?? 'Unknown',
      phone: data['phone'].toString(),
      role: data['role'] ?? 'Unknown',
    );
  }
}
