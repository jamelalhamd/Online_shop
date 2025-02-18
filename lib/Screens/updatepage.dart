import 'package:flutter/material.dart';
import 'package:shopping/modal/itemmodal.dart';
import 'package:shopping/service/updateProduct.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  static const String id = 'updatepage';

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _details = TextEditingController();
  final _price = TextEditingController();
  final _image = TextEditingController();

  bool _isLoading = false;
  late Producktmodal producktmodal; // Store product data at class level

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Retrieve product details from arguments
    final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    producktmodal = arguments?['producktmodal'];

    if (producktmodal != null) {
      _title.text = producktmodal.title;
      _details.text = producktmodal.description;
      _price.text = producktmodal.price.toString();
      _image.text = producktmodal.image;
    }
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
        double? parsedPrice = double.tryParse(_price.text);
        if (parsedPrice == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please enter a valid price!'),
                backgroundColor: Colors.red),
          );
          return;
        }
        await updateProduct(
          id: producktmodal.id,
          category: producktmodal.category,
          title: _title.text,
          price: parsedPrice, // Convert the price back to String
          description: _details.text,
          image: _image.text,
        );
      } on Exception catch (e) {
        throw Exception(e.toString());
      }

      if (!mounted) return;

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Update has been done successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        _isLoading = false;
      });

      // Navigate back after success
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Update'),
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
                    'Update Product ID: ${producktmodal.id}',
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
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _isLoading ? null : () => _handleUpdate(),
                    style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Update', style: TextStyle(fontSize: 16)),
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
