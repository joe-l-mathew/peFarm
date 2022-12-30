import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String title;
  final String description;

  final List<TextButton> actions;

  const AlertDialogWidget(
      {required this.title,
      required this.description,
      required this.actions,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: actions,
    );
  }
}
