import 'package:flutter/material.dart';

customSnackBar(String message) {
  return SnackBar(
    content: Text(message),
    duration: Duration(seconds: 4),
    action: SnackBarAction(
      label: 'Close',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}
