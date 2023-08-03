// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import "package:image_picker/image_picker.dart";
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class QrscannerScreen extends StatefulWidget {
  const QrscannerScreen({Key? key}) : super(key: key);

  @override
  State<QrscannerScreen> createState() => _QrscannerScreenState();
}

class _QrscannerScreenState extends State<QrscannerScreen> {
  String? scannerResult;
  bool isCameroMode = true;
  bool hasResult = false;
  bool hasYouResult = false;
  bool hasFaseResult = false;
  bool hasLineResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Card(
                  child: ListTile(
                    title: Text(scannerResult ?? "No Result"),
                  ),
                ),
              ),
              qrLink(context, hasResult, scannerResult),
              qrLink(context, hasFaseResult, scannerResult),
              qrLink(context, hasLineResult, scannerResult),
              qrLink(context, hasYouResult, scannerResult),
              ElevatedButton(
                onPressed: _imagePickerFromGallory,
                child: Text("Select Image"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isCameroMode = !isCameroMode;
            _startScan();
          });
        },
        child: Icon(isCameroMode ? Icons.image : Icons.qr_code_scanner_rounded),
      ),
    );
  }

  _startScan() async {
    String? cameraScanResult;
    if (isCameroMode) {
      if (await Permission.camera.request().isGranted) {
        cameraScanResult = await scanner.scan();
        setState(() {
          scannerResult = cameraScanResult;
        });
        if (scannerResult != null && scannerResult!.contains("qrfy.com")) {
          setState(() {
            hasResult = true;
          });
        }
        if (scannerResult != null && scannerResult!.contains("youtube.com")) {
          setState(() {
            hasYouResult = true;
          });
        }
        if (scannerResult != null && scannerResult!.contains("facebook.com")) {
          setState(() {
            hasFaseResult = true;
          });
        }
        if (scannerResult != null && scannerResult!.contains("line.me")) {
          setState(() {
            hasLineResult = true;
          });
        } else {
          print("Permission not denine");
          return;
        }
      }
    } else {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        String? imageScanResult = await scanner.scanPath(pickedImage.path);
        if (imageScanResult != null) {
          setState(() {
            scannerResult = imageScanResult;
          });
        }
      }
    }
  }

  Widget qrLink(context, bool? hasQrlink, String? scannerResult) {
    if (hasQrlink == true) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (scannerResult != null) {
              if (await canLaunch(scannerResult)) {
                await launch(scannerResult);
              } else {
                print("Could not launch the URL: $scannerResult");
              }
            }
          },
          child: Text("Click me"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> _imagePickerFromGallory() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      String? imageScanResult = await scanner.scanPath(pickedImage.path);
      if (imageScanResult != null) {
        setState(() {
          scannerResult = imageScanResult;
        });
      }
    }
  }
}
