import 'package:flutter/material.dart';
import 'package:movies_app/utils/dialogs/generic_dialog.dart';

Future<void> sendEmailDialog({required BuildContext context}) {
  return genericShowDialog<void>(
    context: context,
    title: "Reset Password",
    content:
        "If an account exists for this email address, a password reset link has been sent....",
    optionsBuilder: () => {"OK": null},
  );
}
