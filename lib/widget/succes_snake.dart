import 'package:flutter/material.dart';

class SuccesSnake {
 static SnackBar successSnake(
    final bool success,
    final String message,

  ) {
    return SnackBar(content: Text(message), backgroundColor: success? Colors.green : Colors.red,);
  }
}
