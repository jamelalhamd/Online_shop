import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import 'package:shopping/Screens/Privewscreen.dart';
import 'package:shopping/Screens/kaufen.dart';
import 'package:shopping/constant/constant.dart';
import 'package:shopping/method/print.dart';
import 'package:shopping/wediget/Mybutton.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Billpage extends StatefulWidget {
  static String id = 'Billpage';

  @override
  State<Billpage> createState() => _BillpageState();
}

class _BillpageState extends State<Billpage> {
  double calculattotal() {
    double totall = 0;
    for (int i = 0; i < favoriteItems.length; ++i) {
      totall += (favoriteItems[i].price) * favoriteItemscounts[i];
    }
    return totall;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Final Item"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: favoriteItems.isEmpty
          ? const Center(child: Text('No favorite items yet.'))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Gesambertrag row with total price
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Gesambertrag  : ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          '${calculattotal().toStringAsFixed(2)} \$',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .deepOrangeAccent, // Highlighting the price with a different color
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Headers for the list
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      margin: EdgeInsets.only(top: 25),
                      color: const Color.fromARGB(255, 243, 242, 242),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                ' #NO.',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Title',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Anzahl',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text(
                              'Bertrag',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // List of items
                  Expanded(
                    child: ListView.separated(
                      itemCount: favoriteItems.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final item = favoriteItems[index];
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
                                Expanded(
                                  child: Text(
                                    ' ${index + 1} -',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blueGrey,
                                    ),
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
                                Expanded(
                                  child: Text(
                                    '${favoriteItemscounts[index]}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                                // Item Price
                                Expanded(
                                  child: Text(
                                    '\$${item.price}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Text(
                                  '\$${(item.price * favoriteItemscounts[index]).toStringAsFixed(2)}',
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

                  // Pay button

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: RusableButtom(
                      width: 350,
                      text: 'Weiter to pay',
                      onPressed: () {},
                    ),
                  ),
               Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                    
                 child: RusableButtom(
             width: 120,

                      onPressed: () {
                        PdfService.previewPdf(
                          context: context,
                          wedigetcontent: pw.Column(
                            children: [
                                pw.Row(
                                       children: [
                 
                                         pw.Text(
                                      'Email : '+currectemployee.email,
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                 
                 
                                       ]
                                        ),
                              pw.Padding(
                                padding:
                                    const pw.EdgeInsets.symmetric(vertical: 16.0),
                                child: pw.Row(
                                  mainAxisAlignment: pw.MainAxisAlignment.center,
                                  children: [
                                    pw.Text(
                                      'Gesambertrag  : ',
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      '${calculattotal().toStringAsFixed(2)} \$',
                                      style: pw.TextStyle(
                                        fontSize: 20,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              pw.Divider(height: 2),
                              // Headers for the list
                              pw.Padding(
                                padding:
                                    const pw.EdgeInsets.symmetric(vertical: 10),
                                child: pw.Row(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Expanded(
                                      child: pw.Text(
                                        '#NO.',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      child: pw.Text(
                                        'Title',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      child: pw.Text(
                                        'Anzahl',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    pw.Expanded(
                                      child: pw.Text(
                                        'Price',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    pw.Text(
                                      'Bertrag',
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                 
                              // ListView for items
                              pw.ListView.separated(
                                itemCount: favoriteItems.length,
                                separatorBuilder: (context, index) => pw.Divider(
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 20,
                                ),
                                itemBuilder: (context, int index) {
                                  final item = favoriteItems[index];
                 
                                  // Add the item data inside the Container
                                  return pw.Padding(
                                    padding: const pw.EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: pw.Container(
                                      padding: const pw.EdgeInsets.all(12.0),
                                      decoration: pw.BoxDecoration(
                                        borderRadius: pw.BorderRadius.circular(8),
                                        boxShadow: [
                                          pw.BoxShadow(
                                            blurRadius: 6,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: pw.Row(
                                        children: [
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${index + 1}',
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              item.title,
                                              style: pw.TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '${favoriteItemscounts[index]}',
                                              style: pw.TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          pw.Expanded(
                                            child: pw.Text(
                                              '\$${item.price}',
                                              style: pw.TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          pw.Text(
                                            '\$${(item.price * favoriteItemscounts[index]).toStringAsFixed(2)}',
                                            style: pw.TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                 
                              pw.Divider(height: 2),
                            ],
                          ),
                          previewScreenId: Priviewscreen
                              .id, // Optional: navigate to this screen after PDF is generated
                        );
                      },
                      text: 'Print',
                     
                    ),
               )
                ],
              ),
            ),
    );
  }
}
