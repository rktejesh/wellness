import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:flutter_pixelmatching/flutter_pixelmatching.dart';
import 'package:wellness/image_preview.dart';
import 'package:wellness/upload_files.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/loading_screen.dart';

class MatchingView extends StatefulWidget {
  final Uint8List target;
  final int testId;

  const MatchingView({
    super.key,
    required this.target,
    required this.testId,
  });

  @override
  State<MatchingView> createState() => MatchingViewState();
}

class MatchingViewState extends State<MatchingView> {
  CameraController? controller;
  PixelMatching? matching;
  var formData;
  bool isLoading = false;
  Uint8List imageBytes = Uint8List(0);
  Uint8List? pngBytes;
  late Map<String, dynamic> response;
  var dio = Dio();
  FirebaseDatabase database = FirebaseDatabase.instance;

  late Uint8List image = widget.target;
  Image? _image1;
  final StreamController<Image> _imageStreamController =
      StreamController<Image>.broadcast();
  final StreamController<imglib.Image> _imageStreamController2 =
      StreamController<imglib.Image>.broadcast();

  imglib.Image? _capturedImage;

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

      // initialize PixelMatching and Camera
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text("Wellness testing"),
          ),
      body: isLoading
          ? const LoadingScreen()
          : controller != null &&
                  controller!.value.isInitialized &&
                  matching != null &&
                  matching!.isInitialized
              ? Center(
                  child: Column(
                    children: [
                      _capturedImage != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.memory(
                                  imglib.encodeJpg(_capturedImage!),
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    customButton("Retake Image", () {
                                      setState(() {
                                        _capturedImage = null;
                                        controller
                                            ?.startImageStream(cameraStream);
                                      });
                                    }),
                                    customButton(
                                        "Submit",
                                        () async => {
                                              setState(() {
                                                isLoading = true;
                                              }),
                                              if (_capturedImage != null)
                                                {
                                                  imageBytes = _capturedImage!
                                                      .getBytes(),
                                                  pngBytes = imglib.encodePng(
                                                      _capturedImage!),
                                                  formData = FormData.fromMap({
                                                    'path': 'images',
                                                    'files':
                                                        MultipartFile.fromBytes(
                                                      pngBytes!.toList(),
                                                      filename: "image.png",
                                                    )
                                                  }),
                                                  response = await UploadFiles()
                                                      .uploadImage(formData),
                                                  setState(() {
                                                    isLoading = false;
                                                  }),
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ImagePlaceholder(
                                                        res: response,
                                                        testId: widget.testId,
                                                      ),
                                                    ),
                                                  )
                                                }
                                              else
                                                {
                                                  setState(() {
                                                    isLoading = false;
                                                  }),
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Image not selected')),
                                                  ),
                                                }
                                            })
                                  ],
                                ),
                              ],
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Colors.black,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CameraPreview(
                                      controller!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      _capturedImage == null
                          ? Center(
                              child: Text(
                                "${_similarity.toStringAsFixed(2)} Similar",
                              ),
                            )
                          : const SizedBox(),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           IconButton.outlined(
                      //               onPressed: () => imageRotation(-90),
                      //               icon: const Icon(
                      //                   Icons.rotate_90_degrees_ccw_outlined)),
                      //           IconButton.outlined(
                      //               onPressed: () => imageRotation(90),
                      //               icon: const Icon(
                      //                   Icons.rotate_90_degrees_cw_outlined)),
                      //         ],
                      //       ),
                      //     ),
                      //     Expanded(
                      //       child: Center(
                      //         child: Text(
                      //           "${_similarity.toStringAsFixed(2)} Similar",
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                      // _image1 != null ? _image1! : Container(),
                      // StreamBuilder<imglib.Image>(
                      //   stream: _imageStreamController2.stream,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return Container(
                      //           padding: const EdgeInsets.all(16.0),
                      //           child: snapshot.data != null
                      //               ? snapshot.data!.width > 0
                      //                   ? Image.memory(
                      //                       imglib.encodeJpg(snapshot.data!),
                      //                     )
                      //                   : const Text('No image available')
                      //               : Container());
                      //     } else {
                      //       return Container(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: const Text('No image available'),
                      //       );
                      //     }
                      //   },
                      // ),
                      // StreamBuilder<Image>(
                      //   stream: _imageStreamController.stream,
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return Container(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: snapshot.data,
                      //       );
                      //     } else {
                      //       return Container(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: const Text('No image available'),
                      //       );
                      //     }
                      //   },
                      // ),
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
    setState(() {});
  }

  /// Setup Camera
  ///
  initializeCamera() async {
    final cameras = await availableCameras();
    final camera = cameras[0];
    controller = CameraController(
      camera,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.yuv420
          : Platform.isIOS
              ? ImageFormatGroup.bgra8888
              : ImageFormatGroup.yuv420,
    );
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
    var id = DateTime.now().millisecondsSinceEpoch;
    // DatabaseReference ref = FirebaseDatabase.instance.ref("logs/$id");

    final bool isProcessed = _processing;
    final bool isDelayed =
        DateTime.now().millisecondsSinceEpoch - _processTimestamp > 50;
    if (isProcessed || !isDelayed) return;
    _processing = true;
    // var tempCameraImage = await convertYUV420toImageColor(cameraImage);
    _similarity = await matching?.similarity(cameraImage) ?? 0.0;
    if (_similarity > 0.70) {
      // Image? _image2 = await convertYUV420toImageColor(cameraImage);
      // imglib.Image? _image3 = await matching?.getMarkerQueryDifferenceImage();
      // if (_image2 != null) {
      //   _imageStreamController.add(_image2);
      // }
      imglib.Image? _image3 = await matching?.getRDTStripArea(cameraImage);
      // if (_image3 != null) {
      //   _imageStreamController2.add(_image3);
      // }
      setState(() {
        _capturedImage = _image3;
        controller?.stopImageStream();
      });
      // await ref.set({"result": "true", "value": _similarity.toString()});
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
  Future<imglib.Image?> convertYUV420toImageColor(CameraImage image) async {
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

      return img;
      // imglib.JpegEncoder jpgEncoder = imglib.JpegEncoder();
      // Uint8List jpg = jpgEncoder.encode(img);
      // muteYUVProcessing = false;
      // return Image.memory(jpg);
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:$e");
    }
    return null;
  }
}
