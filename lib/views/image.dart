import 'package:flutter/material.dart';

Widget buildRoundedNetworkImage(String url, {double size = 100}) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Image.network(url, width: size, height: size));
}

Widget buildCroppedRoundedNetworkImage(String url,
    {double width = 50, void Function()? onTap}) {
  return Container(
    width: width,
    height: width,
    child: AspectRatio(
      aspectRatio: 487 / 451,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter,
                image: NetworkImage(url),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
