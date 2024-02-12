import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:flutter_pixelmatching/flutter_pixelmatching.dart';

class MatchingView2 extends StatefulWidget {
  final Uint8List target1;
  final Uint8List target2;

  const MatchingView2({
    super.key,
    required this.target1,
    required this.target2,
  });

  @override
  State<MatchingView2> createState() => MatchingView2State();
}

class MatchingView2State extends State<MatchingView2> {
  // CameraController? controller;
  PixelMatching? matching;

  late Uint8List image1 = widget.target1;
  late Uint8List image2 = widget.target2;
  Image? _image1;
  imglib.Image? _image4;

  double _similarity = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // resize target image
      // Larger sizes don't significantly impact recognition performance
      // final imglib.Image? img = imglib.decodeImage(image);
      // final imglib.Image resizedImg = imglib.copyResize(img!, width: 720);
      // final imgBytes = imglib.encodeJpg(resizedImg);

      // initialize PixelMatching and Camera
      // image = image;
      initializePixelMatching();
      // initializeCamera();
    });
    super.initState();
  }

  @override
  dispose() {
    matching?.dispose();
    matching = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wellness testing"),
      ),
      body: matching != null && matching!.isInitialized
          ? Center(
              child: Column(
                children: [
                  Container(
                    color: Colors.black,
                    child: Row(
                      children: [
                        Expanded(
                          child: Image.memory(
                            image1,
                          ),
                        ),
                        Expanded(
                          child: Image.memory(
                            image2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            "${_similarity.toStringAsFixed(2)} Similar",
                          ),
                        ),
                      ),
                      Text("")
                    ],
                  ),
                  _image4 != null
                      ? Image.memory(
                          imglib.encodeJpg(_image4!),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  /// Setup PixelMatching
  initializePixelMatching() async {
    matching = PixelMatching();
    await matching?.initialize(image: image1);
    // File file = File("assets/a.yuv");
    var sim = await matching?.similarity(image2) ?? 0.0;
    imglib.Image? _image3 = await matching?.getMarkerQueryDifferenceImage();
    setState(() {
      _similarity = sim;
      _image4 = _image3;
    });
  }
}
