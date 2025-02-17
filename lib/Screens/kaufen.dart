import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping/Screens/bill.dart';
import 'package:shopping/constant/constant.dart';
import 'package:shopping/wediget/Mybutton.dart';
import 'package:shopping/wediget/ProductCard.dart';

class Kaufen extends StatefulWidget {
  const Kaufen({super.key});
  static String id = 'kaufen';

  @override
  State<Kaufen> createState() => _KaufenState();
}

class _KaufenState extends State<Kaufen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            mainAxisSize:
                MainAxisSize.min, // Ensures no extra space between widgets
            children: [
              // Pay button
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Billpage.id);
                },
                child: Text(
                  'Pay',
                  style: TextStyle(
                    fontSize: 18, // Slightly smaller font size for balance
                    fontWeight: FontWeight
                        .bold, // Make the text bold for better visibility
                    color: Colors.white,
                  ),
                ),
              ),

              // Payment Icon button
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Billpage.id);
                },
                icon: Icon(
                  Icons.payment_rounded,
                  size: 30, // Adjusted size for visual balance
                  color:
                      Colors.white, // Ensures the icon matches the text color
                ),
              ),
            ],
          ),
        ],
        title: Text(
          'Kaufen Page',
          style: TextStyle(
            fontSize: 22, // Slightly smaller title font size for balance
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue, // AppBar background color
        elevation: 4, // Adding slight elevation for a shadow effect
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: favoriteItems.length,
        separatorBuilder: (context, index) => const Divider(
          indent: 20,
          endIndent: 20,
        ),
        itemBuilder: (context, index) {
          final product = favoriteItems[index];
          return Column(
            children: [
              ProductCard(item: product),
            ],
          ); // Closing the return statement properly
        },
      ),
    );
  }
}
