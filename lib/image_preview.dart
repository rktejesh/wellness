import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/blocs/dashboard/dashboard_bloc.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_text_field.dart';

class ImagePlaceholder extends StatefulWidget {
  final Map<String, dynamic> res;
  final int testId;
  const ImagePlaceholder({
    Key? key,
    required this.res,
    required this.testId,
  }) : super(key: key);

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

  String url = "";
  Map<String, dynamic> _data = {};
  double predicted_res = 0;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String? id;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      await ApiService().predict(
          {"image_path": getPath(widget.res['url'])}).then((value) async {
        Map<String, dynamic> data = {
          "data": {
            "image_url": widget.res['url'],
            "predicted_value": value['level'],
            // "pre_test_requirement": int.parse(widget.preTestId),
            // "horse_info": int.parse(widget.horseId),
          }
        };
        await ApiService()
            .sendImage(data, widget.testId.toString())
            .then((testDataRes) {
          setState(() {
            _data = value;
            predicted_res = value['level'];
            id = testDataRes;
          });
        });
      });
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  final TextEditingController correctResController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Image.network(
                    widget.res['url'],
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: Text(
                            "PH Level: ${predicted_res.toStringAsPrecision(2)}",
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                          child: Text(
                            "In case result is different from your actual, and above ML model, Please enter your true value below (optional):",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: Center(
                            child: CustomTextFormField(
                              title: "",
                              textEditingController: correctResController,
                            ),
                          ),
                        ),
                        customButton("Submit", () async {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Map<String, dynamic> data = {
                              "data": {
                                "correct_value": correctResController.text,
                              }
                            };
                            await ApiService()
                                .sendImage(data, widget.testId.toString())
                                .then((value) => {
                                      setState(() {
                                        isLoading = false;
                                      }),
                                      if (value == null)
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text("Error uploading data."),
                                            ),
                                          )
                                        }
                                      else
                                        {
                                          BlocProvider.of<DashboardBloc>(
                                                  context)
                                              .add(DashboardFetchData()),
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Data uploaded Successfully."),
                                            ),
                                          )
                                        }
                                    });
                            setState(() {
                              isLoading = false;
                            });
                          }
                        })
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
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: Text(widget.res['url']),
                  // ),
                  // FutureBuilder(
                  //   future: ApiService()
                  //       .predict({"image_path": getPath(widget.res['url'])}),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.done) {
                  //       // If we got an error
                  //       if (snapshot.hasError) {
                  //         return Center(
                  //           child: Text(
                  //             '${snapshot.error} occurred',
                  //             style: const TextStyle(fontSize: 18),
                  //           ),
                  //         );

                  //         // if we got our data
                  //       } else if (snapshot.hasData) {
                  //         // Extracting data from snapshot object
                  //         final data = snapshot.data;
                  //         double res = data?['level'];
                  //         return Column(
                  //           mainAxisSize: MainAxisSize.max,
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.all(
                  //                   Dimensions.PADDING_SIZE_DEFAULT),
                  //               child: Text(
                  //                 "PH Level: ${res.toStringAsPrecision(2)}",
                  //                 style: const TextStyle(fontSize: 24),
                  //               ),
                  //             ),
                  //             const Padding(
                  //               padding:
                  //                   EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  //               child: Text(
                  //                 "In case result is different from your actual, and above ML model, Please enter your true value below (optional):",
                  //                 style: TextStyle(fontSize: 20),
                  //               ),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.all(
                  //                   Dimensions.PADDING_SIZE_DEFAULT),
                  //               child: Center(
                  //                 child: CustomTextFormField(
                  //                   title: "",
                  //                   textEditingController: correctResController,
                  //                 ),
                  //               ),
                  //             ),
                  //             customButton("Submit", () async {
                  //               Map<String, dynamic> data = {
                  //                 "image_url": widget.res['url'],
                  //                 "unique_id": widget.res['url'],
                  //                 "correct_res": res,
                  //                 "predicted_res": correctResController.text
                  //               };
                  //               await ApiService().sendImage(data);
                  //             })
                  // Padding(
                  //   padding: const EdgeInsets.all(
                  //       Dimensions.PADDING_SIZE_DEFAULT),
                  //   child: Text(
                  //     "Result: ${data?['is_classification']}",
                  //     style: const TextStyle(
                  //         fontSize: 20, color: Colors.blue),
                  //   ),
                  // ),
                  //           ],
                  //         );
                  //       } else {
                  //         return const CircularProgressIndicator();
                  //       }
                  //     } else {
                  //       return const CircularProgressIndicator();
                  //     }
                  //   },
                  // ),
                ],
              ),
      ),
    );
  }
}
