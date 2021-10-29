import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? dividerThickness;
  final double? height;
  const TextDivider(this.text, {Key? key, this.style, this.dividerThickness, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(child: Divider(
          thickness: dividerThickness ?? 4,
          height: height ?? 1,
          )),
        SizedBox(width: AppSize.safeBlockHorizontal * 2),
        Text(text,
            style: style ?? Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center),
        SizedBox(width: AppSize.safeBlockHorizontal * 2),
        Expanded(child: Divider(
          thickness: dividerThickness ?? 4,
          height: height ?? 1,
          )),
      ]);
}
