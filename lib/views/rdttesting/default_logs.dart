import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:flutter_pixelmatching/flutter_pixelmatching.dart';

class DefaultLogs extends StatefulWidget {
  final Uint8List target;
  final ImageFormatGroup formatGroup;

  const DefaultLogs({
    super.key,
    required this.target,
    required this.formatGroup,
  });

  @override
  State<DefaultLogs> createState() => DefaultLogsState();
}

class DefaultLogsState extends State<DefaultLogs> {
  CameraController? controller;
  PixelMatching? matching;

  late Uint8List image = widget.target;
  Image? _image1;
  final StreamController<Image> _imageStreamController =
      StreamController<Image>.broadcast();
  final StreamController<imglib.Image> _imageStreamController2 =
      StreamController<imglib.Image>.broadcast();
  final StreamController<imglib.Image> _imageStreamController3 =
      StreamController<imglib.Image>.broadcast();
  final _textStreamController = StreamController<String>();
  String _accumulatedLogs = '';

  /// PixelMatching processing
  bool _processing = false;

  /// PixelMatching last processed timestamp
  int _processTimestamp = 0;

  double _similarity = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // resize target image
      // Larger sizes don't significantly impact recognition performance
      // final imglib.Image? img = imglib.decodeImage(image);
      // final imglib.Image resizedImg = imglib.copyResize(img!, width: 720);
      // final imgBytes = imglib.encodeJpg(resizedImg);

