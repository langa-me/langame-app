import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:langame/helpers/constants.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/providers/authentication_provider.dart';
import 'package:langame/providers/remote_config_providert.dart';
import 'package:pubnub/pubnub.dart';
import 'package:touchable/touchable.dart';
import 'package:uuid/uuid.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'context_provider.dart';
import 'crash_analytics_provider.dart';

enum DrawAction {
  Selection,
  DrawRectangle,
  DrawCircle,
  DrawLine,
  DrawPoints,
  DrawText,
}

class PaintingProvider extends ChangeNotifier {
  PaintingProvider(this._cap, this._cp, this._ap, this._rcp);

  final CrashAnalyticsProvider _cap;
  // ignore: unused_field
  final ContextProvider _cp;
  final AuthenticationProvider _ap;
  final RemoteConfigProvider _rcp;
  PubNub? _pubNub;
  StreamSubscription<Envelope>? _sub;
  String? _channel;
  LocalPaint _localPaint = LocalPaint(
    Colors.black,
    Colors.transparent,
    4,
    100,
    DrawAction.Selection,
  );
  PaintGrid _paintGrid = PaintGrid();

  LocalPaint get localPaint => _localPaint;
  PaintGrid get paintGrid => _paintGrid;

  lg.Paint_DrawShape _getLocalShapeProperties() => lg.Paint_DrawShape(
        id: _localPaint.uuid,
        r: _localPaint.strokeColor.red,
        g: _localPaint.strokeColor.green,
        b: _localPaint.strokeColor.blue,
        screenWidth: AppSize.screenWidth,
        screenHeight: AppSize.screenHeight,
      );

  lg.Paint_DrawShape _getShapeProperties(Shape s) => lg.Paint_DrawShape(
        id: s.id,
        r: s.paint.color.red,
        g: s.paint.color.green,
        b: s.paint.color.blue,
        screenWidth: AppSize.screenWidth,
        screenHeight: AppSize.screenHeight,
      );

  String _getUserUuid() => _ap.user!.uid + Uuid().v1();

