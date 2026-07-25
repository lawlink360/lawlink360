import 'package:flutter/material.dart';

import '../dialogs/premium_dialog.dart';
import '../models/dialog_type.dart';

class DialogService {
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PremiumDialog(
        type: DialogType.success,
        title: title,
        message: message,
      ),
    );
  }

  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (_) => PremiumDialog(
        type: DialogType.error,
        title: title,
        message: message,
      ),
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (_) => PremiumDialog(
        type: DialogType.info,
        title: title,
        message: message,
      ),
    );
  }

  static Future<void> showWarning({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    return showDialog(
      context: context,
      builder: (_) => PremiumDialog(
        type: DialogType.warning,
        title: title,
        message: message,
      ),
    );
  }
}