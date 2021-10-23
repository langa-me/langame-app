import 'dart:core';

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
      apple: m['apple'],
      tag: m['tag'],
      tokens: (m['tokens'] as List<dynamic>?)?.map((e) => e as String),
      latestInteractions:
          (m['latestInteractions'] as List<dynamic>?)?.map((e) => e as String),
      errors: (m['errors'] as List<dynamic>?)?.map((e) =>
          e is Map<String, dynamic>
              ? ErrorExt.fromObject(e)
              : lg.Error(developerMessage: e as String)),
      lastLogin: dynamicToProtobufTimestamp(m['lastLogin']),
      lastLogout: dynamicToProtobufTimestamp(m['lastLogout']),
      creationTime: dynamicToProtobufTimestamp(m['creationTime']),
      disabled: m['disabled'],
      devices:
          (m['devices'] as List<dynamic>?)?.map((e) => DeviceExt.fromObject(e)),
      credits: m['credits'],
      role: m['role'],
    );
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
  static Map<String, dynamic> fromFirebaseAsMap(fb.User user) => {
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'phoneNumber': user.phoneNumber,
        'photoUrl': user.photoURL,
        'google': user.providerData.any((e) => e.providerId == "google.com"),
        'apple': user.providerData.any((e) => e.providerId == "apple.com"),
        'creationTime': user.metadata.creationTime,
      };
}

class UserPreferenceExt {
  static lg.UserPreference fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.UserPreference(
      userId: m['userId'],
      userRecommendations: lg.UserPreference_RecommendationType.values
          .firstWhere(
              (e) => e.toString() == m['userRecommendations'].toString()),
      themeIndex: m['themeIndex'],
      hasDoneOnBoarding: m['hasDoneOnBoarding'],
      userSearchHistory:
          (m['userSearchHistory'] as List<dynamic>?)?.map((e) => e as String),
      shakeToFeedback: m['shakeToFeedback'],
      favoriteTopics:
          (m['favoriteTopics'] as List<dynamic>?)?.map((e) => e as String),
      speechToTextLocale: m['speechToTextLocale'],
      sawWhatsNew: m['sawWhatsNew'],
      notification: lg.UserPreference_Notification(
        message: lg.UserPreference_Notification_Message(
          email: m['notification']?['message']?['email'] ?? false,
          push: m['notification']?['message']?['push'] ?? false,
        ),
        invite: lg.UserPreference_Notification_Invite(
          email: m['notification']?['invite']?['email'] ?? false,
          push: m['notification']?['invite']?['push'] ?? false,
        ),
      ),
      previewMode: m['previewMode'] ?? false,
    );
  }
}

class DeviceExt {
  static lg.User_Device fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.User_Device(
      langameVersion: m['langameVersion'],
      deviceInfo: m['deviceInfo'],
    );
  }
}

class LangameExt {
  static lg.Langame fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Langame(
      channelName: m['channelName'],
      players: (m['players'] as List<dynamic>?)?.map((e) => e as String),
      topics: (m['topics'] as List<dynamic>?)?.map((e) => e as String),
      memes: (m['memes'] as List<dynamic>?)?.map((e) => MemeExt.fromObject(e)),
      initiator: m['initiator'],
      done: dynamicToProtobufTimestamp(m['done']),
      currentMeme: m['currentMeme'],
      date: dynamicToProtobufTimestamp(m['date']),
      started: dynamicToProtobufTimestamp(m['started']),
      errors: (m['errors'] as List<dynamic>?)?.map((e) =>
          e is Map<String, dynamic>
              ? ErrorExt.fromObject(e)
              : lg.Error(developerMessage: e as String)),
      nextMeme: dynamicToProtobufTimestamp(m['nextMeme']),
      memesSeen: m['memesSeen'],
      memeChanged: dynamicToProtobufTimestamp(m['memeChanged']),
      link: m['link'],
      reservedSpots:
          (m['reservedSpots'] as List<dynamic>?)?.map((e) => e as String),
      isLocked: m['isLocked'],
      isText: m['isText'],
      reflections: (m['reflections'] as List<dynamic>?)
              ?.map((e) => ReflectionExt.fromObject(e)) ??
          [],
      suggestions: (m['suggestions'] as List<dynamic>?)?.map(
            (e) => SuggestionExt.fromObject(e),
          ) ??
          [],
    );
  }
}

