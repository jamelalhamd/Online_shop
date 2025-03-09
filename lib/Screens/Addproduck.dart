import 'package:flutter/material.dart';
import 'package:shopping/Screens/homepage.dart';
import 'package:shopping/modal/itemmodal.dart';
import 'package:shopping/service/addproduct.dart';
import 'package:shopping/service/allcatergorie';

class Addproduck extends StatefulWidget {
  const Addproduck({super.key});
  static const String id = 'add produckt';

  @override
  State<Addproduck> createState() => _AddproduckState();
}

class _AddproduckState extends State<Addproduck> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _details = TextEditingController();
  final _price = TextEditingController();
  final _image = TextEditingController();
  final _catergoryt = TextEditingController();
  String? _catergory;
  bool _isLoading = false;
  final String token = '';

  Rating rating = Rating(
    count: 50,
    rating: 5,
  );
  // Store product data at class level

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve product details from arguments
  }

  @override
  void dispose() {
    _title.dispose();
    _details.dispose();
    _price.dispose();
    _image.dispose();
    super.dispose();
  }

  Future<void> _handleUpdate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Parse price as double (or int if needed)
      double? parsedPrice = double.tryParse(_price.text);

      if (parsedPrice == null) {
        // If price is not a valid number, show an error message
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid price!'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // If price is valid, proceed with the update
      try {
        final produck = await addproduct(
          title: _title.text.isNotEmpty ? _title.text : "No Title",
          price: _price.text.isNotEmpty ? _price.text : "0",
          description:
              _details.text.isNotEmpty ? _details.text : "No Description",
          category: _catergory ?? "Uncategorized",
          image: _image.text.isNotEmpty
              ? _image.text
              : "https://example.com/default.jpg",
          token: token,
          // Stelle sicher, dass der Token gültig ist
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Product title : ${produck.title} and Price  : ${produck.price}  has been added successfully!'),
            backgroundColor: const Color.fromARGB(255, 119, 148, 120),
          ),
        );

        print('produck$produck');

        Navigator.pushNamed(context, Homepage.id);
      } on Exception catch (e) {
        throw Exception(e.toString());
      }

      if (!mounted) return;

      // Show success message

      setState(() {
        _isLoading = false;
      });

      // Navigate back after success
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add produckt'),
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
                  const Icon(Icons.update, size: 100, color: Colors.blue),
                  const SizedBox(height: 32),
                  Text(
                    'Add New  Product  ',
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
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
                            controller: _title,
                            decoration: const InputDecoration(
                              labelText: 'Product Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a product name' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _details,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a description' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _price,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Price',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Enter a price' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _image,
                            decoration: const InputDecoration(
                              labelText: 'Image',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Enter an image link' : null,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FutureBuilder<List<dynamic>>(
                    future: AllCategories().getAllCategories(),
                    builder: (context, snapshot) {
                      List<String>? items = snapshot.data?.cast<String>();
                      if (snapshot.hasData) {
                        return DropdownButtonFormField<String>(
                          value: _catergory,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            prefixIcon: Icon(Icons.category),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (Value) {
                            setState(() {
                              _catergory = Value;
                            });
                          },
                          items: items
                              ?.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a category';
                            }
                            return null;
                          },
                        );
                      } else {
                        return TextFormField(
                          controller: _catergoryt,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'Catergory',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter a Catergory' : null,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _isLoading ? null : () => _handleUpdate(),
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                size: 30,
                              ),
                              Text(
                                'Add Product',
                                style: TextStyle(fontSize: 20),
                              )
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
