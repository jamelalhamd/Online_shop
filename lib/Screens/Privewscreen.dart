import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class Priviewscreen extends StatelessWidget {
  static String id = 'Priviewview';

  @override
  Widget build(BuildContext context) {
    // Extrahieren der Argumente (doc) von der vorherigen Seite
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final doc = args?['doc'] as pw.Document?;

    // Wenn kein doc vorhanden ist, zeigen wir eine Fehlermeldung an
    if (doc == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Print Preview'),
        ),
        body: Center(
          child: Text('Kein Dokument verfügbar'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Print Preview'),
      ),
      body: PdfPreview(
        build: (format) =>
            doc.save(), // Erstellen Sie die PDF-Datei mit dem Format
        allowSharing: true,
        allowPrinting: true,
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: 'Print bill',
      ),
    );
  }
}
