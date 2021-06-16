import 'package:flutter/material.dart';
import 'package:langame/views/colors/colors.dart';

const double defaultBorderRadius = 3.0;

class StretchableButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double borderRadius;
  final double buttonPadding;
  final Color buttonColor, splashColor;
  final Color? buttonBorderColor;
  final List<Widget> children;
  final bool centered;

  StretchableButton({
    required this.buttonColor,
    required this.borderRadius,
    required this.children,
    required this.splashColor,
    this.buttonBorderColor,
    required this.onPressed,
    required this.buttonPadding,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var contents = List<Widget>.from(children);

        if (constraints.minWidth == 0) {
          contents.add(SizedBox.shrink());
        } else {
          if (centered) {
            contents.insert(0, Spacer());
          }
          contents.add(Spacer());
        }

        BorderSide bs;
        if (buttonBorderColor != null) {
          bs = BorderSide(
            color: buttonBorderColor!,
          );
        } else {
          bs = BorderSide.none;
        }

        return ButtonTheme(
          height: 40.0,
          padding: EdgeInsets.all(buttonPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: bs,
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(splashColor),
                    backgroundColor: MaterialStateProperty.all(buttonColor))
                .merge(Theme.of(context).elevatedButtonTheme.style),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: contents,
            ),
          ),
        );
      },
    );
  }
}

class LangameButton extends StatefulWidget {
  final void Function()? onPressed;
  final String? text;
  final IconData icon;
  final int layer;
  final bool? border;
  final EdgeInsetsGeometry? padding;
  final bool disabled;
  final bool highlighted;

  const LangameButton(this.icon,
      {Key? key,
      this.text,
      this.onPressed,
      this.layer = 0,
      this.border,
      this.padding,
      this.disabled = false,
      this.highlighted = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      _LangameButtonState(disabled: this.disabled);
}

class _LangameButtonState extends State<LangameButton> {
  bool disabled = false;
  _LangameButtonState({this.disabled = false});
  @override
  Widget build(BuildContext context) {
    var bg = getBlackAndWhite(context, widget.layer + (disabled ? 1 : 0), reverse: true);
    var fg = getBlackAndWhite(context, widget.layer + (disabled ? 1 : 0), reverse: false);

    if (widget.highlighted) {
      bg = Theme.of(context).colorScheme.secondary;
      fg = isLightThenDark(context, reverse: true);
    }
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: bg,
        elevation: 5,
        shadowColor: variantIsLightThenDark(context, reverse: true),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: widget.border != null && widget.border!
            ? BorderSide(width: 0.5, color: averageGrey())
            : null,
        padding: widget.padding ?? widget.padding,
      ),
      onPressed: disabled ? null : widget.onPressed,
      icon: Icon(widget.icon, color: fg),
      label: widget.text != null
          ? Text(
              widget.text!,
              textAlign: TextAlign.center,
              style: TextStyle(color: fg),
            )
          : SizedBox.shrink(),
    );
  }
}

class ToggleButton extends StatefulWidget {
  final bool selected;
  final void Function(bool)? onChange;
  final String textSelected;
  final String textUnselected;
  final double? width;

  /// Whether to trigger the toggle on long press instead of simple tap
  final bool onLongPress;

  ToggleButton(
      {this.textSelected = '',
      this.textUnselected = '',
      this.selected = false,
      this.onChange,
      this.width = 150,
      this.onLongPress = false});

  @override
  _ToggleButtonState createState() => _ToggleButtonState(selected: selected);
}

class _ToggleButtonState extends State<ToggleButton> {
  bool selected;

  _ToggleButtonState({this.selected = false});

  @override
  Widget build(BuildContext context) {
    var bg = variantIsLightThenDark(context, reverse: true);
    var bgSelected = variantBisIsLightThenDark(context, reverse: true);
    var fg = isLightThenDark(context, reverse: false);
    // var fg = isLightThenDark(context, reverse: false);
    var s = ElevatedButton.styleFrom(
      primary: bg,
      side: BorderSide(
          width: 1.0, color: Colors.transparent),
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 500),
      crossFadeState:
          selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        width: widget.width,
        padding: EdgeInsets.all(2),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: bgSelected).merge(s),
          child: Text(widget.textSelected,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: fg)),
          onPressed: widget.onLongPress ? null : _onFirstChildChange,
          onLongPress: widget.onLongPress ? _onFirstChildChange : null,
        ),
      ),
      secondChild: Container(
        width: widget.width,
        padding: EdgeInsets.all(2),
        child: ElevatedButton(
          style: s,
          child: Text(widget.textUnselected,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: fg)),
          onPressed: widget.onLongPress ? null : _onSecondChildChange,
          onLongPress: widget.onLongPress ? _onSecondChildChange : null,
        ),
      ),
    );
  }

  _onFirstChildChange() {
    setState(() {
      selected = !selected;
    });
    if (widget.onChange != null) widget.onChange!(false);
  }

  _onSecondChildChange() {
    setState(() {
      selected = !selected;
    });
    if (widget.onChange != null) widget.onChange!(true);
  }
}
