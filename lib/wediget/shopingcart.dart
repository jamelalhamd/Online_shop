import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping/modal/itemmodal.dart';

class ShopingCart extends StatefulWidget {
  // Fixed class name: `Producktmodal` -> `ProductModal`
  const ShopingCart({
    super.key,
  });

  @override
  State<ShopingCart> createState() => _ShopingCartState();
}

class _ShopingCartState extends State<ShopingCart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          height: 130,
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
                    '20 \$', // Fixed: `widget.productmodal.title`
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -75,
          left: 80,
          child: Image.network(
            'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg', // Fixed: `widget.productmodal.image`
            height: 120, // Set height for the image
            fit: BoxFit.cover, // Ensure the image scales properly
          ),
        ),
      ],
    );
  }
}