class ReflectionExt {
  static lg.Langame_Reflection fromObject(Object o) {
    var m = o as Map<Object?, Object?>;
    return lg.Langame_Reflection(
      userId: m['userId'] as String?,
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      lastMessageId: m['lastMessageId'] as String?,
      alternatives:
          (m['alternatives'] as List<dynamic>?)?.map((e) => e as String),
      contentFilter: lg.ContentFilter.values[m['contentFilter'] as int? ?? 0],
      userFeedbacks: m['userFeedbacks'] as Map<String, int>?,
    );
  }
}

class SuggestionExt {
  static lg.Langame_Suggestion fromObject(Object o) {
    var m = o as Map<Object?, Object?>;
    return lg.Langame_Suggestion(
      userId: m['userId'] as String?,
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      lastMessageId: m['lastMessageId'] as String?,
      alternatives:
          (m['alternatives'] as List<dynamic>?)?.map((e) => e as String),
      contentFilter: lg.ContentFilter.values[m['contentFilter'] as int? ?? 0],
    );
  }
}

gg.Timestamp? dynamicToProtobufTimestamp(dynamic something) {
  if (something == null) return null;
  if (something is Map<Object?, Object?> && something['_seconds'] != null) {
    return gg.Timestamp.getDefault();
  }

  // Firestore Timestamp (i.e. when using thing.serverTimestamp()...)
  if (something is Timestamp)
    return gg.Timestamp.fromDateTime(something.toDate());
  if (something is DateTime) return gg.Timestamp.fromDateTime(something);
  if (something is double)
    return gg.Timestamp.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(something.toInt() * 1000));
  if (something is int)
    return gg.Timestamp.fromDateTime(
        DateTime.fromMillisecondsSinceEpoch(something * 1000));
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
        errors: (m['errors'] as List<dynamic>?)?.map((e) =>
            e is Map<String, dynamic>
                ? ErrorExt.fromObject(e)
                : lg.Error(developerMessage: e as String)),
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
    var m = o as Map<Object?, Object?>;
    return lg.Meme(
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      content: m['content'] as String?,
      topics: (m['topics'] as List<dynamic>?)?.map((e) => e as String),
      translated: (m['translated'] as Map<Object?, Object?>?)
          ?.map((k, v) => MapEntry(k as String, v as String)),
    );
  }
}

class ErrorExt {
  static lg.Error fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Error(
        code: m['code'],
        developerMessage: m['developerMessage'],
        userMessage: m['userMessage'],
        createdAt: dynamicToProtobufTimestamp(m['createdAt']));
  }
}

class PromptExt {
  static lg.Prompt fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Prompt(
      type: m['type'],
      template: m['template'],
      id: m['id'],
      parameters: m['parameters'],
    );
  }
}

class RecordingExt {
  static lg.Recording fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Recording(
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      text: m['text'],
      userId: m['userId'],
      metadata: Map<String, String>.from(m['metadata']),
      note: m['note'] ?? '',
    );
  }
}

class MessageExt {
  static lg.Message fromObject(Object o) {
    var m = o as Map<String, dynamic>;
    return lg.Message(
      createdAt: dynamicToProtobufTimestamp(m['createdAt']),
      fromUid: m['fromUid'],
      toUid: m['toUid'],
      channelName: m['channelName'],
      type: lg.Message_Type.values[m['type']],
      body: m['body'],
      title: m['title'],
      id: m['id'],
    );
  }
}
