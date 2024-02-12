import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'matching_view2.dart';

class PickImage extends StatefulWidget {
  const PickImage({super.key});

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  Uint8List? target1, target2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness Testing'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            target2 != null ? Image.memory(target2!) : const SizedBox(),
            buildFromGalleryImages(),
          ],
        ),
      ),
    );
  }

  Widget buildFromGalleryImages() {
    return Column(
      children: [
        (target2 != null)
            ? Expanded(
                child: Image.memory(
                  target2!,
                ),
              )
            : const SizedBox(),
        TextButton.icon(
          label: const Text("From Gallery Images"),
          icon: const Icon(Icons.photo),
          onPressed: () async {
            target1 = await rootBundle.load('assets/1.png').then((value) {
              Uint8List data = value.buffer.asUint8List();
              return data;
            });
            ImagePicker().pickImage(source: ImageSource.gallery).then(
              (value) async {
                var temp = await value?.readAsBytes();
                setState(() {
                  target2 = temp;
                });
              },
            );
          },
        ),
        TextButton.icon(
          label: const Text("Compare"),
          icon: const Icon(Icons.compare),
          onPressed: () async {
            if (target1 != null && target2 != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MatchingView2(
                      target1: target1!,
                      target2: target2!,
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
