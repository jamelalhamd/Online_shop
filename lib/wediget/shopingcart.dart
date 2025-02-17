import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping/Screens/updatepage.dart';
import 'package:shopping/constant/constant.dart';
import 'package:shopping/modal/itemmodal.dart';

class ShopingCart extends StatefulWidget {
  ShopingCart({
    super.key,
    required this.producktmodal,
    this.isfavoirt = false,
  });

  final Producktmodal producktmodal;
  final bool? isfavoirt;

  @override
  State<ShopingCart> createState() => _ShopingCartState();
}

class _ShopingCartState extends State<ShopingCart> {
  static final Map<int, bool> _favoritesMap = {};

  bool get _checkfavorit {
    return _favoritesMap[widget.producktmodal.id] ?? false;
  }

  void _toggleFavorite() {
    setState(() {
      // Toggle the favorite status
      _favoritesMap[widget.producktmodal.id] = !_checkfavorit;

      if (_favoritesMap[widget.producktmodal.id]!) {
        favoriteItems.add(widget.producktmodal);
      } else {
        favoriteItems.removeWhere((item) => item.id == widget.producktmodal.id);
      }
    });
  }

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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 4),
                  blurRadius: 50,
                  spreadRadius: 0,
                ),
              ],
            ),
            height: 230,
            width: 230,
            child: Card(
              color: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.producktmodal.title.substring(0, 15),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.producktmodal.price} \$'),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: _checkfavorit
                              ? Icon(FontAwesomeIcons.solidHeart)
                              : Icon(FontAwesomeIcons.heart),
                          color: Colors.red,
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
              widget.producktmodal.image,
              height: 100,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
