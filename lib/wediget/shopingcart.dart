import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping/Screens/updatepage.dart';
import 'package:shopping/modal/itemmodal.dart';

class ShopingCart extends StatefulWidget {
  const ShopingCart({
    super.key,
    required this.producktmodal,
  });
  final Producktmodal producktmodal;

  @override
  State<ShopingCart> createState() => _ShopingCartState();
}

class _ShopingCartState extends State<ShopingCart> {
  bool isFavorite = false;
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          UpdatePage.id,
          arguments: {
            'producktmodal': widget.producktmodal, // Pass as a Map
          },
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
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
            height: 230,
            width: 230,
            child: Card(
              color: Colors.white, // Card background color
              elevation: 10, // Shadow effect from the Card itself
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12), // Rounded corners for card
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align content to the left
                  children: [
                    Text(
                      widget.producktmodal.title.substring(
                          0, 15), // Fixed: `widget.productmodal.title`
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Adjust icon alignment
                      children: [
                        Text('${widget.producktmodal.price} \$'),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          icon: Icon(
                            isFavorite
                                ? FontAwesomeIcons.solidHeart
                                : Icons.add,
                          ),
                          color: Colors.red, // Icon color (red)
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -70,
            left: 80,
            child: Image.network(
              widget.producktmodal.image, // Fixed: `widget.productmodal.image`
              height: 100,
              width: 80,
              // Set height for the image
              fit: BoxFit.cover, // Ensure the image scales properly
            ),
          ),
        ],
      ),
    );
  }
}
