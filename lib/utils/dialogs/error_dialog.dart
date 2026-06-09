import 'package:flutter/material.dart';
import 'package:movies_app/utils/dialogs/generic_dialog.dart';

//* u did now know what is the benefit of making a map that mathch the key title and the value cuz there is dialogs
//* like this that does not return a value
Future<void> showErrorDialog(BuildContext context, String text) async {
  return genericShowDialog<void>(
    context: context,
    title: "An error occured",
    content: text,
    optionsBuilder: () => {'OK': null},
  );
}
