import 'package:flutter/material.dart';

Widget buildRoundedNetworkImage(String url) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(40.0), child: Image.network(url));
}
