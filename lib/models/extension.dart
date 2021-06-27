import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:langame/models/errors.dart';
import 'package:langame/models/google/protobuf/timestamp.pb.dart' as gg;
import 'package:langame/models/langame/protobuf/langame.pb.dart' as lg;
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
        tokens: (m['tokens'] as List<dynamic>?)?.map((e) => e as String),
        latestInteractions: (m['latestInteractions'] as List<dynamic>?)
            ?.map((e) => e as String),
        errors: (m['errors'] as List<dynamic>?)?.map((e) => e as String),
        lastLogin: dynamicToProtobufTimestamp(m['lastLogin']),
        lastLogout: dynamicToProtobufTimestamp(m['lastLogout']),
        creationTime: dynamicToProtobufTimestamp(m['creationTime']),
        disabled: m['disabled']);
  }

  static lg.User fromFirebase(fb.User user) => lg.User(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL,
        google: user.providerData.any((e) => e.providerId == "google.com"),
        apple: user.providerData.any((e) => e.providerId == "apple.com"),
        creationTime: dynamicToProtobufTimestamp(user.metadata.creationTime),
      );
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
      players: (m['players'] as List<dynamic>?)?.map((e) => e as String),
      topics: (m['topics'] as List<dynamic>?)?.map((e) => e as String),
      memes: (m['memes'] as List<dynamic>?)?.map((e) => e as String),
      initiator: m['initiator'],
      done: dynamicToProtobufTimestamp(m['done']),
      currentMeme: m['currentMeme'],
      date: dynamicToProtobufTimestamp(m['date']),
      started: dynamicToProtobufTimestamp(m['started']),
      errors: (m['errors'] as List<dynamic>?)?.map((e) => e as String),
      nextMeme: dynamicToProtobufTimestamp(m['nextMeme']),
      memesSeen: m['memesSeen'],
      memeChanged: dynamicToProtobufTimestamp(m['memeChanged']),
      link: m['link'],
      reservedSpots: (m['reservedSpots'] as List<dynamic>?)?.map((e) => e as String),
      isLocked: m['isLocked'],
    );
  }
}

gg.Timestamp? dynamicToProtobufTimestamp(dynamic something) {
  if (something == null) return null;
  // Firestore Timestamp (i.e. when using thing.serverTimestamp()...)
  if (something is Timestamp)
    return gg.Timestamp.fromDateTime(something.toDate());
  if (something is DateTime) return gg.Timestamp.fromDateTime(something);
  // DateTime string (saved from date time field or whatever)
  try {
    var t = gg.Timestamp.fromDateTime(DateTime.parse(something));
    return t;
  } catch (e) {
    throw LangameException('failed_to_parse_to_timestamp');
  }
}

class PlayerExt {
  static lg.Player fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Player(
        userId: m['userId'],
        timeIn: dynamicToProtobufTimestamp(m['timeIn']),
        timeOut: dynamicToProtobufTimestamp(m['timeOut']),
        audioId: m['audioId'],
        audioToken: m['audioToken'],
        notes:
            (m['notes'] as List<dynamic>?)?.map((e) => NoteExt.fromObject(e)));
  }
}

class NoteExt {
  static lg.Note fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Note(
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      generic: m['generic'] != null
          ? lg.Note_Generic(content: m['generic']!['content'])
          : null,
      goal: m['goal'] != null
          ? lg.Note_Goal(content: m['goal']!['content'])
          : null,
      definition: m['definition'] != null
          ? lg.Note_Definition(content: m['definition']!['content'])
          : null,
    );
  }
}

class MemeExt {
  static lg.Meme fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Meme(
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      content: m['content'],
      tags: (m['tags'] as List<dynamic>?)?.map((e) => TagExt.fromObject(e)),
    );
  }
}

class TagExt {
  static lg.Tag fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Tag(
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      topic: m['topic'] != null ? TagTopicExt.fromObject(m['topic']) : null,
      classification: m['classification'] != null
          ? TagClassificationExt.fromObject(m['classification'])
          : null,
      origin: m['origin'] != null ? TagOriginExt.fromObject(m['origin']) : null,
      feedback: m['feedback'] != null
          ? TagFeedbackExt.fromObject(m['feedback'])
          : null,
      context:
          m['context'] != null ? TagContextExt.fromObject(m['context']) : null,
    );
  }
}

class TagTopicExt {
  static lg.Tag_Topic fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Tag_Topic(
      content: m['content'],
      emojis: (m['emojis'] as List<dynamic>?)?.map((e) => e as String),
    );
  }
}

class TagClassificationExt {
  static lg.Tag_Classification fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Tag_Classification(
      content: m['content'],
      score: m['score'],
      human: m['human'],
    );
  }
}

class TagOriginExt {
  static lg.Tag_Origin fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Tag_Origin(
        openai: m['openai'] != null
            ? lg.Tag_Origin_OpenAI(version: m['openai']!['version'])
            : null);
  }
}

class TagFeedbackExt {
  static lg.Tag_Feedback fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Tag_Feedback(
      userId: m['userId'],
      general: m['general'] != null
          ? lg.Tag_Feedback_General(score: m['general']!['score'])
          : null,
      relevance: m['relevance'] != null
          ? lg.Tag_Feedback_Relevance(score: m['relevance']!['score'])
          : null,
    );
  }
}

class TagContextExt {
  static lg.Tag_Context fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Tag_Context(
      content: m['content'],
      type: lg.Tag_Context_Type.values.firstWhere(
          (e) => e.toString() == m['type'],
          orElse: () => lg.Tag_Context_Type.OPENAI),
    );
  }
}
