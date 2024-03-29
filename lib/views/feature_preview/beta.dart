// This is a stateful dart widget that display a recording

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:langame/views/colors/colors.dart';

enum BetaType {
  BETA,
  PREVIEW,
  SOON,
  NEW,
}

final _betaTypeToString = {
  BetaType.BETA: 'Beta',
  BetaType.PREVIEW: 'Preview',
  BetaType.SOON: 'Soon',
  BetaType.NEW: 'New',
};

class Beta extends StatefulWidget {
  final Widget? child;
  final BetaType? type;
  Beta(this.child, {this.type = BetaType.PREVIEW});
  @override
  _State createState() => _State();
}

class _State extends State<Beta> {
  @override
  Widget build(BuildContext context) {
    return Badge(
      badgeColor: getBlackAndWhite(context, 2, reverse: true),
      child: widget.child,
      position: BadgePosition.topEnd(top: -20, end: -30),
      badgeContent: Text(
        _betaTypeToString[widget.type]!,
        style: Theme.of(context)
            .textTheme
            .caption!
            .merge(TextStyle(color: getBlackAndWhite(context, 1))),
      ),
      borderRadius: BorderRadius.circular(8),
      shape: BadgeShape.square,
    );
  }
}
