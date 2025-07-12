import 'package:flutter/material.dart';
import 'package:todo_list/utils/utilities.dart';
import 'package:todo_list/utils/globals.dart';

enum SnackBarType {
  success,
  error,
}

const _defaultSnackBarDuration = Duration(seconds: 2);

void showSuccessSnackBar(
    String? text, {
      Duration duration = _defaultSnackBarDuration,
    }) {
  _showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.success,
  );
}

void showErrorSnackBar(
    String? text, {
      Duration duration = _defaultSnackBarDuration,
    }) {
  _showSnackBar(
    text,
    duration: duration,
    snackBarType: SnackBarType.error,
  );
}

Color _getBackgroundColor(SnackBarType snackBarType) {

  switch (snackBarType) {
    case SnackBarType.success:
      return const Color(0xFF368670);
    case SnackBarType.error:
      return const Color(0xFF863636);
  }
}

void _showSnackBar(
    String? text, {
      required SnackBarType snackBarType,
      Duration duration = _defaultSnackBarDuration,
    }) {
  if (Utilities.isNullOrBlank(text)) return;

  AppGlobals.scaffoldMessengerKey.currentState
    ?..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(text!),
        backgroundColor: _getBackgroundColor(snackBarType),
        clipBehavior: Clip.none,
        padding: const EdgeInsets.all(10),
        duration: duration,
      ),
    );
}