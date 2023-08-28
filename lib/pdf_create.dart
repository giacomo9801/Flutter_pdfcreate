// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> main() async {
  runApp(const PdfCreate('Printing Demo'));
}

class PdfCreate extends StatelessWidget {
  const PdfCreate(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(
                "Ciao $title",
                style: pw.TextStyle(
                  font: font,
                  fontSize: 50.0,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                textAlign: pw.TextAlign.center,
                "Questo è un file generato automaticamente",
                style: const pw.TextStyle(
                  fontSize: 35.0,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(
                child: pw.Container(
                  width: 200.0,
                  height: 200.0,
                  child: pw.FlutterLogo(),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }
}
