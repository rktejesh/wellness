import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';

class ImagePlaceholder extends StatefulWidget {
  final Map<String, dynamic> res;
  const ImagePlaceholder({Key? key, required this.res}) : super(key: key);

  @override
  State<ImagePlaceholder> createState() => _ImagePlaceholderState();
}

class _ImagePlaceholderState extends State<ImagePlaceholder> {
  String getPath(String urlString) {
    Uri uri = Uri.parse(urlString);

    // Get the path without the domain
    String pathWithoutDomain = "s3://wellnessapp${uri.path}";
    return pathWithoutDomain;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.res['url'],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Text(widget.res['url']),
            // ),
            FutureBuilder(
              future: ApiService()
                  .predict({"image_path": getPath(widget.res['url'])}),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );

                    // if we got our data
                  } else if (snapshot.hasData) {
                    // Extracting data from snapshot object
                    final data = snapshot.data;
                    double res = data?['level'];
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: Text(
                            "PH Level: ${res.toStringAsPrecision(2)}",
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(
                        //       Dimensions.PADDING_SIZE_DEFAULT),
                        //   child: Text(
                        //     "Result: ${data?['is_classification']}",
                        //     style: const TextStyle(
                        //         fontSize: 20, color: Colors.blue),
                        //   ),
                        // ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                } else {
                  return const CircularProgressIndicator();
                }
              }),
            ),
            const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Text(
                "In case result is different from your actual, and above ML model, Please enter your true value below (optional):",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
              child: Center(
                child: CustomTextFormField(
                  title: "",
                ),
              ),
            ),
            customButton("Submit", () {})
          ],
        ),
      ),
    );
  }
}
