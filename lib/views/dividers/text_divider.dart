import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/views/colors/colors.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? dividerThickness;
  final double? height;
  final String? tooltip;
  final EdgeInsetsGeometry? margin;
  const TextDivider(this.text,
      {Key? key,
      this.style,
      this.dividerThickness,
      this.height,
      this.tooltip,
      this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: margin ?? EdgeInsets.symmetric(vertical: 10),
        child: Row(children: [
          Expanded(
              child: Divider(
            thickness: dividerThickness ?? 4,
            height: height ?? 1,
          )),
          SizedBox(width: AppSize.safeBlockHorizontal * 2),
          Text(text,
              style: style ?? Theme.of(context).textTheme.caption,
              textAlign: TextAlign.center),
          tooltip != null
              ? SizedBox(width: AppSize.safeBlockHorizontal * 2)
              : SizedBox.shrink(),
          tooltip != null
              ? Tooltip(
                  message: tooltip,
                  child: Icon(
                    FontAwesomeIcons.questionCircle,
                    color: getBlackAndWhite(context, 0),
                  ),
                )
              : SizedBox.shrink(),
          SizedBox(width: AppSize.safeBlockHorizontal * 2),
          Expanded(
              child: Divider(
            thickness: dividerThickness ?? 4,
            height: height ?? 1,
          )),
        ]),
      );
}
