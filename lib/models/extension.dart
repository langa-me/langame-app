import 'package:flutter/material.dart';
import 'package:langame/models/relation.dart';

extension relationExtensions on RelationLevel {
  Color? toColor() {
    switch (this) {
      case RelationLevel.BAD:
        return Colors.red;
      case RelationLevel.AVERAGE:
        return Colors.yellow;
      case RelationLevel.GREAT:
        return Colors.green;
    }
  }
}
