import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping/Screens/homepage.dart';

class Employees extends StatefulWidget {
  const Employees({super.key});

  static const String id = 'Employee';

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  @override
  Widget build(BuildContext context) {
    CollectionReference employee =
        FirebaseFirestore.instance.collection('employee');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Employees List'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context,Homepage.id), // Navigate back
          icon: const Icon(Icons.home),
        ),
      ),
      backgroundColor: Colors.grey[50],


      body: getemloyees(employee),
    );
  }




  StreamBuilder<QuerySnapshot<Object?>> getemloyees(CollectionReference<Object?> employee) {
    return StreamBuilder<QuerySnapshot>(
      stream: employee.snapshots(), // Listen for real-time updates
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No employees found"));
        }

        // Extract employees list
        final List<DocumentSnapshot> employeeDocs = snapshot.data!.docs;

        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: employeeDocs.length,
          separatorBuilder: (context, index) => const Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          itemBuilder: (BuildContext context, int index) {
            var employeeData =
                employeeDocs[index].data() as Map<String, dynamic>;

            String firstName = employeeData['firstname'] ?? 'Unknown';
            String lastName = employeeData['lastname'] ?? 'Unknown';
            String email = employeeData['email'] ?? 'Unknown';
            String phone = employeeData['phone'].toString(); // Ensure it's a string
            String role = employeeData['role'] ?? 'Unknown';

            return ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(firstName[0].toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text('$firstName $lastName',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text('Email: $email\nPhone: $phone\nRole: $role'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
               onPressed: () async {
bool? confirmDelete = await showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text("Confirm Deletion"),
      content: Text("Are you sure you want to delete this employee?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Cancel
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Confirm
          },
          child: Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  },
);

// If the user confirmed, proceed with deletion
if (confirmDelete == true) {
  await employee.doc(employeeDocs[index].id).delete();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Employee deleted successfully"),
      backgroundColor: Colors.red,
    ),
  );
}
},

              ),
            );
          },
        );
      },
    );
  }
}
