import 'dart:ui';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/providers/context_provider.dart';
import 'package:langame/providers/paint_provider.dart';
import 'package:langame/views/buttons/icon.dart';
import 'package:provider/provider.dart';

class MultiplayerPainting extends StatefulWidget {

  @override
  _MultiplayerPaintingState createState() => _MultiplayerPaintingState();
}

class _MultiplayerPaintingState extends State<MultiplayerPainting> {
  GlobalKey globalKey = GlobalKey();
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  Offset? _tapPosition;

  var _drawActionToIcon = {
    DrawAction.Selection: FontAwesomeIcons.mousePointer,
    DrawAction.DrawRectangle: FontAwesomeIcons.square,
    DrawAction.DrawCircle: FontAwesomeIcons.circle,
    DrawAction.DrawLine: FontAwesomeIcons.gripLines,
    DrawAction.DrawPoints: FontAwesomeIcons.pen,
    DrawAction.DrawText: FontAwesomeIcons.font,
  };

  @override
  Widget build(BuildContext context) {
    var pp = Provider.of<PaintingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          onDoubleTap: () {
            FocusScope.of(context).unfocus();
            pp.tap();
            if (pp.localPaint.action != DrawAction.DrawText) return;
            pp.createText(_tapPosition, synchronize: true);
          },
          onDoubleTapDown: (d) => setState(() => _tapPosition = d.localPosition),
          onPanStart: (details) {
            FocusScope.of(context).unfocus();
            pp.start(details);
          },
          onPanUpdate: pp.update,
          onPanEnd: pp.end,
          child: CustomPaint(
              size: Size.infinite,
              painter: MyPainter(
                context,
                pp.localPaint,
                pp.paintGrid,
              ),
              child: Stack(
                  children: pp.paintGrid.texts.values
                      .map((e) => Positioned(
                            child: Container(
                                child: e.textField, height: 100, width: 100),
                            left: e.position.dx,
                            top: e.position.dy,
                          ))
                      .toList())),
        ),
        floatingActionButton: FabCircularMenu(
            key: fabKey,
            ringDiameter: AppSize.safeBlockVertical * 70,
            ringWidth: AppSize.safeBlockVertical * 10,
            fabColor: Theme.of(context).colorScheme.primary,
            ringColor: Theme.of(context).colorScheme.primary,
            fabOpenIcon: FaIcon(
                _drawActionToIcon[pp.localPaint.action] ??
                    FontAwesomeIcons.palette,
                color: Theme.of(context).colorScheme.secondary),
            fabCloseIcon: FaIcon(FontAwesomeIcons.timesCircle,
                color: Theme.of(context).colorScheme.secondary),
            children: [
              buildRoundedElevatedIconButton(() => pp.clear(sync: true), Icons.clear, null,
                  Theme.of(context).colorScheme.secondary),
              // HoldDetector(
              //   onHold: pp.undo,
              //   holdTimeout: Duration(milliseconds: 200),
              //   enableHapticFeedback: true,
              //   child: buildRoundedElevatedIconButton(
              //       pp.undo,
              //       Icons.undo_outlined,
              //       null,
              //       Theme.of(context).colorScheme.secondary),
              // ),
              buildRoundedElevatedIconButton(() {
                var cp = Provider.of<ContextProvider>(context, listen: false);
                cp.showCustomDialog(
                    _drawActionToIcon.entries
                        .map((e) =>
                            _buildDrawActionButton(pp, cp, e.value, e.key))
                        .toList(),
                    canBack: true);
              }, _drawActionToIcon[pp.localPaint.action], null,
                  Theme.of(context).colorScheme.secondary),
              colorMenuItem(pp, Colors.black),
              colorMenuItem(pp, Colors.red),
              colorMenuItem(pp, Colors.blue),
              colorMenuItem(pp, Colors.green),
              // TODO: background color, for example, dialog with switches
            ]),
      ),
    );
  }

  Widget _buildDrawActionButton(PaintingProvider pp, ContextProvider cp,
          IconData icon, DrawAction drawAction) =>
      IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: () {
            pp.setDrawAction(drawAction);
            cp.dialogComplete();
          });

  Widget colorMenuItem(PaintingProvider pp, Color color) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      color: color,
      child: InkWell(
        customBorder: CircleBorder(side: BorderSide(width: 0.1)),
        splashColor:
            Color.lerp(color, Colors.black54, 0.5), // inkwell onPress colour
        child: SizedBox(
          width: 40, height: 40, //customisable size of 'button'
        ),
        onTap: () {
          pp.setStrokeColor(color);
        },
      ),
    );
  }
}
