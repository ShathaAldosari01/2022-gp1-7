import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  static List<Widget> modelBuilder<M>(
      List<M> models, Widget Function(int index, M model) builder) =>
      models
          .asMap()
          .map<int, Widget>(
              (index, model) => MapEntry(index, builder(index, model)))
          .values
          .toList();

  static void showSheet(
      BuildContext context, {
        required Widget child,
        required VoidCallback onClicked,
      }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: onClicked,
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Container(
          decoration: BoxDecoration(color: Colors.grey,
              border: Border.all(width: 2.0,
              color: Colors.grey),
              borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 60),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,
                textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20)
          )
      ),
      ),
      backgroundColor: Colors.transparent, elevation: 1000, behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}