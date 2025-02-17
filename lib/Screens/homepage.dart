import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping/ReusableBottomSheet.dart';
import 'package:shopping/Screens/Addproduck.dart';
import 'package:shopping/Screens/login.dart';
import 'package:shopping/firbase/signout.dart';
import 'package:shopping/modal/itemmodal.dart';
import 'package:shopping/service/allcatergorie';

import 'package:shopping/service/allitems.dart';
import 'package:shopping/service/getcategorieproduckt.dart';
import 'package:shopping/wediget/drawer.dart';
import 'package:shopping/wediget/shopingcart.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const String id = 'homepage';

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? _catergory = ''; // Initialize _catergory to an empty string
  bool _allproduct = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _addcatergory() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _allproduct = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    String email = arguments?['email'] ?? 'Guest';

    return Scaffold(
      drawer: Reusabledrawer(
        accountName: '',
        accountEmail: email,
        profileImage:
            'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',
        onLogout: () async {
          await signOutUser();
          Navigator.pushNamed(context, LoginPage.id);
        },
        drawerItems: [
          DrawerItem(
              icon: Icons.all_inbox,
              text: 'ALL Products',
              onTap: () {
                setState(() {
                  _allproduct = true;
                });
                Navigator.pop(context);
              },
              title: 'Add Product'),
          DrawerItem(
              icon_end: Icons.production_quantity_limits,
              icon: Icons.add,
              text: 'Add Product',
              onTap: () {
                Navigator.pushNamed(context, Addproduck.id);
              },
              title: 'Add Product'),
          DrawerItem(
              icon_end: Icons.category,
              icon: Icons.select_all,
              text: 'Select Category',
              onTap: () {
                setState(() {
                  _allproduct = false;
                });
                Navigator.pop(context);
                ReusableBottomSheet.show(context, [
                  SafeArea(
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 12),
                              const Text(
                                'Select Category',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Card(
                                color: const Color.fromARGB(255, 245, 244, 244),
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      FutureBuilder<List<dynamic>>(
                                        future:
                                            AllCategories().getAllCategories(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<String> items =
                                                snapshot.data!.cast<String>();
                                            return DropdownButtonFormField<
                                                String>(
                                              value: _catergory!.isEmpty
                                                  ? null
                                                  : _catergory, // Handle null gracefully
                                              decoration: const InputDecoration(
                                                labelText: 'Category',
                                                prefixIcon:
                                                    Icon(Icons.category),
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _catergory = value ??
                                                      ''; // Ensure _catergory isn't null
                                                });
                                              },
                                              items: items.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please select a category';
                                                }
                                                return null;
                                              },
                                            );
                                          } else {
                                            return const Text(
                                                'Loading categories...');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              FilledButton(
                                onPressed: () {
                                  if (_catergory != null &&
                                      _catergory!.isNotEmpty) {
                                    setState(() {
                                      _allproduct = false;
                                    });

                                    // Close the bottom sheet first
                                    Navigator.pop(context);
                                  }
                                },
                                style: FilledButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Show all products for Category',
                                        style: TextStyle(fontSize: 16),
                                      ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
              },
              title: 'Add Category'),
        ],
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: () {}, icon: Icon(FontAwesomeIcons.cartPlus)),
          ),
        ],
        title: const Text('Homepage'),
        elevation: 0.5,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Producktmodal>>(
        future: _allproduct
            ? Allitems().getallitems()
            : Allcategoreitemes().getcategoryitems(Catergory: _catergory!),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<Producktmodal>? products = snapshot.data;

            return GridView.builder(
              padding: const EdgeInsets.only(top: 80, left: 10, right: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.7,
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 100,
              ),
              itemBuilder: (context, index) => ShopingCart(
                producktmodal: products![index],
              ),
              itemCount: products?.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }
}
