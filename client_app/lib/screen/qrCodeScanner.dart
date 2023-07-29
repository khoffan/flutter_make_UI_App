// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
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
  bool hasResult = false;

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
              hasResult
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (scannerResult != null) {
                            if (await canLaunch(scannerResult!)) {
                              await launch(scannerResult!);
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
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startScan,
        child: Icon(Icons.qr_code_scanner_rounded),
      ),
    );
  }

  _startScan() async {
    if (await Permission.camera.request().isGranted) {
      String? cameraScanResult = await scanner.scan();
      setState(() {
        scannerResult = cameraScanResult;
      });
      if (scannerResult != null && scannerResult!.contains("qrfy.com")) {
        setState(() {
          hasResult = true;
        });
      }
    } else {
      print("Permission not granted");
    }
  }
}
