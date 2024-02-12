import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/base/custom_timer.dart';
import 'package:wellness/views/screens/instructions/instructions.dart';

class TimerScreen extends StatefulWidget {
  final String? horseId;
  final String? preTestId;
  final int? timeleft;
  final int? testId;
  const TimerScreen(
      {super.key, this.horseId, this.preTestId, this.timeleft, this.testId});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  bool isLoading = false;
  String? id;
  bool timerSet = false;
  bool timerEnded = false;
  int _duration = 900;

  void _updateTimer(bool val) {
    setState(() {
      timerEnded = val;
    });
  }

  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    if (widget.timeleft != null) {
      setState(() {
        timerSet = true;
        _duration = widget.timeleft!;
        id = widget.testId.toString();
      });
    }

    if (_duration == 0) {
      setState(() {
        timerEnded = true;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (_duration > 0 && widget.testId != null) {
        _controller.start();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            customTimer(
                _duration, _controller, timerEnded, context, _updateTimer),
            timerSet
                ? const SizedBox()
                : isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : customButton("Do you want to begin the test?", () async {
                        setState(() {
                          isLoading = true;
                        });
                        await ApiService().setTestData({
                          "pre_test_requirement":
                              int.parse(widget.preTestId ?? "0"),
                          "horse_info": int.parse(widget.horseId ?? "0"),
                          "start_time":
                              DateTime.now().toUtc().toIso8601String(),
                          "end_time": DateTime.now()
                              .add(const Duration(minutes: 15))
                              .toUtc()
                              .toIso8601String(),
                        }).then((testDataRes) {
                          if (testDataRes != null) {
                            id = testDataRes;
                            setState(() {
                              timerSet = true;
                              isLoading = false;
                            });
                          }
                          _controller.start();
                        });
                      }),
            timerSet
                ? Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        customButton("Take another Test", () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        }),
                        customButton(
                            "Proceed",
                            timerEnded
                                ? () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => InstructionScreen(
                                          testId: int.parse(id ?? "0"),
                                          timeleft: 0,
                                        ),
                                      ),
                                    );
                                  }
                                : () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Wait for the timer to end."),
                                      ),
                                    );
                                  },
                            disabled: timerEnded ? false : true)
                      ],
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _button({required String title, VoidCallback? onPressed}) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.purple),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
