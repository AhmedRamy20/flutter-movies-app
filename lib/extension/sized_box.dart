import 'package:flutter/material.dart';

extension Sized on num {
  SizedBox get hight => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
  SizedBox get all => SizedBox(height: toDouble(), width: toDouble());
}
