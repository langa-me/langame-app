import 'package:firebase_auth/firebase_auth.dart';

class LangameUser {
  /// [uid] is set by Firebase authentication
  final String? uid;
  final String? email;
  final String? displayName;
  final bool emailVerified;
  final String? phoneNumber;
  final String? photoUrl;
  Status status = Status.OFFLINE;
  bool google = false;
  bool facebook = false;
  bool apple = false;

  /// Twitter-like [tag] i.e. @steveTheApple
  String? tag;

  LangameUser(
      {this.uid,
      this.email,
      this.displayName,
      this.emailVerified = false,
      this.phoneNumber,
      this.photoUrl,
      this.status = Status.OFFLINE,
      this.tag,
      this.google = false,
      this.facebook = false,
      this.apple = false});

  LangameUser.fromFirebaseUser(User user)
      : uid = user.uid,
        email = user.email,
        displayName = user.displayName,
        emailVerified = user.emailVerified,
        phoneNumber = user.phoneNumber,
        photoUrl = user.photoURL;

  LangameUser.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        email = json['email'],
        displayName = json['displayName'],
        emailVerified = json['emailVerified'],
        phoneNumber = json['phoneNumber'],
        photoUrl = json['photoUrl'],
        status = json['status'],
        tag = json['tag'],
        google = json['google'],
        facebook = json['facebook'],
        apple = json['apple'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'emailVerified': emailVerified,
        'phoneNumber': phoneNumber,
        'photoUrl': photoUrl,
        'status': status,
        'tag': tag,
        'google': google,
        'facebook': facebook,
        'apple': apple,
      };
}

enum Status {
  OFFLINE,
  ONLINE,
}

class LangameUserRelations {
  final LangameUser user;
  final List<Relation> relations;

  LangameUserRelations(this.user, this.relations);
}

/// Evaluated relationship between users using AI + heuristics
class Relation {
  final LangameUser other;
  final RelationLevel level;

  // Langame played together
  //  int64 interactions = 1;

  Relation(this.other, {this.level = RelationLevel.BAD});
}

enum RelationLevel {
  // TODO: temporary
  BAD,
  AVERAGE,
  GREAT,
}

/// https://pub.dev/packages/flutter_facebook_auth#methods
class FacebookUser {
  final int id;
  final String? firstname;
  final String? lastName;
  final String? middleName;
  final String? name;
  final String? nameFormat;
  final Map<String, dynamic>? picture;
  final String? shortName;

  FacebookUser(this.id,
      {this.firstname,
      this.lastName,
      this.middleName,
      this.name,
      this.nameFormat,
      this.picture,
      this.shortName});

  // TODO JSON
}

class AppleUser {}
