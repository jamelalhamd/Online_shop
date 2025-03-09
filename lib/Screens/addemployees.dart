import 'package:flutter/material.dart';
import 'package:shopping/Screens/employees.dart';
import 'package:shopping/firbase/addemployeeservice.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});
  static const String id = 'AddEmployee';

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedRole;
  final List<String> _roles = ['Verkaufen', 'Manager', 'Admin','Mitarbeiter','Andera',];

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleAddEmployee() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        String? result = await addemployee(
          firstName: _nameController.text.trim(),
          lastName: _surnameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          role: _selectedRole!,
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result!),
            backgroundColor: result.contains("successfully")
                ? Colors.green
                : Colors.red,
          ),
        );

        if (result.contains("successfully")) {
          // Clear input fields
          _nameController.clear();
          _surnameController.clear();
          _emailController.clear();
          _phoneController.clear();
          setState(() {
            _selectedRole = null;
          });

          // Navigate after a short delay to allow UI update
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted) {
              Navigator.pushReplacementNamed(context, Employees.id);
            }
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add employee'),
            backgroundColor: Colors.red,
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add Employee'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person, size: 100, color: Colors.blue),
                  const SizedBox(height: 32),
                  const Text(
                    'Add New Employee',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(),
                            ),
                           validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    final nameRegex = RegExp(r'^[a-zA-Z\s]{2,}$'); // Allows only letters and spaces, min 2 chars
    if (!nameRegex.hasMatch(value)) {
      return 'Enter a valid name (only letters, min 2 characters)';
    }
    return null;
  },
),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _surnameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(),
                            ),
                           validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    final nameRegex = RegExp(r'^[a-zA-Z\s]{2,}$'); // Allows only letters and spaces, min 2 chars
    if (!nameRegex.hasMatch(value)) {
      return 'Enter a valid name (only letters, min 2 characters)';
    }
    return null;
  },
),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                          validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  },
),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(),
                            ),
                           validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a phone number';
  }
  final phoneRegex = RegExp(r'^0\d*$'); // Starts with 0 and contains only digits
  if (!phoneRegex.hasMatch(value)) {
    return 'Enter a valid phone number starting with 0';
  }
  return null;
},
),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedRole,
                            decoration: const InputDecoration(
                              labelText: 'Role',
                              border: OutlineInputBorder(),
                            ),
                            items: _roles.map((String role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedRole = value;
                              });
                            },
                            validator: (value) =>
                                value == null ? 'Select a role' : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleAddEmployee,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.add, size: 30),
                              SizedBox(width: 8),
                              Text('Add Employee'),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
