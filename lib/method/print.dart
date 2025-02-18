import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfService {
  static Future<void> previewPdf({
    required BuildContext context,
    required pw.Widget wedigetcontent,
    String? previewScreenId,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: wedigetcontent,
          );
        },
      ),
    );

    // Navigate to preview screen if provided
    if (previewScreenId != null) {
      Navigator.popAndPushNamed(context, previewScreenId,
          arguments: {'doc': pdf});
    }
  }

  static Future<void> generateandsharePdf({
    required BuildContext context,
    required pw.Widget wedigetcontent,
    String? previewScreenId,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: wedigetcontent,
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
    );

    // Navigate to preview screen if provided
    if (previewScreenId != null) {
      Navigator.popAndPushNamed(context, previewScreenId);
    }
  }

  static Future<void> printPdf({
    required BuildContext context,
    required pw.Widget wedigetcontent,
    String? previewScreenId,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: wedigetcontent,
          );
        },
      ),
    );

    // PDF Preview/Print
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    // Navigate to preview screen if provided
    if (previewScreenId != null) {
      Navigator.popAndPushNamed(context, previewScreenId);
    }
  }
}
//pw    use pw. befor the wediget inside the method:

//===================preview page=====================
/*

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





*/
