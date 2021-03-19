import 'package:flutter/material.dart';

Widget buildRoundedNetworkImage(String url, {double size = 100}) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Image.network(url, width: size, height: size));
}
