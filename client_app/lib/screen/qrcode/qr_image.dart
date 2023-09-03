import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGenerator extends StatelessWidget {
  String qrData = ""; // The data to encode in the QR code

  QRCodeGenerator({required this.qrData});

  @override
  Widget build(BuildContext context) {
    String result = "https://promptpay.io/${qrData}";

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: result,
              version: QrVersions.auto, // Provide the data to encode here
              size: 200,
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
