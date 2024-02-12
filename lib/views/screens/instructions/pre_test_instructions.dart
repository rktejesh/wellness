import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/test_procedure/test_procedure.dart';
import 'package:wellness/matching_view.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/screens/instructions/instructions.dart';
import 'package:wellness/views/screens/instructions/timer_screen.dart';
import 'package:wellness/views/screens/instructions/video_widget.dart';

class PreInstructionScreen extends StatefulWidget {
  final String horseId;
  final String preTestId;
  const PreInstructionScreen(
      {super.key, required this.horseId, required this.preTestId});

  @override
  State<PreInstructionScreen> createState() => _PreInstructionScreenState();
}

class _PreInstructionScreenState extends State<PreInstructionScreen> {
  String? id = "0";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  FutureBuilder(
                    future: ApiService().getTestProcedureData(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Expanded(
                            child: Center(child: CircularProgressIndicator()));
                      } else {
                        if (snapshot.hasData) {
                          List<TestProcedure> testData =
                              snapshot.data as List<TestProcedure>;

                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: testData.length,
                            itemBuilder: (context, index) {
                              TestProcedure testProcedure = testData[index];
                              String mime;
                              bool x = testProcedure.attributes?.media?.data
                                      ?.mediaattributes?.mime!
                                      .startsWith("image") ??
                                  true;
                              if (x) {
                                mime = "image";
                                print(mime);
                              } else {
                                mime = "video";
                                print(mime);
                              }

                              String uri;

                              if (mime == "video") {
                                uri = testProcedure.attributes?.media?.data
                                        ?.mediaattributes?.url ??
                                    '';
                              } else {
                                uri =
                                    "https://wellnessapp.s3.us-east-2.amazonaws.com/wellness_ready_insulin_test_demo_720p_1103ddfa5b.mp4";
                              }

                              print(uri);

                              return Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_DEFAULT),
                                    child: Text(
                                        "Step ${index + 1}: ${testProcedure.attributes?.description ?? "No data"}"),
                                  ),
                                  mime == "image"
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          child: Image.network(
                                            testProcedure
                                                    .attributes
                                                    ?.media
                                                    ?.data
                                                    ?.mediaattributes
                                                    ?.url ??
                                                "",
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          child: VideoWidget(videoUrl: uri),
                                        ),
                                ],
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("No data found"));
                        }
                      }
                    }),
                  ),
                  customButton(
                    "Next",
                    () async {
                      setState(() {
                        loading = true;
                      });
                      await ApiService().getConfig().then(
                            (value) async => {
                              if (value['timer'])
                                {
                                  setState(() {
                                    loading = false;
                                  }),
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TimerScreen(
                                        horseId: widget.horseId,
                                        preTestId: widget.preTestId,
                                      ),
                                    ),
                                  )
                                }
                              else
                                {
                                  await ApiService().setTestData({
                                    "pre_test_requirement":
                                        int.parse(widget.preTestId),
                                    "horse_info": int.parse(widget.horseId),
                                    "start_time": DateTime.now()
                                        .toUtc()
                                        .toIso8601String(),
                                    "end_time": DateTime.now()
                                        .toUtc()
                                        .toIso8601String(),
                                  }).then((testDataRes) {
                                    if (testDataRes != null) {
                                      id = testDataRes;
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => InstructionScreen(
                                          testId: int.parse(id ?? "0"),
                                          timeleft: 0,
                                        ),
                                      ),
                                    );
                                  })
                                }
                            },
                          );
                    },
                  )
                ],
              ),
            ),
      // body: const VideoWidget(
      //     videoUrl:
      //         "https://wellnessapp.s3.us-east-2.amazonaws.com/wellness_ready_insulin_test_demo_720p_1103ddfa5b.mp4"),
    );
  }
}
