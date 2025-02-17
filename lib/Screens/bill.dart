import 'package:flutter/material.dart';
import 'package:shopping/Screens/kaufen.dart';
import 'package:shopping/modal/itemmodal.dart';
import 'package:shopping/wediget/Mybutton.dart';
import 'package:shopping/constant/constant.dart';

class Billpage extends StatefulWidget {
  static String id = 'Billpage';

  @override
  State<Billpage> createState() => _BillpageState();
}

class _BillpageState extends State<Billpage> {
  @override
  Widget build(BuildContext context) {
    List<Producktmodal> lastFavoriteItems = favoriteItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Items"),
        centerTitle: true,
      ),
      body: lastFavoriteItems.isEmpty
          ? const Center(child: Text('No favorite items yet.'))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: lastFavoriteItems.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = lastFavoriteItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Item ID
                                Text(
                                  ' ${index + 1} -',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                // Item Title
                                Expanded(
                                  child: Text(
                                    item.title.length > 10
                                        ? item.title.substring(0, 10) + '...'
                                        : item.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                // Item Description
                                Expanded(
                                  child: Text(
                                    item.description.length > 15
                                        ? item.description.substring(0, 15) +
                                            '...'
                                        : item.description,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                // Item Price
                                Text(
                                  '\$${item.price}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  RusableButtom(
                    width: 350,
                    text: 'Weiter to Kaufen',
                    onPressed: () {
                      Navigator.pushNamed(context, Kaufen.id);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