  void _onPaintMessage(lg.Paint paint) {
    // _cap.log('received ${paint.whichAction()}');
    // _cap.log('received ${paint.selectionCircle.shapeProperties}');
    switch (paint.whichAction()) {
      case lg.Paint_Action.selectionRectangle:
        var sp = paint.selectionRectangle.shapeProperties;
        // TODO: reports this unusual errors
        if (_paintGrid.rectangles[sp.id] == null) return;
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        _paintGrid.rectangles[sp.id]!.rect = _paintGrid.rectangles[sp.id]!.rect
            .translate(paint.selectionRectangle.shiftX / widthRatio,
                paint.selectionRectangle.shiftY / heightRatio);
        _paintGrid.rectangles[sp.id]!.paint.color =
            Color.fromARGB(255, sp.r, sp.g, sp.b);
        break;
      case lg.Paint_Action.selectionCircle:
        var sp = paint.selectionCircle.shapeProperties;
        if (_paintGrid.circles[sp.id] == null) return;
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        _paintGrid.circles[sp.id]!.offset = _paintGrid.circles[sp.id]!.offset
            .translate(paint.selectionCircle.shiftX / widthRatio,
                paint.selectionCircle.shiftY / heightRatio);
        _paintGrid.circles[sp.id]!.paint.color =
            Color.fromARGB(255, sp.r, sp.g, sp.b);
        break;
      case lg.Paint_Action.selectionLine:
        var sp = paint.selectionLine.shapeProperties;
        if (_paintGrid.lines[sp.id] == null) return;
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        if (paint.selectionLine.isP1) {
          _paintGrid.lines[sp.id]!.p1 = Offset(
              paint.selectionLine.newX / widthRatio,
              paint.selectionLine.newY / heightRatio);
        } else {
          _paintGrid.lines[sp.id]!.p2 = Offset(
              paint.selectionLine.newX / widthRatio,
              paint.selectionLine.newY / heightRatio);
        }
        _paintGrid.lines[sp.id]!.paint.color =
            Color.fromARGB(255, sp.r, sp.g, sp.b);
        break;
      case lg.Paint_Action.selectionText:
        var sp = paint.selectionText.shapeProperties;
        if (_paintGrid.texts[sp.id] == null) return;
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        _paintGrid.texts[sp.id]!.position = Offset(
            paint.selectionText.newX / widthRatio,
            paint.selectionText.newY / heightRatio);
        _paintGrid.texts[sp.id]!.paint.color =
            Color.fromARGB(255, sp.r, sp.g, sp.b);
        break;
      case lg.Paint_Action.drawRectangle:
        var r = paint.drawRectangle;
        var p = _localPaint.getPaint();
        var sp = r.shapeProperties;
        p.color = Color.fromARGB(255, sp.r, sp.g, sp.b);
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        _paintGrid.rectangles[sp.id] = Rectangle(
            sp.id,
            p,
            Rect.fromLTRB(
                r.bottomLeftX / widthRatio,
                r.bottomLeftY / heightRatio,
                r.topRightX / widthRatio,
                r.topRightY / heightRatio));
        break;
      case lg.Paint_Action.drawCircle:
        var r = paint.drawCircle;
        var p = _localPaint.getPaint();
        var sp = r.shapeProperties;
        p.color = Color.fromARGB(255, sp.r, sp.g, sp.b);
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        _paintGrid.circles[sp.id] = Circle(
          sp.id,
          p,
          Offset(r.centerX / widthRatio, r.centerY / heightRatio),
          r.radius,
        );
        break;
      case lg.Paint_Action.drawLine:
        var r = paint.drawLine;
        var p = _localPaint.getPaint();
        var sp = r.shapeProperties;
        p.color = Color.fromARGB(255, sp.r, sp.g, sp.b);
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        _paintGrid.lines[sp.id] = Line(
          sp.id,
          p,
          Offset(r.p1X / widthRatio, r.p1Y / heightRatio),
          Offset(r.p2X / widthRatio, r.p2Y / heightRatio),
        );
        break;
      case lg.Paint_Action.drawPoints:
        var r = paint.drawPoints;
        var p = _localPaint.getPaint();
        var sp = r.shapeProperties;
        p.color = Color.fromARGB(255, sp.r, sp.g, sp.b);
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        _paintGrid.points[sp.id] = Points(
          sp.id,
          p,
          [Offset(r.positionX / widthRatio, r.positionY / heightRatio)],
        );
        break;
      case lg.Paint_Action.drawText:
        var r = paint.drawText;
        var p = _localPaint.getPaint();
        var sp = r.shapeProperties;
        p.color = Color.fromARGB(255, sp.r, sp.g, sp.b);
        var widthRatio = sp.screenWidth / AppSize.screenWidth;
        var heightRatio = sp.screenHeight / AppSize.screenHeight;
        createText(Offset(r.positionX / widthRatio, r.positionY / heightRatio),
            id: sp.id, paint: p);
        break;
      case lg.Paint_Action.clearAll:
        clear(sync: false);
        break;
      case lg.Paint_Action.editText:
        _paintGrid.texts[paint.editText.id]!.textField.controller!.text =
            paint.editText.text;
        break;
      case lg.Paint_Action.notSet:
        // TODO: Handle this case.
        break;
    }
    _localPaint.reset();
    notifyListeners();
  }

  void setStrokeColor(Color c) {
    _cap.log('setStrokeColor $c');
    _localPaint.reset();
    _localPaint.strokeColor = c;
    notifyListeners();
  }

  void setDrawAction(DrawAction a) {
    _cap.log('setDrawAction $a');
    _localPaint.reset();
    _localPaint.action = a;
    notifyListeners();
  }

