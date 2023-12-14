import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wellness/image_preview.dart';
import 'package:wellness/services/ui_helper.dart'
    if (dart.library.io) 'package:wellness/services/mobile_ui_helper.dart'
    if (dart.library.html) 'package:wellness/services/web_ui_helper.dart';
import 'package:wellness/upload_files.dart';
import 'package:wellness/upload_files_data.dart';
import 'package:wellness/utils/dimensions.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});
  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _imageFile;
  Uint8List? img;
  final picker = ImagePicker();
  var formData;
  bool isLoading = false;
  SnackBar snackBar = SnackBar(
    content: Container(),
  );
  late Map<String, dynamic> response;
  var dio = Dio();
  Future pickImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 30,
    );
    final imagedata = await pickedFile?.readAsBytes();
    setState(() {
      _imageFile = File(pickedFile!.path);
      img = imagedata;
    });
  }

  Future<void> _cropImage() async {
    if (_imageFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: _imageFile!.path,
        uiSettings: buildUiSettings(context),
      );
      if (croppedFile != null) {
        setState(() {
          _imageFile = File(croppedFile.path);
        });
      }
    }
  }

  var idcard;

  @override
  Widget build(BuildContext context) {
    UploadFilesData upload;
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 56.h,
        // backgroundColor: const Color(0Xff15609c),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 12.w,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      "Capture Your Image",
                      style: TextStyle(
                        color: const Color(0Xff15609c),
                        fontSize: 19.h,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      height: 200.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: _imageFile != null
                            ? kIsWeb
                                ? Image.memory(img!)
                                : Image.file(_imageFile!)
                            : TextButton(
                                onPressed: pickImage,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: const Color(0Xff15609c),
                                  size: 50.sp,
                                  semanticLabel: "Take Picture",
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Container(
                      child: _imageFile != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: const Color(0Xff15609c),
                                    size: 30.sp,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _imageFile = null;
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 100.w,
                                ),
                                GestureDetector(
                                  child: Icon(
                                    Icons.edit,
                                    color: const Color(0Xff15609c),
                                    size: 30.sp,
                                  ),
                                  onTap: () {
                                    _cropImage();
                                  },
                                )
                              ],
                            )
                          : const Text(""),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: const EdgeInsets.all(12),
                            minimumSize:
                                Size(MediaQuery.of(context).size.width, 38.h),
                            alignment: Alignment.center,
                            backgroundColor: const Color(0xFF14619C)),
                        onPressed: () async => {
                          setState(() {
                            isLoading = true;
                          }),
                          if (_imageFile != null)
                            {
                              formData = FormData.fromMap({
                                'path': 'images',
                                'files': await MultipartFile.fromFile(
                                    _imageFile!.path,
                                    filename: "image")
                              }),
                              response =
                                  await UploadFiles().uploadImage(formData),
                              setState(() {
                                isLoading = false;
                              }),
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ImagePlaceholder(res: response)),
                              )
                            }
                          else
                            {
                              setState(() {
                                isLoading = false;
                              }),
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Image not selected')),
                              ),
                            }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    // const Padding(
                    //   padding:
                    //       EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    //   child: Text(
                    //       "Step 1: Put the strip on a flat surface and take the photo"),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal:
                    //           Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                    //   child: Image.asset('assets/images/1.png'),
                    // ),
                    // const Padding(
                    //   padding:
                    //       EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    //   child: Text(
                    //       "Step 2: Now crop the photo to exactly have the test area as shown below"),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal:
                    //           Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                    //   child: Image.asset('assets/images/2.png'),
                    // ),
                    // const Padding(
                    //   padding:
                    //       EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                    //   child: Text(
                    //       "Step 3: Submit once final copy is completed to get the results"),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
          margin: const EdgeInsets.only(
              top: 30, left: 20.0, right: 20.0, bottom: 20.0),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Upload Image",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
