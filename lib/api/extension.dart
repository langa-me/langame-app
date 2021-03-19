import 'package:flutter/material.dart';
import 'package:langame/api/api.pb.dart';

extension relationToColor on Relation {
  Color? toColor() {
    switch (this.level) {
      case Relation_Level.BAD:
        return Colors.red;
      case Relation_Level.AVERAGE:
        return Colors.yellow;
      case Relation_Level.GREAT:
        return Colors.green;
    }
  }
}
