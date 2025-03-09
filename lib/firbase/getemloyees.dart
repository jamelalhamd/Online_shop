import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping/modal/Employeemodal.dart';

Future<List<Employee>> getEmployees(CollectionReference<Object?> employeeCollection) async {
  try {
    // Fetch documents from Firestore collection
    QuerySnapshot snapshot = await employeeCollection.get();

    // Map each document to an Employee object
    List<Employee> employees = snapshot.docs.map((doc) => Employee.fromDocument(doc)).toList();

    return employees;
  } catch (e) {
    throw Exception("Failed to fetch employees: $e");
  }
}
