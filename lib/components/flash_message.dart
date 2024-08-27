import 'package:flutter/material.dart';

enum Status { success, error }

class FlashMessage {
  var _iconType = null;

  SnackBar get(String message, Status status) {
    if (status == Status.success) {
      _iconType = Icons.check;
    } else {
      _iconType = Icons.error_outline;
    }
    return SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(10),
          height: 45,
          decoration: BoxDecoration(
            color:
                status == Status.success ? Colors.green[300] : Colors.red[300],
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                _iconType,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 5),
            ],
          ),
        ));
  }
}
