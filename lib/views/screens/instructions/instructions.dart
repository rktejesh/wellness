import 'package:flutter/material.dart';
import 'package:wellness/image.dart';
import 'package:wellness/utils/dimensions.dart';
import 'package:wellness/views/base/custom_button.dart';

class InstructionScreen extends StatelessWidget {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Text(
                "Instructions",
                style: TextStyle(
                  fontSize: Dimensions.fontSizeOverLarge,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Text(
                  "Step 1: Put the strip on a flat surface and take the photo"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
              child: Image.asset('assets/images/1.png'),
            ),
            const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Text(
                  "Step 2: Now crop the photo to exactly have the test area as shown below"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_EXTRA_LARGE),
              child: Image.asset('assets/images/2.png'),
            ),
            const Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Text(
                  "Step 3: Submit once final copy is completed to get the results"),
            ),
            customButton("Take an image ", () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ImageUpload()));
            })
          ],
        ),
      ),
    );
  }
}
