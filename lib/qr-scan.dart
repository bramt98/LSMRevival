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
          foregroundColor: Colors.white
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          MobileScanner(
            onDetect: (barcode, args) {
              setState(() {
                _scanResult = barcode.rawValue;
                if (_scanResult!.contains('youtube.com')) {
                  Navigator.pop(context, _scanResult);
                }
              });
            },
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            width: 200,
            height: 200,
          ),
          Positioned(
            bottom: 16,
            child: (_scanResult != null)
                ? Text('QR Code Data: $_scanResult')
                : Text.rich(
              TextSpan(
                text: 'Scan een ',
                style: TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    text: 'QR code',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}