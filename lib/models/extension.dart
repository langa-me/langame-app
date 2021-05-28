import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
import 'package:langame/models/google/protobuf/timestamp.pb.dart' as gg;
import 'package:protobuf/protobuf.dart';

extension interactionExtensions on lg.InteractionLevel {
  Color toColor() {
    switch (this) {
      case lg.InteractionLevel.AVERAGE:
        return Colors.yellow;
      case lg.InteractionLevel.GREAT:
        return Colors.green;
      case lg.InteractionLevel.LOVE:
        return Colors.pinkAccent;
      default:
        return Colors.red;
    }
  }

  FaIcon toFaIcon() {
    switch (this) {
      case lg.InteractionLevel.AVERAGE:
        return FaIcon(FontAwesomeIcons.meh);
      case lg.InteractionLevel.GREAT:
        return FaIcon(FontAwesomeIcons.laugh);
      case lg.InteractionLevel.LOVE:
        return FaIcon(FontAwesomeIcons.grinHearts);
      default:
        return FaIcon(FontAwesomeIcons.frown);
    }
  }
}

extension interactionIntExtensions on int {
  lg.InteractionLevel toInteractionLevel() {
    if (this > 10) return lg.InteractionLevel.LOVE;
    if (this > 5) return lg.InteractionLevel.GREAT;
    if (this > 2) return lg.InteractionLevel.AVERAGE;

    return lg.InteractionLevel.BAD;
  }
}

extension protExt on GeneratedMessage {
  Map<String, dynamic> toMapStringDynamic() =>
      this.toProto3Json() as Map<String, dynamic>;
}

class UserExt {
  static lg.User fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.User(
        uid: m['uid'],
        email: m['email'],
        displayName: m['displayName'],
        phoneNumber: m['phoneNumber'],
        photoUrl: m['photoUrl'],
        online: m['online'],
        google: m['google'],
        facebook: m['facebook'],
        apple: m['apple'],
        favouriteTopics:
            (m['favouriteTopics'] as List<dynamic>?)?.map((e) => e as String),
        tag: m['tag'],
        tokens: (m['tokens'] as List<dynamic>?)?.map((e) => e as String));
  }

  static lg.User fromFirebase(fb.User user) => lg.User(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL);
}

class NotificationExt {
  static lg.Notification fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Notification(
        id: m['id'],
        senderUid: m['senderUid'],
        topics: (m['topics'] as List<dynamic>?)?.map((e) => e as String),
        channelName: m['channelName'],
        ready: m['ready']);
  }
}

class LangameExt {
  static lg.Langame fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Langame(
      channelName: m['channelName'],
      players: (m['players'] as List<dynamic>?)
          ?.map((e) => LangamePlayerExt.fromObject(e)),
      topics: (m['topics'] as List<dynamic>?)?.map((e) => e as String),
      questions: (m['questions'] as List<dynamic>?)
          ?.map((e) => QuestionExt.fromObject(e)),
      initiator: m['initiator'],
      done: m['done'],
      currentQuestion: m['currentQuestion'],
      date: m['date'] != null ? gg.Timestamp(nanos: DateTime.parse(m['date']).microsecond*1000) : null,
    );
  }
}

class LangamePlayerExt {
  static lg.Langame_Player fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Langame_Player(
      userId: m['userId'],
      timeIn: m['timeIn'],
      timeOut: m['timeOut'],
      notes: (m['notes'] as List<dynamic>?)
          ?.map((e) => LangameNoteExt.fromObject(e))
    );
  }
}

class LangameNoteExt {
  static lg.Langame_Note fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Langame_Note(
      content: m['content'],
      createdAt: m['createdAt'],
    );
  }
}

class QuestionExt {
  static lg.Question fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Question(
      id: m['id'],
      content: m['content'],
      contexts: (m['contexts'] as List<dynamic>?)?.map((e) => e as String),
    );
  }
}
