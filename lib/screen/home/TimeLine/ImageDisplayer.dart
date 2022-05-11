import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp1_7_2022/config/palette.dart';

class ImageDisplayer extends StatefulWidget {
  final List<String> paths;
  final List<bool> isCover;
  final int index;
  final String title;
  const ImageDisplayer({Key? key, required this.paths,required this.title, required this.index, required this.isCover}) : super(key: key);

  @override
  State<ImageDisplayer> createState() => _ImageDisplayerState();
}

class _ImageDisplayerState extends State<ImageDisplayer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          height: 84,
          color: Palette.textColor,
        ),
        Container(
          width: size.width,
          height: size.height-84,
          decoration: const BoxDecoration(color: Colors.black),
          child: widget.paths[widget.index]!="no"
              ?Image.network(
                  widget.paths[widget.index],
                fit: widget.isCover[widget.index]?BoxFit.cover:BoxFit.fitWidth,
              )
              :widget.paths[0]!="no"
                    ?Image.network(
                widget.paths[0],
                fit: widget.isCover[0]?BoxFit.cover:BoxFit.fitWidth,
              )
                :Center(
                  child: Container(
                    color: Palette.buttonColor,
                    margin: EdgeInsets.symmetric(horizontal: 47),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Palette.textColor,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
