import 'dart:ui';

import 'package:flutter/material.dart';

void postFrameCallback(FrameCallback callback) {
  WidgetsBinding.instance!.addPostFrameCallback(callback);
}
