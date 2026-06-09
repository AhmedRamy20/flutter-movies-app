import 'package:flutter/material.dart';
import 'package:movies_app/utils/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return genericShowDialog<bool>(
    context: context,
    title: "LogOut",
    content: "Are you sure you want to logout:",
    optionsBuilder: () => {"Cancel": false, "log out": true},
  ).then((value) => value ?? false);
}
