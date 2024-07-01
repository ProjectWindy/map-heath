import 'package:flutter/material.dart';
import 'package:health_app/introduction_animation/Widget/generator_qr_code.dart';
import 'package:health_app/introduction_animation/Widget/scan_qr_code.dart';

class Qr extends StatefulWidget {
  const Qr({super.key});

  @override
  State<Qr> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Qr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner and Generator'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScanQRcode(),
                    ),
                  );
                });
              },
              child: const Text('Quét QR để xem thông tin thực phẩm'),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => GeneratorQRcode(),
                    ),
                  );
                });
              },
              child: const Text('Tạo QR lưu giá trị thực phẩm'),
            ),
          ],
        ),
      ),
    );
  }
}
