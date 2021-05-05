import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/models/langame/protobuf/langame.pb.dart';

extension interactionExtensions on InteractionLevel {
  Color toColor() {
    switch (this) {
      case InteractionLevel.AVERAGE:
        return Colors.yellow;
      case InteractionLevel.GREAT:
        return Colors.green;
      case InteractionLevel.LOVE:
        return Colors.pinkAccent;
      default:
        return Colors.red;
    }
  }

  FaIcon toFaIcon() {
    switch (this) {
      case InteractionLevel.AVERAGE:
        return FaIcon(FontAwesomeIcons.meh);
      case InteractionLevel.GREAT:
        return FaIcon(FontAwesomeIcons.laugh);
      case InteractionLevel.LOVE:
        return FaIcon(FontAwesomeIcons.grinHearts);
      default:
        return FaIcon(FontAwesomeIcons.frown);
    }
  }
}

extension interactionIntExtensions on int {
  InteractionLevel toInteractionLevel() {
    if (this > 10) return InteractionLevel.LOVE;
    if (this > 5) return InteractionLevel.GREAT;
    if (this > 2) return InteractionLevel.AVERAGE;

    return InteractionLevel.BAD;
  }
}

User userFromMap(Map<String, dynamic> m) => User(
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

User userFromFirebase(fb.User user) => User(
    uid: user.uid,
    email: user.email,
    displayName: user.displayName,
    phoneNumber: user.phoneNumber,
    photoUrl: user.photoURL);

Langame langameFromMap(Map<String, dynamic> m) => Langame(
      channelName: m['channelName'],
      players: (m['players'] as List<dynamic>?)
          ?.map((e) => channelUserLangameUserFromMap(e)),
      topics: (m['topics'] as List<dynamic>?)?.map((e) => e as String),
      questions:
          (m['questions'] as List<dynamic>?)?.map((e) => questionFromMap(e)),
    );

ChannelUserLangameUser channelUserLangameUserFromMap(Map<String, dynamic> m) =>
    ChannelUserLangameUser(
      channelUid: m['channelUid'],
      langameUid: m['langameUid'],
    );

Question questionFromMap(Map<String, dynamic> m) => Question(
      id: m['id'],
      content: m['content'],
      contexts: (m['contexts'] as List<dynamic>?)?.map((e) => e as String),
    );
