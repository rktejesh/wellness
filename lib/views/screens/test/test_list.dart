import 'package:flutter/material.dart';
import 'package:wellness/data/api/api_service.dart';
import 'package:wellness/data/model/test_data/test_data.dart';
import 'package:wellness/views/screens/test/test_details.dart';

class TestListScreen extends StatelessWidget {
  const TestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tests'),
      ),
      body: FutureBuilder(
          future: ApiService().getConfig(),
          builder: (ctx, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasError) {
              return Center(
                child: Text('Error: ${snap.error}'),
              );
            } else {
              if (snap.hasData) {
                bool isTestEnabled = snap.data?['timer'] as bool;
                return FutureBuilder(
                  future: ApiService().getTestData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasData) {
                        List<TestData> testData =
                            snapshot.data as List<TestData>;
                        return ListView.builder(
                          itemCount: testData.length,
                          itemBuilder: (context, index) {
                            TestData test = testData[index];
                            return ListTile(
                              title: Text('Test ${test.id.toString()}'),
                              subtitle: Text(
                                  'Predicted Value: ${test.predictedValue ?? "Not scanned yet"}'),
                              leading: test.imageUrl != null
                                  ? Image.network(
                                      test.imageUrl ?? "",
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                    )
                                  : null,
                              onTap: () {
                                // Handle test item tap
                                // You can navigate to a detailed screen or perform other actions
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TestDetailsScreen(
                                      test: test,
                                      timer: isTestEnabled,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text("No data found"));
                      }
                    }
                  },
                );
              } else {
                return const Center(child: Text("No data found"));
              }
            }
          }),
    );
  }
}
