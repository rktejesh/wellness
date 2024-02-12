import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wellness/data/model/test_data/test_data.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';
import 'package:wellness/views/screens/instructions/timer_screen.dart';

class TestDetailsScreen extends StatelessWidget {
  final TestData test;
  final bool timer;

  const TestDetailsScreen({Key? key, required this.test, required this.timer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Details'),
      ),
      floatingActionButton: test.predictedValue == null
          ? timer
              ? Padding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: customButton("Continue Test", () {
                    if (test.id != null) {
                      int? time =
                          test.end_time?.difference(DateTime.now()).inSeconds;
                      if (time != null) {
                        time < 0 ? time = 0 : time = time;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => TimerScreen(
                              timeleft: time,
                              testId: test.id,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Test not started"),
                          ),
                        );
                      }
                    }
                  }),
                )
              : const SizedBox()
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            test.imageUrl != null
                ? Image.network(
                    test.imageUrl ?? "",
                    width: MediaQuery.of(context).size.width * 0.8,
                  )
                : const SizedBox(),
            const SizedBox(height: 16),
            _buildListTile("Test ID", test.id.toString()),
            _buildListTile("Predicted Value",
                (test.predictedValue ?? "Not scanned yet").toString()),
            _buildListTile(
              "Created At",
              DateFormat("yyyy-MM-dd HH:mm:ss")
                  .format(test.createdAt ?? DateTime.now()),
            ),
            const SizedBox(height: 16),
            Text(
              'Pre-Test Requirement:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ),
            _buildListTile("Is Fasted",
                test.preTestRequirement?.isFasted?.toString() ?? ""),
            _buildListTile(
                "Last Fed Time",
                DateFormat("yyyy-MM-dd HH:mm").format(
                    test.preTestRequirement?.lastFedtime ?? DateTime.now())),
            _buildListTile("Sugar Test",
                test.preTestRequirement?.sugarTest?.toString() ?? ""),
            _buildListTile(
                "Last Intake", test.preTestRequirement?.lastIntake ?? ""),
            const SizedBox(height: 16),
            Text(
              'Horse Information:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Dimensions.fontSizeLarge,
              ),
            ),
            _buildListTile("Barn Name", test.horseInfo?.barnName ?? ""),
            _buildListTile("Discipline", test.horseInfo?.discipline ?? ""),
            _buildListTile("Exercise", test.horseInfo?.exercise ?? ""),
            _buildListTile("Weight", test.horseInfo?.weight?.toString() ?? ""),
            _buildListTile(
                "Body Condition", test.horseInfo?.bodyCondition ?? ""),
            // Add more horse information as needed
            const SizedBox(height: 16),
            Text('Conducted By:',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.fontSizeLarge,
                )),
            _buildListTile("Username", test.conductedBy?.username ?? ""),
            _buildListTile("Email", test.conductedBy?.email ?? ""),
            _buildListTile(
                "Time left",
                test.end_time != null
                    ? "${(test.end_time?.difference(DateTime.now()).inMinutes ?? 0) < 0 ? 0 : test.end_time?.difference(DateTime.now()).inMinutes ?? ""} minutes"
                    : "Test not started"),
            const SizedBox(height: 16)
            // Add more conducted by information as needed
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(String title, String value) {
    return ListTile(
      dense: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.fontSizeDefault),
          ),
          Text(
            value,
          ),
        ],
      ),
    );
  }
}
