import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping/ReusableBottomSheet.dart';
import 'package:shopping/Screens/Addproduck.dart';
import 'package:shopping/Screens/homepage.dart';
import 'package:shopping/Screens/login.dart';
import 'package:shopping/firbase/signout.dart';
import 'package:shopping/modal/itemmodal.dart';
import 'package:shopping/service/allitems.dart';
import 'package:shopping/wediget/drawer.dart';
import 'package:shopping/wediget/shopingcart.dart';

class CategoryProduct extends StatefulWidget {
  const CategoryProduct({super.key});
  static const String id = 'categoryproduct';

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  Future<void> _addcatergory() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product title   has been added successfully!'),
            backgroundColor: const Color.fromARGB(255, 119, 148, 120),
          ),
        );

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
    final arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    String email = arguments?['email'] ?? 'Gust';
    return Scaffold(
      drawer: Reusabledrawer(
        accountName: '',
        accountEmail: email,
        profileImage:
            'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg', // or use local asset

        onLogout: () async {
          await signOutUser();
          Navigator.pushNamed(context, LoginPage.id);
        },
        drawerItems: [
          DrawerItem(
              icon_end: Icons.production_quantity_limits,
              icon: Icons.add,
              text: 'add Produkt',
              onTap: () {
                Navigator.pushNamed(context, Addproduck.id);
              },
              title: 'add Produkt'),
          DrawerItem(
              icon_end: Icons.category,
              icon: Icons.add,
              text: 'add Category',
              onTap: () {
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
                                'Add New Cateegory',
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
                                      TextFormField(
                                        controller: _emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          labelText: 'Catergory',
                                          hintText: 'Enter The New Category',
                                          prefixIcon:
                                              Icon(Icons.category_outlined),
                                          border: OutlineInputBorder(),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter  the category';
                                          }

                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              FilledButton(
                                onPressed: _isLoading ? null : _addcatergory,
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
                                        'Add Category',
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
              title: 'add Category'),
        ],
      ),
      appBar: AppBar(
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: IconButton(
                  onPressed: () {}, icon: Icon(FontAwesomeIcons.cartPlus)))
        ],
        title: Text('homepage'),
        elevation: 0.5,
        centerTitle: true,
      ),
      body: FutureBuilder<List<Producktmodal>>(
        future: Allitems().getallitems(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<Producktmodal>? products = snapshot.data;

            return GridView.builder(
              padding: EdgeInsets.only(top: 80, left: 10, right: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // Max width of each grid item in pixels
                childAspectRatio: 1.7,
                crossAxisCount:
                    2, // Aspect ratio for the grid item, e.g., square
                crossAxisSpacing: 15, // Horizontal spacing between items
                mainAxisSpacing: 100, // Vertical spacing between items
              ),
              itemBuilder: (context, index) => ShopingCart(
                producktmodal: products![index],
              ), // Your custom widget for each grid item
              itemCount: products
                  ?.length, // Number of items in the grid (you can change this as needed)
            );
          } else {
            return Center(
                child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.green,
            ));
          }
        },
      ),
    );
  }
}
