import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  static const String id = 'homepage';
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        decoration: BoxDecoration(
          // Subtle grey background color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow with opacity
              offset: Offset(0, 4), // Vertical offset
              blurRadius: 50, // Blur radius for soft shadow
              spreadRadius: 0, // No spread, just the blur
            ),
          ],
        ),
        height: 130,
        width: 230,
        child: Card(
          color: Colors.white, // Card background color
          elevation: 10, // Shadow effect from the Card itself
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners for card
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to the left
              children: [
                Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Adjust icon alignment
                  children: [
                    Text('Details'),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesomeIcons
                          .heart), // Heart icon from FontAwesome
                      color: Colors.red, // Icon color (red)
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
