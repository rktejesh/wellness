import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ImagePlaceholder extends StatefulWidget {
  final Map<String, dynamic> res;
  const ImagePlaceholder({Key? key, required this.res}) : super(key: key);

  @override
  State<ImagePlaceholder> createState() => _ImagePlaceholderState();
}

class _ImagePlaceholderState extends State<ImagePlaceholder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.res['url']),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.res['url']),
            ),
          ],
        ),
      ),
    );
  }
}