  Future<LangameResponse<void>> init(String channel) async {
    try {
      var u = _ap.user;
      if (u == null)
        return LangameResponse(LangameStatus.failed, error: kNotAuthenticated);
      _pubNub = PubNub(
        defaultKeyset: Keyset(
          subscribeKey: _rcp.pubNubSubscribeKey,
          publishKey: _rcp.pubNubPublishKey,
          uuid: UUID(u.uid),
        ),
      );
      _channel = channel;
      _sub = _pubNub!
          .subscribe(channels: Set.from([channel]))
          .messages
          .listen((e) {
        if (e.uuid.value == u.uid) return;
        _onPaintMessage(lg.Paint.fromBuffer(
            (e.payload as List<dynamic>).map((e) => e as int).toList()));
      });
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to start');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> send(lg.Paint paint) async {
    try {
      _pubNub?.publish(_channel!, paint.writeToBuffer());
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to stop');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  Future<LangameResponse<void>> stop() async {
    try {
      await _sub?.cancel();
      return LangameResponse(LangameStatus.succeed);
    } catch (e, s) {
      _cap.log('failed to stop');
      _cap.recordError(e, s);
      return LangameResponse(LangameStatus.failed, error: e.toString());
    }
  }

  void clear({bool sync = false}) {
    _cap.log('clear');
    _paintGrid.rectangles.clear();
    _paintGrid.circles.clear();
    _paintGrid.lines.clear();
    _paintGrid.points.clear();
    _paintGrid.texts.clear();
    _localPaint.shapeHistory.clear();
    _localPaint.reset();
    notifyListeners();
    if (sync) send(lg.Paint(clearAll: lg.Paint_Clear()));
  }

  void undo() {
    if (_localPaint.shapeHistory.length == 0) return;
    var removed =
        _localPaint.shapeHistory.removeAt(_localPaint.shapeHistory.length - 1);
    _paintGrid.rectangles.removeWhere((k, v) => v.id == removed.id);
    _paintGrid.circles.removeWhere((k, v) => v.id == removed.id);
    _paintGrid.lines.removeWhere((k, v) => v.id == removed.id);
    _paintGrid.points.removeWhere((k, v) => v.id == removed.id);
    _paintGrid.texts.removeWhere((k, v) => v.id == removed.id);
    _cap.log('undo $removed ${_localPaint.shapeHistory.map((k) => k)}');
    _localPaint.reset();
    notifyListeners();
  }

  void tap() {
    _localPaint.reset();
  }

  void start(DragStartDetails details) {
    _localPaint.reset();

    switch (_localPaint.action) {
      case DrawAction.Selection:
      case DrawAction.DrawRectangle:
      case DrawAction.DrawCircle:
      case DrawAction.DrawLine:
      case DrawAction.DrawPoints:
        _localPaint.originX = details.localPosition.dx;
        _localPaint.originY = details.localPosition.dy;
        break;
      case DrawAction.DrawText:
        // TODO: Handle this case.
        break;
    }
    _localPaint.uuid = null;
    // _cap.log(
    //     'start ${_history.action} ${_history.originX} ${_history.originY}');
  }

  void update(DragUpdateDetails details) {
    var p = details.localPosition;
    switch (_localPaint.action) {
      case DrawAction.Selection:
        var selectedNothing = true;
        // TODO: extremely inefficient
        if (selectedNothing &&
            (_localPaint.dragged == null || _localPaint.dragged is Rectangle)) {
          try {
            var selected = _paintGrid.rectangles.values.firstWhere((e) =>
                e.rect.left + AppSize.safeBlockHorizontal * 6 > p.dx &&
                e.rect.right - AppSize.safeBlockHorizontal * 6 < p.dx &&
                e.rect.top - AppSize.safeBlockVertical * 6 < p.dy &&
                e.rect.bottom + AppSize.safeBlockVertical * 6 > p.dy);
            var shift = p - selected.rect.center;
            selected.rect = selected.rect.shift(shift);
            _localPaint.dragged = selected;
            selectedNothing = false;
            send(lg.Paint(
                selectionRectangle: lg.Paint_SelectionRectangle(
              shapeProperties: _getShapeProperties(selected),
              shiftX: shift.dx,
              shiftY: shift.dy,
            )));
          } catch (e) {
            selectedNothing = true;
          }
        }
        if (selectedNothing &&
            (_localPaint.dragged == null || _localPaint.dragged is Circle)) {
          try {
            var selected = _paintGrid.circles.values
                .firstWhere((e) => (e.offset - p).distance < e.radius);
            var shift = p - selected.offset;
            selected.offset += shift;
            _localPaint.dragged = selected;
            selectedNothing = false;
            send(lg.Paint(
                selectionCircle: lg.Paint_SelectionCircle(
              shapeProperties: _getShapeProperties(selected),
              shiftX: shift.dx,
              shiftY: shift.dy,
            )));
          } catch (e) {
            selectedNothing = true;
          }
        }
        if (selectedNothing &&
            (_localPaint.dragged == null || _localPaint.dragged is Line)) {
          try {
            var p1 = true;
            var selected = _paintGrid.lines.values.firstWhere((e) {
              if ((e.p1 - p).distance < AppSize.safeBlockVertical * 10) {
                p1 = true;
                return true;
              }
              if ((e.p2 - p).distance < AppSize.safeBlockVertical * 10) {
                p1 = false;
                return true;
              }
              return false;
            });
            if (p1)
              selected.p1 = p;
            else
              selected.p2 = p;
            _localPaint.dragged = selected;
            selectedNothing = false;
            send(lg.Paint(
                selectionLine: lg.Paint_SelectionLine(
              shapeProperties: _getShapeProperties(selected),
              isP1: p1,
              newX: p.dx,
              newY: p.dy,
            )));
          } catch (e) {
            selectedNothing = true;
          }
        }
        if (selectedNothing &&
            (_localPaint.dragged == null || _localPaint.dragged is TextShape)) {
          try {
            var selected = _paintGrid.texts.values.firstWhere((e) =>
                (e.position - p).distance < AppSize.safeBlockVertical * 10);
            selected.position = p;
            _localPaint.dragged = selected;
            selectedNothing = false;
            send(lg.Paint(
                selectionText: lg.Paint_SelectionText(
              shapeProperties: _getShapeProperties(selected),
              newX: p.dx,
              newY: p.dy,
            )));
          } catch (e) {
            selectedNothing = true;
          }
        }
        if (selectedNothing) _localPaint.dragged = null;
        break;
      case DrawAction.DrawRectangle:
      case DrawAction.DrawCircle:
      case DrawAction.DrawLine:
        _localPaint.positionX = p.dx;
        _localPaint.positionY = p.dy;
        break;
      case DrawAction.DrawPoints:
        _localPaint.positionX = p.dx;
        _localPaint.positionY = p.dy;
        _localPaint.uuid = _getUserUuid();
        send(lg.Paint(
          drawPoints: lg.Paint_DrawPoints(
            shapeProperties: _getLocalShapeProperties(),
            positionX: _localPaint.positionX,
            positionY: _localPaint.positionY,
          ),
        ));
        break;
      case DrawAction.DrawText:
        break;
    }
    notifyListeners();
  }

  void end(DragEndDetails details) {
    if (_localPaint.action != DrawAction.DrawPoints)
      _localPaint.uuid = _getUserUuid();

    switch (_localPaint.action) {
      case DrawAction.Selection:
        // TODO: Handle this case.
        break;
      case DrawAction.DrawRectangle:
        send(lg.Paint(
          drawRectangle: lg.Paint_DrawRectangle(
            shapeProperties: _getLocalShapeProperties(),
            bottomLeftX: _localPaint.originX,
            bottomLeftY: _localPaint.originY,
            topRightX: _localPaint.positionX,
            topRightY: _localPaint.positionY,
          ),
        ));
        break;
      case DrawAction.DrawCircle:
        var o = Offset(_localPaint.originX, _localPaint.originY);
        var pos = Offset(_localPaint.positionX, _localPaint.positionY);
        send(lg.Paint(
          drawCircle: lg.Paint_DrawCircle(
            shapeProperties: _getLocalShapeProperties(),
            centerX: _localPaint.originX,
            centerY: _localPaint.originY,
            radius: (o - pos).distance,
          ),
        ));
        break;
      case DrawAction.DrawLine:
        send(lg.Paint(
          drawLine: lg.Paint_DrawLine(
            shapeProperties: _getLocalShapeProperties(),
            p1X: _localPaint.originX,
            p1Y: _localPaint.originY,
            p2X: _localPaint.positionX,
            p2Y: _localPaint.positionY,
          ),
        ));
        break;
      case DrawAction.DrawPoints:
        break;
      case DrawAction.DrawText:
        break;
    }
    notifyListeners();
  }

  void _onEditText(String id, String text) {
    send(lg.Paint(editText: lg.Paint_EditText(id: id, text: text)));
  }

  void createText(Offset? tapPosition,
      {String? id, Paint? paint, bool synchronize = false}) {
    if (tapPosition == null) return;
    // If id is not null, it is a remote text //
    if (id == null) {
      _cap.log('createText');
      setDrawAction(DrawAction.DrawText);
      id = _getUserUuid();
    }
    _paintGrid.texts[id] = TextShape(
      id,
      paint ?? _localPaint.getPaint(),
      TextField(
        controller: TextEditingController(),
        onChanged: (s) => _onEditText(id!, s),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: paint != null ? paint.color : _localPaint.strokeColor),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                color: paint != null ? paint.color : _localPaint.strokeColor),
            hintText: 'Enter text...',
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.all(15)),
      ),
      tapPosition,
    );
    _localPaint.shapeHistory.add(_paintGrid.texts[id]!);
    notifyListeners();
    if (synchronize) {
      var sp = _getLocalShapeProperties();
      sp.id = id;
      send(lg.Paint(
        drawText: lg.Paint_DrawText(
          shapeProperties: sp,
          positionX: tapPosition.dx,
          positionY: tapPosition.dy,
        ),
      ));
    }
  }
}

