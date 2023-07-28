

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../UI/qrViewer.dart';



class QrcodeScanner extends StatefulWidget {
  const QrcodeScanner({Key? key}) : super(key: key);

  @override
  State<QrcodeScanner> createState() => _QrcodeScannerState();
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>  const QRViewExample(),
            ));
          },
          child: const Text('qrView'),
        ),
      ),
    );
  }
}