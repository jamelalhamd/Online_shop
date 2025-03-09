



// Import the firebase_core and cloud_firestore plugin

import 'package:cloud_firestore/cloud_firestore.dart';




    // Create a CollectionReference called users that references the firestore collection
    CollectionReference employee = FirebaseFirestore.instance.collection('employee');
Future<String?> addemployee({required String firstName, required String lastName, required String email, required String phone, required String role}) async {
  try {
      String trimmedEmail = email.trim().toLowerCase(); // Ensure consistent email format
    String trimmedPhone = phone.trim();
    var query = await employee.where('email', isEqualTo: email).get();
    if (query.docs.isNotEmpty) {
      return "User with this email already exists.";
    }

    await employee.add({
      'firstname': firstName,
      'lastname': lastName,
      'email': trimmedEmail,
      'phone':trimmedPhone,
      'role': role,
    });
  return "employ has been  with successfully added.";// Success
  } catch (e) {
    return "Failed to add employee: ${e.toString()}";
  }
}

  
