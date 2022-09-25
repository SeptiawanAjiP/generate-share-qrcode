import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class QRCodePlayground extends StatefulWidget {
  @override
  _QRCodePlaygroundState createState() => _QRCodePlaygroundState();
}

class _QRCodePlaygroundState extends State<QRCodePlayground> {
  final TextEditingController tfController = TextEditingController();
  File? _imageFile;
  bool permissionGranted = false;
  //define
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        children: [
          tfController.text.isEmpty
              ? SizedBox.shrink()
              : RepaintBoundary(
                  key: previewContainer,
                  child: Container(
                      decoration: BoxDecoration(color: Colors.amber),
                      child: QrImage(data: tfController.text))),
          SizedBox(height: 20),
          TextField(
            controller: tfController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Generate QR Code'),
            onPressed: () => setState(() {}),
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
          RaisedButton(
            onPressed: () {
              if (tfController.text.isEmpty) {
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Generate your QR code first')));
              } else {
                // shareScreenshot();
                ShareFilesAndScreenshotWidgets().shareScreenshot(
                    previewContainer,
                    originalSize,
                    "Title",
                    "Name.jpeg",
                    "image/jpeg",
                    text: "This is the caption!");
              }
            },
            color: Colors.blue,
            textColor: Colors.white,
            child: Text('Share QR code'),
            padding: EdgeInsets.symmetric(vertical: 12),
          ),
        ],
      ),
    );
  }
}
