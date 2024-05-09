import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  String? _scanResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: MobileScanner(
              onDetect: (barcode, args) {
                setState(() {
                  _scanResult = barcode.rawValue;
                  if (_scanResult!.contains('youtube.com')) {
                    Navigator.pop(context, _scanResult);
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (_scanResult!= null)
                  ? Text('QR Code Data: $_scanResult')
                  : Text('Scan een QR code'),
            ),
          ),
        ],
      ),
    );
  }
}