import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping/Screens/Addproduck.dart';
import 'package:shopping/Screens/login.dart';
import 'package:shopping/firbase/signout.dart';

import 'package:shopping/modal/itemmodal.dart';
import 'package:shopping/service/allitems.dart';
import 'package:shopping/wediget/drawer.dart';

import 'package:shopping/wediget/shopingcart.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const String id = 'homepage';
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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

        onLogout: () {
          Navigator.pushNamed(context, LoginPage.id);
        },
        drawerItems: [
          DrawerItem(
              icon: Icons.add,
              text: 'add Produkt',
              onTap: () {
                Navigator.pushNamed(context, Addproduck.id);
                signOutUser();
              },
              title: 'profile')
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
