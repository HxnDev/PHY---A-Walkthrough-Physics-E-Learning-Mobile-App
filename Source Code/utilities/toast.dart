import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Color primaryColor = const Color(0xff2D1E40);

void displayToast(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    backgroundColor: Colors.white,
    textColor: primaryColor,
    toastLength: Toast.LENGTH_SHORT,
  );
}