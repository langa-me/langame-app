import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildCroppedRoundedNetworkImage(String? url,
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
                image: NetworkImage(url == null || url.isEmpty
                    ? 'https://c.files.bbci.co.uk/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg'
                    : url),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
