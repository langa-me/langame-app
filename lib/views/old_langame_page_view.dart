import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:lottie/lottie.dart';

import 'colors/colors.dart';

class OldLangamePageView extends StatefulWidget {
  final void Function(int, {Curve? curve}) _goToPage;
  OldLangamePageView(this._goToPage);

  @override
  _State createState() => _State();
}

class _State extends State<OldLangamePageView>
    with AfterLayoutMixin<OldLangamePageView> {
  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Lottie.asset('animations/think.json',
          repeat: false, height: AppSize.safeBlockVertical * 50),
      Text('Coming soon', style: Theme.of(context).textTheme.caption!),

    ]);
  }
}
