import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(BuildContext context, String message, bool isError) {
  Get.rawSnackbar(
    message: message,
    backgroundColor: isError ? Theme.of(context).errorColor : Colors.green,
    snackStyle: SnackStyle.FLOATING,
    snackPosition: SnackPosition.BOTTOM,
    // colorText: Colors.white,
    icon: Icon(Icons.error, color: Colors.white),
    margin: const EdgeInsets.all(10),
    borderRadius: 10,
  );
}
