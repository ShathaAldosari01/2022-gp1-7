import 'package:flutter/material.dart';

class ImageDisplayer extends StatefulWidget {
  final String path;
  const ImageDisplayer({Key? key, required this.path}) : super(key: key);

  @override
  State<ImageDisplayer> createState() => _ImageDisplayerState();
}

class _ImageDisplayerState extends State<ImageDisplayer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(color: Colors.black),
      child: Image.network(widget.path),
    );
  }
}
