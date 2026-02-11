
import 'package:flutter/material.dart';

class ViewScreen extends StatelessWidget {
  final String data;
  const ViewScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Asset Details"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code, size: 80),
                const SizedBox(height: 20),
                const Text("Scanned QR Data",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text(data, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