      // // initialize PixelMatching and Camera
      // image = imgBytes;
      initializePixelMatching();
      initializeCamera();
    });
    super.initState();
  }

  @override
  dispose() {
    matching?.dispose();
    matching = null;
    controller?.stopImageStream();
    controller?.dispose();
    controller = null;
    _imageStreamController.close();
    _textStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Testing using ${widget.formatGroup}"),
      ),
      body: controller != null &&
              controller!.value.isInitialized &&
              matching != null &&
              matching!.isInitialized
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: Colors.black,
                    child: Row(
                      children: [
                        CameraPreview(
                          controller!,
                        ),
                        StreamBuilder<imglib.Image>(
                          stream: _imageStreamController3.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                  child: snapshot.data != null
                                      ? snapshot.data!.width > 0
                                          ? Image.memory(
                                              imglib.encodeJpg(snapshot.data!),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.49,
                                            )
                                          : const Text('No image available')
                                      : Container());
                            } else {
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                child: const Text('No image available'),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton.outlined(
                                onPressed: () => imageRotation(-90),
                                icon: const Icon(
                                    Icons.rotate_90_degrees_ccw_outlined)),
                            IconButton.outlined(
                                onPressed: () => imageRotation(90),
                                icon: const Icon(
                                    Icons.rotate_90_degrees_cw_outlined)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "${_similarity.toStringAsFixed(2)} Similar",
                          ),
                        ),
                      )
                    ],
                  ),
                  StreamBuilder<imglib.Image>(
                    stream: _imageStreamController2.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: snapshot.data != null
                                ? snapshot.data!.width > 0
                                    ? Image.memory(
                                        imglib.encodeJpg(snapshot.data!),
                                      )
                                    : const Text('No image available')
                                : Container());
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(16.0),
                          child: const Text('No image available'),
                        );
                      }
                    },
                  ),
                  // StreamBuilder<PixelMatchingState>(
                  //   stream: matching?.getStateCode().asStream(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return ClipRect(
                  //         child: Align(
                  //           alignment: Alignment.bottomLeft,
                  //           child: SizedBox(
                  //             width: double.infinity,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 "${snapshot.data!}",
                  //                 style: const TextStyle(fontSize: 16.0),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   },
                  // ),
                  // StreamBuilder<String>(
                  //   stream: _textStreamController.stream,
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       _accumulatedLogs =
                  //           "${snapshot.data!}\n$_accumulatedLogs";
                  //       return ClipRect(
                  //         child: Align(
                  //           alignment: Alignment.bottomLeft,
                  //           child: SizedBox(
                  //             width: double.infinity,
                  //             height: MediaQuery.of(context).size.height * 0.25,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Text(
                  //                 _accumulatedLogs,
                  //                 style: const TextStyle(fontSize: 16.0),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     }
                  //   },
                  // )
                  ClipRect(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            _accumulatedLogs,
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  )
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
    await matching?.initialize(image: image);
    // _textStreamController.add("Reference Image loaded: ${image.length}");
    setState(() {
      _accumulatedLogs = "Reference Image loaded: ${image.length}\n";
    });
  }

  /// Setup Camera
  ///
  initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras[0];
    controller = CameraController(camera, ResolutionPreset.high,
        enableAudio: false, imageFormatGroup: widget.formatGroup);
    await controller?.initialize();
    controller?.startImageStream(cameraStream);
    setState(() {});
  }

  /// PixelMatching similarity check
  ///
  /// 1. Check if PixelMatching is processing
  ///    - If processing, skip
  /// 2. Check if PixelMatching is delayed
  ///    - If not delayed, skip
  /// 3. Process PixelMatching
  cameraStream(CameraImage cameraImage) async {
    final bool isProcessed = _processing;
    final bool isDelayed =
        DateTime.now().millisecondsSinceEpoch - _processTimestamp > 50;
    if (isProcessed || !isDelayed) return;
    _processing = true;
    String format;
    if (cameraImage.format.group == ImageFormatGroup.yuv420) {
      format = "yuv420";
    } else if (cameraImage.format.group == ImageFormatGroup.bgra8888) {
      format = "bgra8888";
    } else if (cameraImage.format.group == ImageFormatGroup.jpeg) {
      format = "jpeg";
    } else if (cameraImage.format.group == ImageFormatGroup.unknown) {
      format = "unknown";
    } else {
      format = "unknown";
    }
    var _sim = await matching?.similarity(cameraImage);
    // _textStreamController.add("Processing... $format $_sim");
    setState(() {
      _accumulatedLogs = "Processing... $format $_sim\n$_accumulatedLogs";
    });
    _similarity = _sim ?? 0;
    if (_similarity > 0.6) {
      // _textStreamController.add("Found a match");
      setState(() {
        _accumulatedLogs = "Found a match\n$_accumulatedLogs";
      });
      try {
        imglib.Image? _image3 = await matching?.getMarkerQueryDifferenceImage();
        if (_image3 != null) {
          _imageStreamController2.add(_image3);
        } else {
          // _textStreamController.add("Null for getMarkerQueryDifferenceImage");
          setState(() {
            _accumulatedLogs =
                "Null for getMarkerQueryDifferenceImage\n$_accumulatedLogs";
          });
        }
      } catch (e) {
        // _textStreamController.add("Error for getMarkerQueryDifference: $e");
        setState(() {
          _accumulatedLogs =
              "Error for getMarkerQueryDifference: $e\n$_accumulatedLogs";
        });
      }

      try {
        imglib.Image? _image4 = await matching?.getRDTStripArea(cameraImage);
        if (_image4 != null) {
          _imageStreamController3.add(_image4);
        } else {
          setState(() {
            // _textStreamController.add("Null for getRDTStripArea");
            _accumulatedLogs = "Null for getRDTStripArea\n$_accumulatedLogs";
          });
        }
      } catch (e) {
        setState(() {
          // _textStreamController.add("Error for getRDTStripArea: $e");
          _accumulatedLogs = "Error for getRDTStripArea: $e\n$_accumulatedLogs";
        });
      }
    }
    if (kDebugMode) {
      print(_similarity);
    }
    _processing = false;
    _processTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  /// image rotation
  imageRotation(int angle) async {
    final imglib.Image? img = imglib.decodeImage(image);
    final imglib.Image rotatedImg = imglib.copyRotate(img!, angle: angle);
    final imgBytes = imglib.encodeJpg(rotatedImg);
    image = imgBytes;
    initializePixelMatching();
  }

  static const shift = (0xFF << 24);
  Future<Image?> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel ?? 0;

      print("uvRowStride: $uvRowStride");
      print("uvPixelStride: $uvPixelStride");

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img =
          imglib.Image(width: width, height: height); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          // img.data![index] = shift | (b << 16) | (g << 8) | r;
          final c = shift | (b << 16) | (g << 8) | r;
          Color color = Color(c);

          int red = (color.value >> 16) & 0xFF;
          int green = (color.value >> 8) & 0xFF;
          int blue = color.value & 0xFF;
          // imglib.Color color = c;
          img.data!.setPixelRgbSafe(
            x,
            y,
            red,
            green,
            blue,
          );
        }
      }

      imglib.PngEncoder pngEncoder =
          imglib.PngEncoder(level: 0, filter: imglib.PngFilter.paeth);
      Uint8List png = pngEncoder.encode(img);
      // muteYUVProcessing = false;
      return Image.memory(png);
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:$e");
    }
    return null;
  }
}
