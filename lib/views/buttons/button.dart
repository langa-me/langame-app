import 'package:flutter/material.dart';

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

Widget buildBasicButton(
    BuildContext context, String text, Function()? onPressed) {
  return OutlinedButton.icon(
    style: Theme.of(context).textButtonTheme.style,
    onPressed: onPressed,
    icon: Icon(Icons.autorenew_outlined),
    label: Text(text),
  );
}

class BasicLangameButton extends StatefulWidget {
  @override
  _BasicLangameButtonState createState() => _BasicLangameButtonState();
}

class _BasicLangameButtonState extends State<BasicLangameButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
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
  _ToggleButtonState createState() => _ToggleButtonState(
      selected: selected,
      onChange: onChange,
      textSelected: textSelected,
      textUnselected: textUnselected,
      width: width,
      onLongPress: onLongPress);
}

class _ToggleButtonState extends State<ToggleButton> {
  bool selected;
  void Function(bool)? onChange;
  String textSelected;
  String textUnselected;
  final double? width;
  final bool onLongPress;

  _ToggleButtonState(
      {this.textSelected = '',
      this.textUnselected = '',
      this.selected = false,
      this.onChange,
      this.width = 150,
      this.onLongPress = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      duration: Duration(milliseconds: 200),
      crossFadeState:
          selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: Container(
        width: width,
        child: ElevatedButton(
          style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary))
              .merge(Theme.of(context).elevatedButtonTheme.style),
          child: Text(textSelected),
          onPressed: onLongPress ? null : _onFirstChildChange,
          onLongPress: onLongPress ? _onFirstChildChange : null,
        ),
      ),
      secondChild: Container(
        width: width,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          child: Text(textUnselected),
          onPressed: onLongPress ? null : _onSecondChildChange,
          onLongPress: onLongPress ? _onSecondChildChange : null,
        ),
      ),
    );
  }

  _onFirstChildChange() {
    setState(() {
      selected = !selected;
    });
    if (onChange != null) onChange!(false);
  }

  _onSecondChildChange() {
    setState(() {
      selected = !selected;
    });
    if (onChange != null) onChange!(true);
  }
}
