import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String qrCodeResult = "Not Yet Scanned";
  final Color primaryColor = Colors.blue; // Consistent primary color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background for gradient
        elevation: 5, // Add shadow
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent], // Gradient colors
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'QR Code Scanner',
          style: TextStyle(
            color: Colors.white, // White text for contrast
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // White back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Custom back button
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20.0),
              const Text(
                "Scan QR Code",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20.0),
              // Local Image (Logo)
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/logo.png', // Path to your local image
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 30.0),
              
              const SizedBox(height: 20.0),
              const Text(
                "QR Code Result",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              GestureDetector(
                onLongPress: () {},
                child: SelectableText(
                  qrCodeResult,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                  cursorColor: primaryColor,
                  showCursor: true,
                  toolbarOptions: const ToolbarOptions(
                    copy: true,
                    cut: true,
                    paste: true,
                    selectAll: true,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Scan Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  elevation: 3,
                ),
                onPressed: () async {
                  try {
                    ScanResult codeScanner = await BarcodeScanner.scan();
                    setState(() {
                      qrCodeResult = codeScanner.rawContent;
                    });
                  } on PlatformException catch (e) {
                    if (e.code == BarcodeScanner.cameraAccessDenied) {
                      setState(() {
                        qrCodeResult = "Camera permission was denied";
                      });
                    } else {
                      setState(() {
                        qrCodeResult = "Unknown error: $e";
                      });
                    }
                  } on FormatException {
                    setState(() {
                      qrCodeResult = "You pressed the back button before scanning anything";
                    });
                  } catch (e) {
                    setState(() {
                      qrCodeResult = "Unknown error: $e";
                    });
                  }
                },
                child: const Text(
                  "Scan QR Code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}