class MyPainter extends CustomPainter {
  MyPainter(this._context, this._localPaint, this._paintGrid);

  final BuildContext _context;
  final LocalPaint _localPaint;
  final PaintGrid _paintGrid;

  @override
  void paint(Canvas canvas, Size size) {
    var tc = TouchyCanvas(_context, canvas);
    var p = _localPaint.getPaint();
    switch (_localPaint.action) {
      case DrawAction.Selection:
        // TODO: Handle this case.
        break;
      case DrawAction.DrawRectangle:
        var r = Rect.fromLTRB(_localPaint.originX, _localPaint.originY,
            _localPaint.positionX, _localPaint.positionY);
        var rectangle = Rectangle(_localPaint.uuid, p, r);
        if (_localPaint.uuid != null &&
            !_localPaint.shapeHistory.any((e) => e.id == _localPaint.uuid)) {
          _paintGrid.rectangles.putIfAbsent(_localPaint.uuid!, () => rectangle);
          _localPaint.shapeHistory.add(rectangle);
        }
        tc.drawRect(r, p);
        break;
      case DrawAction.DrawCircle:
        var o = Offset(_localPaint.originX, _localPaint.originY);
        var pos = Offset(_localPaint.positionX, _localPaint.positionY);
        var c = Circle(_localPaint.uuid, p, o, (o - pos).distance);
        if (_localPaint.uuid != null &&
            !_localPaint.shapeHistory.any((e) => e.id == _localPaint.uuid)) {
          _paintGrid.circles.putIfAbsent(_localPaint.uuid!, () => c);
          _localPaint.shapeHistory.add(c);
        }
        tc.drawCircle(c.offset, c.radius, p);
        break;
      case DrawAction.DrawLine:
        var p1 = Offset(_localPaint.originX, _localPaint.originY);
        var p2 = Offset(_localPaint.positionX, _localPaint.positionY);
        var l = Line(_localPaint.uuid, p, p1, p2);
        if (_localPaint.uuid != null &&
            !_localPaint.shapeHistory.any((e) => e.id == _localPaint.uuid)) {
          _paintGrid.lines.putIfAbsent(_localPaint.uuid!, () => l);
          _localPaint.shapeHistory.add(l);
        }
        tc.drawLine(p1, p2, p);
        break;
      case DrawAction.DrawPoints:
        var points = [Offset(_localPaint.positionX, _localPaint.positionY)];
        var pointsList = Points(_localPaint.uuid, p, points);
        if (_localPaint.uuid != null &&
            !_localPaint.shapeHistory.any((e) => e.id == _localPaint.uuid)) {
          _paintGrid.points.putIfAbsent(_localPaint.uuid!, () => pointsList);
          _localPaint.shapeHistory.add(pointsList);
        }
        tc.drawPoints(PointMode.points, points, p);
        break;

      case DrawAction.DrawText:
        // TODO: Handle this case.
        break;
    }
    _paintGrid.rectangles.forEach((k, v) => tc.drawRect(v.rect, v.paint));
    _paintGrid.circles
        .forEach((k, v) => tc.drawCircle(v.offset, v.radius, v.paint));
    _paintGrid.lines.forEach((k, v) => tc.drawLine(v.p1, v.p2, v.paint));
    _paintGrid.points
        .forEach((k, v) => tc.drawPoints(PointMode.points, v.points, v.paint));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Shape {
  String? id;
  Paint paint;

  Shape(this.id, this.paint);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Shape && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Circle extends Shape {
  Offset offset;
  double radius;

  Circle(id, paint, this.offset, this.radius) : super(id, paint);
}

class Line extends Shape {
  Offset p1;
  Offset p2;

  Line(id, paint, this.p1, this.p2) : super(id, paint);
}

class Points extends Shape {
  List<Offset> points;

  Points(id, paint, this.points) : super(id, paint);
}

class Rectangle extends Shape {
  Rect rect;

  Rectangle(id, paint, this.rect) : super(id, paint);
}

class TextShape extends Shape {
  TextField textField;
  Offset position;

  TextShape(id, paint, this.textField, this.position) : super(id, paint);
}

class PaintGrid {
  Map<String, Rectangle> rectangles = {};
  Map<String, Circle> circles = {};
  Map<String, Line> lines = {};
  Map<String, Points> points = {};
  Map<String, TextShape> texts = {};
}

class LocalPaint {
  Color strokeColor;
  Color backgroundColor;
  double strokeWidth;
  double opacity;
  DrawAction action;
  String? uuid;
  double originX = 0;
  double originY = 0;
  double positionX = 0;
  double positionY = 0;
  List<Shape> shapeHistory = [];
  Shape? dragged;

  LocalPaint(
    this.strokeColor,
    this.backgroundColor,
    this.strokeWidth,
    this.opacity,
    this.action,
  );

  void reset() {
    originX = 0;
    originY = 0;
    positionX = 0;
    positionY = 0;
    uuid = null;
  }

  Paint getPaint() => Paint()
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..color = strokeColor;
}
