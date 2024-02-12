import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellness/views/rdttesting/default_logs.dart';
import 'package:wellness/views/rdttesting/pick_image.dart';
import 'package:wellness/views/rdttesting/yuv420-jpeg.dart';

class RDTScreenTests extends StatefulWidget {
  const RDTScreenTests({super.key});

  @override
  State<RDTScreenTests> createState() => _RDTScreenTestsState();
}

class _RDTScreenTestsState extends State<RDTScreenTests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            title: const Text('RDT Screen Test 1'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PickImage()));
            },
          ),
          ListTile(
            title: const Text('YUV420 to jpeg'),
            onTap: () async {
              await rootBundle.load('assets/1.png').then((value) {
                Uint8List data = value.buffer.asUint8List();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Yuv420ToJpeg(
                      target: data,
                    ),
                  ),
                );
              });
            },
          ),
          ListTile(
            title: const Text('Default YUV420 with logs'),
            onTap: () async {
              await rootBundle.load('assets/1.png').then((value) {
                Uint8List data = value.buffer.asUint8List();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DefaultLogs(
                      target: data,
                      formatGroup: ImageFormatGroup.yuv420,
                    ),
                  ),
                );
              });
            },
          ),
          ListTile(
            title: const Text('Default Jpeg with logs'),
            onTap: () async {
              await rootBundle.load('assets/1.png').then((value) {
                Uint8List data = value.buffer.asUint8List();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DefaultLogs(
                      target: data,
                      formatGroup: ImageFormatGroup.jpeg,
                    ),
                  ),
                );
              });
            },
          ),
          ListTile(
            title: const Text('Default BGRA8888 with logs'),
            onTap: () async {
              await rootBundle.load('assets/1.png').then((value) {
                Uint8List data = value.buffer.asUint8List();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DefaultLogs(
                      target: data,
                      formatGroup: ImageFormatGroup.bgra8888,
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
